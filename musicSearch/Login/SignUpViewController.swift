//
//  SignUpViewController.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/15/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    // Text fields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // Buttons
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // Button Actions
    @IBAction func signUpAction(_ sender: Any) {
        checkFields()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    var parentVC: LoginViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    func signUp(name: String, email: String, password: String) {
        APIManager.instance.signUp(name: name, email: email, password: password) { (success) in
            let alert = UIAlertController(title: "Success", message: "Login sign up has been succesful", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: self.moveToMain))
            self.present(alert, animated: true, completion: nil)
            print("SUCCESS: \(success)")
        }
    }
    
    func checkFields() {
        guard let name = nameTextField.text else {
            print("no name")
            presentAlert(message: "No Name given", title: "Oops!")
            return
        }
        guard let email = emailTextField.text else {
            print("no email")
            presentAlert(message: "No email given", title: "Oops!")
            return
        }
        guard let password = passwordTextField.text else {
            print("no password")
            presentAlert(message: "No password given", title: "Oops!")
            return
        }
        guard let confirmedPassword = confirmPasswordTextField.text else {
            print("no confirmed password")
            presentAlert(message: "No confirmed password given", title: "Oops!")
            return
        }
        
        if password != confirmedPassword {
            print("Passwords do not match")
            presentAlert(message: "Passwords do not match", title: "Oops!")
            return
        } else if password.count <= 5 {
            print("Password to short")
            presentAlert(message: "Password to short", title: "Oops!")
            return
        } else {
            signUp(name: name, email: email, password: password)
        }
    }
    
    func presentAlert(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func moveToMain(alert: UIAlertAction?) {
        if let parent = parentVC {
            parent.changeRootVC()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
