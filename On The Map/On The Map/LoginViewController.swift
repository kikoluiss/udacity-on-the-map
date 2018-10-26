//
//  LoginViewController.swift
//  On The Map
//
//  Created by Kiko Santos on 19/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: BorderedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions

    @IBAction func attemptToLogin(_ sender: Any) {
       
        if let email = emailTextField.text, let password = passwordTextField.text {
            if !email.isEmpty && !password.isEmpty {
                let sv = UIViewController.displaySpinner(onView: self.view)
                UdacityClient.sharedInstance().authenticateWithCredentials(email: email, password: password) { (success, errorString) in
                    UIViewController.removeSpinner(spinner: sv)
                    performUIUpdatesOnMain {
                        if success {
                            self.completeLogin()
                        } else {
                            if let errorString = errorString {
                                GeneralUtilities.sharedInstance().displayError(errorString, self)
                            } else {
                                GeneralUtilities.sharedInstance().displayError("Unknown error", self)
                            }
                        }
                    }
                }
            } else {
                GeneralUtilities.sharedInstance().displayError("Email and/or Password can not be empty!", self)
            }
        } else {
            GeneralUtilities.sharedInstance().displayError("Email and/or Password can not be null!", self)
        }
    }
    
    // MARK: Login
    
    private func completeLogin() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "RootForMainViewController") as! UINavigationController
        present(controller, animated: true, completion: nil)
    }

}

// MARK: - LoginViewController (Configure UI)

private extension LoginViewController {
    
    func setUIEnabled(_ enabled: Bool) {
        loginButton.isEnabled = enabled
        emailTextField.isEnabled = enabled
        passwordTextField.isEnabled = enabled
        
        // adjust login button alpha
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
    
}
