//
//  SpotifyManager.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/5/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

class SpotifyManager {
    static let instance = SpotifyManager()
    let appURL = SPTAuth.defaultInstance().spotifyAppAuthenticationURL()!
    let webURL = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()!
    
    func openSpotifyAuthentication() {
        UIApplication.shared.open(SpotifyManager.instance.appURL, options: [:], completionHandler: nil)
    }
}
