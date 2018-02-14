//
//  AppleMusicManager.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/5/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import StoreKit

class AppleMusicManager {
    static let instance = AppleMusicManager()
    
    let cloudServiceController = SKCloudServiceController()
    
    // Request authorization from the user to access apple music
    func requestAuthorization(completionHandler: @escaping (SKCloudServiceAuthorizationStatus) -> ()) {
        SKCloudServiceController.requestAuthorization { (status) in
            completionHandler(status)
            switch status {
            case .authorized:
                print("Authorized")
                break
            case .denied:
                print("Denied")
                break
            case .notDetermined:
                print("not determinded")
                break
            case .restricted:
                print("restricted")
                break
            }
        }
    }
    
    // Request a list of capabilities the user can do and what we can do with the User token
    func requestCapabilities() {
        cloudServiceController.requestCapabilities { (capabilities, error) in
            guard error == nil else {
                print("error")
                print(error)
                return
            }
            print("Capabilities")
            print(capabilities)
            
            let canPlay = capabilities.contains(.musicCatalogPlayback)
            let canAdd = capabilities.contains(.addToCloudMusicLibrary)
            let canSubscribe = capabilities.contains(.musicCatalogSubscriptionEligible)
        }
    }
    
    // Request country the user account is assosiated with
    func requestCountryCode() {
        cloudServiceController.requestStorefrontCountryCode { (countryCode, error) in
            guard error == nil else {
                print("error")
                print(error)
                return
            }
            
            if let country = countryCode {
                print("Country")
                print(country)
            }
        }
    }
    
    // Request the user to authenticate with apple music to access more user specific information
    func requestUserToken(completionHandler: @escaping (Bool)->()) {
        cloudServiceController.requestUserToken(forDeveloperToken: Constants.developerKey) { (response, error) in
            guard error == nil else {
                print(error!)
                completionHandler(false)
                return
            }
            
            if let response = response {
                completionHandler(true)
                print("Apple Music Token: \(response))")
                KeyChainManager.instance.setAppleMusicToken(token: response)
            }
        }
    }
    
    
}
