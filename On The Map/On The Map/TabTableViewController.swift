//
//  TabTableViewController.swift
//  On The Map
//
//  Created by Kiko Santos on 21/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import UIKit

class TabTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        NotificationCenter.default.addObserver(self, selector: #selector(loadLocations), name: NSNotification.Name(rawValue: tabTableNotificationKey), object: nil)
        
        if StudentInformationModel.sharedInstance().studentInformationArray == nil {
            self.loadLocations()
        }
        
    }
    
    @objc func loadLocations() {
        let sv = UIViewController.displaySpinner(onView: self.view)
        LocationClient.sharedInstance().retrieveStudentLocations() { (success, errorString) in
            UIViewController.removeSpinner(spinner: sv)
            performUIUpdatesOnMain {
                if success {
                    self.tableView.reloadData()
                } else {
                    if let errorString = errorString {
                        GeneralUtilities.sharedInstance().displayError(errorString, self)
                    } else {
                        GeneralUtilities.sharedInstance().displayError("Unknown error", self)
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let locations = StudentInformationModel.sharedInstance().studentInformationArray {
            return locations.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TabTableViewCellIdentifier", for: indexPath) as! TabTableViewCell

        if let locations = StudentInformationModel.sharedInstance().studentInformationArray {

            let first = locations[indexPath.row].firstName
            let last = locations[indexPath.row].lastName
            let mediaURL = locations[indexPath.row].mediaURL

            cell.titleLabel.text = "\(first) \(last)"
            cell.subtitleLabel.text = mediaURL
            
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let locations = StudentInformationModel.sharedInstance().studentInformationArray,
            let url = URL(string: locations[indexPath.row].mediaURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
