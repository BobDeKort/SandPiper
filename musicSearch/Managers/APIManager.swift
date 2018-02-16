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
    
    #if DEBUG
    let baseUrl = "https://music-search.herokuapp.com"
    #else
    let baseUrl = "https://music-search.herokuapp.com"
    #endif
    
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
                
                // Handle data, parse in User model
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: response.data!)
                    if let token = user.userToken {
                        print("Token: \(token)")
                        KeyChainManager.instance.setUserToken(token: token)
                        completionHandler(true)
                    }
                } catch let err {
                    print("Err", err)
                    completionHandler(false)
                }
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
                
            } catch {
                print("Something went wrong encoding json")
            }
            
            // Make request
            Alamofire.request(request).response { response in
                // Check if there is an error
                print("Response")
                
                guard response.error == nil else {
                    print(response.error!)
                    completionHandler(false)
                    return
                }

                // Handle data, parse in User model
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(User.self, from: response.data!)
                    if let token = user.userToken {
                        print("Token: \(token)")
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
