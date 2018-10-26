//
//  TabMapViewController.swift
//  On The Map
//
//  Created by Kiko Santos on 21/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import UIKit
import MapKit

class TabMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadLocations), name: NSNotification.Name(rawValue: tabMapNotificationKey), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        if StudentInformationModel.sharedInstance().studentInformationArray == nil {
            self.loadLocations()
        }
    }
    
    @objc func loadLocations() {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        let sv = UIViewController.displaySpinner(onView: self.view)
        LocationClient.sharedInstance().retrieveStudentLocations() { (success, errorString) in
            UIViewController.removeSpinner(spinner: sv)
            if success {
                self.setPinsOnMap()
            } else {
                if let errorString = errorString {
                    GeneralUtilities.sharedInstance().displayError(errorString, self)
                } else {
                    GeneralUtilities.sharedInstance().displayError("Unknown error", self)
                }
            }
        }
    }
    
    func setPinsOnMap() {
        
        if let locations = StudentInformationModel.sharedInstance().studentInformationArray {
            
            var annotations = [MKPointAnnotation]()
            
            for location in locations {
                
                // Notice that the float values are being used to create CLLocationDegree values.
                // This is a version of the Double type.
                let lat = CLLocationDegrees(location.latitude)
                let long = CLLocationDegrees(location.longitude)
                
                // The lat and long are used to create a CLLocationCoordinates2D instance.
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let first = location.firstName
                let last = location.lastName
                let mediaURL = location.mediaURL
                
                // Here we create the annotation and set its coordiate, title, and subtitle properties
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                
                // Finally we place the annotation in an array of annotations.
                annotations.append(annotation)
            }
            
            // When the array is complete, we add the annotations to the map.
            self.mapView.addAnnotations(annotations)

        }
    }
}
