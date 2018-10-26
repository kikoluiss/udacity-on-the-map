//
//  UdacityConvenience.swift
//  On The Map
//
//  Created by Kiko Santos on 19/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import Foundation

extension UdacityClient {

    func authenticateWithCredentials(email: String, password: String, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let parameters = [String:AnyObject]()
        
        let jsonBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}"
        
        let _ = taskForPOSTMethod(Methods.Session, parameters: parameters, jsonBody: jsonBody) { (results, error) in

            if let error = error {
                completionHandlerForAuth(false, "Login Failed: \(error.localizedDescription).")
            } else {
                if let accountObject = results?[UdacityClient.JSONResponseKeys.Account] as? [String:Any],
                    let accountKey = accountObject[UdacityClient.JSONResponseKeys.AccountKey] as? String {
                    
                    self.accountKey = accountKey;
                    
                    self.retrieveUserDetails() { (results, error)
                        in
                        
                        if let error = error {
                            completionHandlerForAuth(false, "Login Failed: \(error.localizedDescription).")
                        } else {
                            if let userObject = results?[UdacityClient.JSONResponseKeys.User] as? [String:Any],
                                let firstName = userObject[UdacityClient.JSONResponseKeys.UserFirstName] as? String,
                                let lastName = userObject[UdacityClient.JSONResponseKeys.UserLastName] as? String {
                    
                                self.userFirstName = firstName
                                self.userLastName = lastName
                                self.userFullName = "\(firstName) \(lastName)"
                                
                                completionHandlerForAuth(true, nil)

                            } else {
                                completionHandlerForAuth(true, "Could not find User Details in response!")
                            }
                        }
                    }
                } else {
                    completionHandlerForAuth(true, "Could not find Account Key in response!")
                }
            }
        }

    }

    func retrieveUserDetails(completionHandlerForUserDetails: @escaping (_
        results: AnyObject?, _ error: NSError?) -> Void) {
    
        let parameters = [String:AnyObject]()

        var mutableMethod: String = Methods.UsersID
        mutableMethod = substituteKeyInMethod(mutableMethod, key: UdacityClient.URLKeys.UserID, value: String(UdacityClient.sharedInstance().accountKey!))!

        let _ = taskForGETMethod(mutableMethod, parameters: parameters) { (results, error) in
            completionHandlerForUserDetails(results, error)
        }
    }
    
    func proceedToLogout(completionHandlerForLogout: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let parameters = [String:AnyObject]()

        let _ = taskForDELETEMethod(Methods.Session, parameters: parameters) { (results, error) in
            if let error = error {
                completionHandlerForLogout(false, "Logout Failed: \(error.localizedDescription).")
            } else {
                self.accountKey = ""
                self.userFirstName = ""
                self.userLastName = ""
                self.userFullName = ""
                completionHandlerForLogout(true, nil)
            }
        }
    }

}
