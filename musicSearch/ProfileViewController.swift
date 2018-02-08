//
//  SecondViewController.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/1/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit
import SafariServices
import StoreKit

class ProfileViewController: UIViewController {

    @IBAction func spotifyLogin(_ sender: Any) {
        authenticateSpotify()
    }
    
    @IBAction func AMLogin(_ sender: Any) {
        authenticateAM()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func displayErrorMessage(error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error",
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func successfullLogin() {
        DispatchQueue.main.async {
            // Present next view controller or use performSegue(withIdentifier:, sender:)
            // self.present(MainViewController(), animated: true, completion: nil)
            
            let alertController = UIAlertController(title: "Success", message: "You have been logged in to Spotify", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // APPLE MUSIC LOGIN
    
    func authenticateAM() {
        //AppleMusicManager.instance.requestAuthorization()
        AppleMusicManager.instance.requestUserToken()
        //AppleMusicManager.instance.requestCapabilities()
        //AppleMusicManager.instance.requestCountryCode()
    }
    
    // SPOTIFY LOGIN
    
    func authenticateSpotify() {
        let appURL = SPTAuth.defaultInstance().spotifyAppAuthenticationURL()!
        let webURL = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()!
        
        // Before presenting the view controllers we are going to start watching for the notification
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receievedUrlFromSpotify(_:)),
                                               name: NSNotification.Name.Spotify.authURLOpened,
                                               object: nil)
        
        //Check to see if the user has Spotify installed
        if SPTAuth.supportsApplicationAuthentication() {
            //Open the Spotify app by opening its url
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            //Present a web browser in the app that lets the user sign in to Spotify
            present(SFSafariViewController(url: webURL), animated: true, completion: nil)
        }
    }
    
    @objc func receievedUrlFromSpotify(_ notification: Notification) {
        guard let url = notification.object as? URL else { return }
        print(url)
        // Close the web view if it exists
        // spotifyAuthWebView?.dismiss(animated: true, completion: nil)
        
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
                
                KeyChainManager.instance.setSpotifyToken(token: session.accessToken)
                // If there is use it to login to the audio streaming controller where we can play music.
                // SPTAudioStreamingController.sharedInstance().login(withAccessToken: session.accessToken)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

