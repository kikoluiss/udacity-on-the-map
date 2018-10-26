//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by Kiko Santos on 21/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        if locationTextField.text == "" {
            GeneralUtilities.sharedInstance().displayError("Location can not be empty!", self)
        }
        if let link = linkTextField.text, link.isValidURL {
            self.performSegue(withIdentifier: "SaveLocationSegue", sender: self)
        } else {
            GeneralUtilities.sharedInstance().displayError("You must provide a valid Link!", self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveLocationSegue" {
            if let vc = segue.destination as? SaveLocationViewController {
                vc.searchText = locationTextField.text
                vc.mediaURL = linkTextField.text
            }
        }
    }
}
