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
    // Web view for when the phone does not have spotify installed
    var safariWebView: SFSafariViewController?

    // IBOutlets for connect buttons
    @IBOutlet weak var spotifyConnectButton: UIButton!
    @IBOutlet weak var appleMusicConnectButton: UIButton!
    
    // IBOutlet for search history table view
    @IBOutlet weak var historyTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    // IBActions for connect buttons
    @IBAction func spotifyLogin(_ sender: Any) {
        authenticateSpotify()
    }
    
    @IBAction func AMLogin(_ sender: Any) {
        authenticateAM()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkButtonStates()
        titleLabel.sizeToFit()
        historyTableView.dataSource = self
    }
    
    // Alert handeling
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
    
    func successfullLogin(service: String) {
        DispatchQueue.main.async {
            // Present next view controller or use performSegue(withIdentifier:, sender:)
            // self.present(MainViewController(), animated: true, completion: nil)
            
            if service == "Apple Music" {
                self.updateAppleMusciButtonState()
            } else if service == "Spotify" {
                self.updateSpotifyButtonState()
            }
            
            let alertController = UIAlertController(title: "Success", message: "You have been logged in to \(service)", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

