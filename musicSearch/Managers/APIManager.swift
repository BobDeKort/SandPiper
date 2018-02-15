//
//  APIManager.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/15/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    static let instance = APIManager()
    
    let baseUrl = "https://music-search.herokuapp.com"
    
    func login(email: String, password: String, completionHandler: @escaping (Bool) -> ()) {
        if let url = URL(string: "\(baseUrl)/sessions?email=\(email)&password=\(password)") {
            // Make request from url
            var request = URLRequest(url: url)
            // Set HTTP method
            request.httpMethod = "GET"
            // Set content type
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Make request
            Alamofire.request(request).responseJSON { response in
                // Check if there is an error
                guard response.result.error == nil else {
                    print(response.result.error!)
                    completionHandler(false)
                    return
                }
                
                // Check if json returned is valid
                guard let json = response.result.value as? [String: AnyObject] else {
                    print("didn't Login")
                    completionHandler(false)
                    return
                }
                // Handle json
                
//                let decoder = JSONDecoder()
//                let user = try! decoder.decode(User.self, from: json)
//                print("User: \(user)")
                
                
                
                
                print("Login JSON: \(json)")
                completionHandler(true)
            }
        } else {
            print("No valid login url")
        }
    }
    
    func signUp(name: String, email: String, password: String, completionHandler: @escaping (Bool)->()) {
        if let url = URL(string: "\(baseUrl)/users") {
            // Setup params
            let params = ["name": name, "email": email, "password": password] as Dictionary<String, String>
            
            // Convert string to URL
            var request = URLRequest(url: url)
            // Set POST as http method
            request.httpMethod = "POST"
            // Add content type param
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // Convert and encode parameters
            let encoder = JSONEncoder()
            do {
                let jsonData = try encoder.encode(params)
                request.httpBody = jsonData
                print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
            } catch {
                print("Something went wrong encoding json")
            }
            
//            Alamofire.request(request).responseData(completionHandler: { (data) in
//
//                do {
//                    let decoder = JSONDecoder()
//                    let user = try decoder.decode(User.self, from: data.data!)
//                    print(user)
//                } catch let err {
//                    print("Err", err)
//                }
//            })
        
            
            
            // Make request
            Alamofire.request(request).responseJSON { response in
                // Check if there is an error
                guard response.result.error == nil else {
                    print(response.result.error!)
                    completionHandler(false)
                    return
                }

//                // Check if json returned is valid
//                guard let json = response.result.value as? [String: AnyObject] else {
//                    print("didn't sign up")
//                    completionHandler(false)
//                    return
//                }
                
                // Handle data, parse in User model
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: response.data!)
                    if let token = user.userToken {
                        KeyChainManager.instance.setUserToken(token: token)
                        completionHandler(true)
                    }
                } catch let err {
                    print("Err", err)
                    completionHandler(false)
                }
            }
        } else {
            print("No valid signup url")
        }
    }
}
