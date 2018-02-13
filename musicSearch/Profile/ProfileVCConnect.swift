//
//  ProfileVCConnect.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/12/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import SafariServices

// APPLE MUSIC AND SPOTIFY LOGIN

extension ProfileViewController {
    // APPLE MUSIC LOGIN
    
    func authenticateAM() {
        AppleMusicManager.instance.requestAuthorization { (status) in
            if status == .authorized {
                AppleMusicManager.instance.requestUserToken(completionHandler: { (success) in
                    if success {
                        self.successfullLogin(service: "Apple Music")
                        print("Success logging in apple music")
                    } else {
                        print("Somthing went wrong with apple music login")
                    }
                })
            }
        }
    }
    
    // SPOTIFY LOGIN
    
    func authenticateSpotify() {
        // Before presenting the view controllers we are going to start watching for the notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receievedUrlFromSpotify(_:)),
                                               name: NSNotification.Name.Spotify.authURLOpened,
                                               object: nil)
        
        // Check to see if the user has Spotify installed
        if SPTAuth.supportsApplicationAuthentication() {
            // Open the Spotify app by opening its url
            SpotifyManager.instance.openSpotifyAuthentication()
        } else {
            // Present a web browser in the app that lets the user sign in to Spotify
            safariWebView = SFSafariViewController(url: SpotifyManager.instance.webURL)
            present(safariWebView!, animated: true, completion: nil)
        }
    }
    
    @objc func receievedUrlFromSpotify(_ notification: Notification) {
        guard let url = notification.object as? URL else { return }
        // Close the web view if it exists
        if let webView = safariWebView {
            webView.dismiss(animated: true, completion: nil)
        }
        
        // Remove the observer from the Notification Center
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.Spotify.authURLOpened,
                                                  object: nil)
        
        SPTAuth.defaultInstance().handleAuthCallback(withTriggeredAuthURL: url) { (error, session) in
            //Check if there is an error because then there won't be a session.
            if let error = error {
                print(error)
                return
            }
            
            // Check if there is a session
            if let session = session {
                print("Spotify Token: \(session.accessToken!))")
                KeyChainManager.instance.setSpotifyToken(token: session.accessToken)
                // If there is use it to login to the audio streaming controller where we can play music.
                // SPTAudioStreamingController.sharedInstance().login(withAccessToken: session.accessToken)
                
                // Updated the connect buttons to check box buttons
                self.successfullLogin(service: "Spotify")
            }
        }
    }
}
