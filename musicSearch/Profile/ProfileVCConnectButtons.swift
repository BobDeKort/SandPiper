//
//  ProfileVCConnectButtons.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/12/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

extension ProfileViewController {
    // MARK: Checks and updates the button states
    func checkButtonStates() {
        updateSpotifyButtonState()
        updateAppleMusciButtonState()
    }
    
    func updateSpotifyButtonState() {
        if KeyChainManager.instance.getSpotifyToken() != nil {
            setCheckboxSpotifyButton()
        } else {
            setConnectSpotifyButton()
        }
    }
    
    func updateAppleMusciButtonState() {
        if KeyChainManager.instance.getAppleMusicToken() != nil {
            setCheckboxAppleMusicButton()
        } else {
            setConnectAppleMusicButton()
        }
    }
    
    // MARK: Sets buttons to the connect state
    func setConnectSpotifyButton() {
        spotifyConnectButton.setImage(nil, for: .normal)
        spotifyConnectButton.setTitle("Connect", for: .normal)
        addBordersToConnectButton(button: spotifyConnectButton)
        spotifyConnectButton.isHidden = false
        
    }
    
    func setConnectAppleMusicButton() {
        appleMusicConnectButton.setImage(nil, for: .normal)
        appleMusicConnectButton.setTitle("Connect", for: .normal)
        addBordersToConnectButton(button: appleMusicConnectButton)
        appleMusicConnectButton.isHidden = false
    }
    
    // MARK: Sets buttons to checked state
    func setCheckboxSpotifyButton() {
        spotifyConnectButton.setTitle("", for: .normal)
        spotifyConnectButton.setImage(#imageLiteral(resourceName: "CheckBox"), for: .normal)
        spotifyConnectButton.layer.borderWidth = 0
        spotifyConnectButton.imageView?.contentMode = .scaleAspectFit
    }
    
    func setCheckboxAppleMusicButton() {
        appleMusicConnectButton.setTitle("", for: .normal)
        appleMusicConnectButton.setImage(#imageLiteral(resourceName: "CheckBox"), for: .normal)
        appleMusicConnectButton.layer.borderWidth = 0
        appleMusicConnectButton.imageView?.contentMode = .scaleAspectFit
    }
    
    // Adds a rounded border to the button in the apps yellow color
    func addBordersToConnectButton(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.69, green:0.51, blue: 0.12, alpha: 1.0).cgColor
        button.layer.cornerRadius = spotifyConnectButton.frame.height / 2
    }
}
