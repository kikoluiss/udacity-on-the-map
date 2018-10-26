//
//  SaveLocationViewController.swift
//  On The Map
//
//  Created by Kiko Santos on 23/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import UIKit
import MapKit

class SaveLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var currLocation: StudentInformationToSend?
    
    var searchText: String?
    var mediaURL: String?

    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCompleter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let searchText = searchText {
            searchCompleter.queryFragment = searchText
        }
    }

    @IBAction func saveLocation(_ sender: Any) {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self.currLocation)
            if let jsonBody = String(data: jsonData, encoding: String.Encoding.utf8) {
                LocationClient.sharedInstance().saveLocation(jsonBody: jsonBody) { (success, errorString) in
                    performUIUpdatesOnMain {
                        if success {
                            self.completeSendLocation()
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
        } catch {
            print("Unexpected error: \(error).")
        }
    }

    func completeSendLocation() {
        self.currLocation = nil;
        self.navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name(rawValue: tabMapNotificationKey), object: self)
        NotificationCenter.default.post(name: Notification.Name(rawValue: tabTableNotificationKey), object: self)
    }
}

extension SaveLocationViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        let completion = searchResults[0]
        
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let coordinate = response?.mapItems[0].placemark.coordinate {

                let first = UdacityClient.sharedInstance().userFirstName
                let last = UdacityClient.sharedInstance().userLastName

                var annotations = [MKPointAnnotation]()
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = response?.mapItems[0].placemark.title
                
                annotations.append(annotation)
                
                self.mapView.addAnnotations(annotations)
                
                self.mapView.showAnnotations(annotations, animated: false)
                
                self.currLocation = StudentInformationToSend(infos: [
                    "uniqueKey": UdacityClient.sharedInstance().accountKey ?? "",
                    "firstName": first ?? "",
                    "lastName": last ?? "",
                    "mapString": response?.mapItems[0].placemark.title ?? "",
                    "mediaURL": self.mediaURL ?? "",
                    "latitude": Double(coordinate.latitude.description) ?? 0.0,
                    "longitude": Double(coordinate.longitude.description) ?? 0.0
                ])
                
            }
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        GeneralUtilities.sharedInstance().displayError(error.localizedDescription, self)
    }
    
}
