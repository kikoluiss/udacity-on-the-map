//
//  ParseConvenience.swift
//  On The Map
//
//  Created by Kiko Santos on 21/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import Foundation

extension LocationClient {
    
    func retrieveStudentLocations(completionHandlerForPinsList: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        var parameters = [String:AnyObject]()
        parameters["limit"] = 100 as AnyObject
        parameters["order"] = "-updatedAt" as AnyObject
        
        let _ = taskForGETMethod(Methods.StudentLocation, parameters: parameters) { (results, error) in
            if let error = error {
                completionHandlerForPinsList(false, "Failed to Load Pins: \(error.localizedDescription).")
            } else {
                if let locations = results?[LocationClient.JSONResponseKeys.Results] as? [[String:Any]] {

                    StudentInformationModel.sharedInstance().studentInformationArray = [StudentInformation]()
                    for location in locations {
                        let studentInformation = StudentInformation(infos: location)
                        StudentInformationModel.sharedInstance().studentInformationArray?.append(studentInformation)
                    }
                    
                    completionHandlerForPinsList(true, nil)
                } else {
                    completionHandlerForPinsList(true, "Could not find Results in response!")
                }
            }
        }
    }

    func retrieveStudentLocationWithKey(_ uniqueKey: String, completionHandlerForLocationWithKey: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        var parameters = [String:AnyObject]()
        parameters["where"] = "{\"uniqueKey\":\"\(uniqueKey)\"}" as AnyObject
        
        let _ = taskForGETMethod(Methods.StudentLocation, parameters: parameters) { (results, error) in
            if let error = error {
                completionHandlerForLocationWithKey(false, "Failed to Load Pins: \(error.localizedDescription).")
            } else {
                if let locations = results?[LocationClient.JSONResponseKeys.Results] as? [[String:Any]] {
                    let studentInformation = StudentInformation(infos: locations[0])
                    LocationClient.sharedInstance().objectId = studentInformation.objectId
                    completionHandlerForLocationWithKey(true, nil)
                } else {
                    completionHandlerForLocationWithKey(false, nil)
                }
            }
        }
    }

    func saveLocation(jsonBody: String, completionHandlerForSaveLocation: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let parameters = [String:AnyObject]()
        
        if let objectId = LocationClient.sharedInstance().objectId {
            
            let mutableMethod = substituteKeyInMethod(LocationClient.Methods.StudentLocationID, key: "id", value: objectId)
            
            let _ = LocationClient.sharedInstance().taskForPUTMethod(mutableMethod!, parameters: parameters, jsonBody: jsonBody) { (results, error) in
                if let error = error {
                    completionHandlerForSaveLocation(false, error.localizedDescription)
                }
                else {
                    completionHandlerForSaveLocation(true, nil)
                }
            }
        } else {
            let _ = LocationClient.sharedInstance().taskForPOSTMethod(LocationClient.Methods.StudentLocation, parameters: parameters, jsonBody: jsonBody) { (results, error) in
                if let error = error {
                    completionHandlerForSaveLocation(false, error.localizedDescription)
                }
                else {
                    completionHandlerForSaveLocation(true, nil)
                }
            }
        }

    }
}
