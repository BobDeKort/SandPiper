//
//  KeyChainManager.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/5/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import KeychainSwift

class KeyChainManager {
    // Singleton instance
    static let instance = KeyChainManager()
    
    // Main Keychain manager
    let keychain = KeychainSwift()
    
    // Token keys
    let appleMusicKey = "AppleMusicToken"
    let spotifyKey = "SpotifyToken"
    let userToken = "UserToken"
    
    func deleteAppleMusicToken() {
        keychain.delete(appleMusicKey)
    }
    
    func deleteSpotifyToken() {
        keychain.delete(spotifyKey)
    }
    
    func deleteUserToken() {
        keychain.delete(userToken)
    }
    
    // Set the user token to keychain
    func setUserToken(token: String) {
        keychain.set(token, forKey: userToken)
    }
    
    // Store the token received from apple music in Keychain
    func setAppleMusicToken(token: String) {
        keychain.set(token, forKey: appleMusicKey)
    }
    
    // Store the token received from spotify in Keychain
    func setSpotifyToken(token: String ) {
        keychain.set(token, forKey: spotifyKey)
    }
    
    // Retrieve the user token from keychain
    func getUserToken() -> String? {
        if let token = keychain.get(userToken){
            return token
        }
        return nil
    }
    
    // Retrieve the apple music token from keychain
    func getAppleMusicToken() -> String? {
        if let token = keychain.get(appleMusicKey){
            return token
        }
        return nil
    }
    
    // Retriece the spotify token from keychain
    func getSpotifyToken() -> String? {
        if let token = keychain.get(spotifyKey) {
            return token
        }
        return nil
    }
}
