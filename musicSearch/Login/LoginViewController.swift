//
//  LoginViewController.swift
//  musicSearch
//
//  Created by Bob De Kort on 2/15/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBAction func loginAction(_ sender: Any) {
        checkFields()
    }
    
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkFields(){
        guard let email = emailTextField.text else {
            presentAlert(message: "Email can't be blank")
            return
        }
        
        guard let password = passwordTextField.text else {
            presentAlert(message: "Password can't be blank")
            return
        }
        
        APIManager.instance.login(email: email, password: password) { (success) in
            self.changeRootVC()
            print("Login: \(success)")
        }
    }
    
    func changeRootVC() {
        if let window = window {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            window.rootViewController = vc
        }
    }
    
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Ooops!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUp" {
            let vc = segue.destination as? SignUpViewController
            vc?.parentVC = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
