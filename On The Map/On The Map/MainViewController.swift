//
//  MainViewController.swift
//  On The Map
//
//  Created by Kiko Santos on 21/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import UIKit

let tabMapNotificationKey = "br.com.fkl.tabMapNotificationKey"
let tabTableNotificationKey = "br.com.fkl.tabTableNotificationKey"

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func atemptToLogout(_ sender: Any) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        UdacityClient.sharedInstance().proceedToLogout() { (success, errorString) in
            UIViewController.removeSpinner(spinner: sv)
            performUIUpdatesOnMain {
                if success {
                    self.completeLogout()
                } else {
                    if let errorString = errorString {
                        GeneralUtilities.sharedInstance().displayError(errorString, self)
                    } else {
                        GeneralUtilities.sharedInstance().displayError("Unhandled error", self)
                    }
                }
            }
        }
    }
    
    @IBAction func refreshLocations(_ sender: Any) {
        if let tab = self.tabBar.selectedItem?.tag {
            if tab == 0 {
                NotificationCenter.default.post(name: Notification.Name(rawValue: tabMapNotificationKey), object: self)
            } else {
                NotificationCenter.default.post(name: Notification.Name(rawValue: tabTableNotificationKey), object: self)
            }
        }
    }
        
    @IBAction func atemptToAddLocation(_ sender: Any) {
        if let accountKey = UdacityClient.sharedInstance().accountKey {
            LocationClient.sharedInstance().retrieveStudentLocationWithKey(accountKey) { (overwrite, errorString) in
                performUIUpdatesOnMain {
                    if let errorString = errorString {
                        GeneralUtilities.sharedInstance().displayError(errorString, self)
                    } else {
                        if overwrite {
                            GeneralUtilities.sharedInstance().displayConfirmation("User has already posted a Student Location. Would you like to overwrite it?", "Overwrite", self) { () in
                                self.addLocationForm()
                            }
                        } else {
                            self.addLocationForm()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Login
    
    private func completeLogout() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Add Location
    
    private func addLocationForm() {
        self.performSegue(withIdentifier: "AddLocationSegue", sender: self)
    }

}
