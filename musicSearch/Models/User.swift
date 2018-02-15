//
//  User.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/15/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var email: String
    
    var userToken: String?
    var appleMusicToken: String?
    var spotifyToken: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case userToken = "token"
        case appleMusicToken = "apple_music_token"
        case spotifyToken = "spotify_token"
    }
}
