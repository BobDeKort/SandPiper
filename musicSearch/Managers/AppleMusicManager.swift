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
    func requestAuthorization() {
        SKCloudServiceController.requestAuthorization { (status) in
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
            print("canPlay")
            print(canPlay)
            print("canAdd")
            print(canAdd)
            print("canSubscribe")
            print(canSubscribe)
        }
    }
    
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
    
    func requestUserToken() {
        print("Request")
        cloudServiceController.requestUserToken(forDeveloperToken: Constants.developerKey) { (response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            if let response = response {
                print(response)
                KeyChainManager.instance.setAppleMusicToken(token: response)
            }
        }
    }
    
    
}
