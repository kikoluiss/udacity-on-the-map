//
//  ParseConstants.swift
//  On The Map
//
//  Created by Kiko Santos on 19/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import Foundation

extension LocationClient {

    // MARK: Constants
    struct Constants {

        // MARK: API Data
        static let ApiId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"

        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"

    }

    // MARK: Methods
    struct Methods {
        
        static let StudentLocation = "/StudentLocation"
        static let StudentLocationID = "/StudentLocation/{id}"

    }
    
    // MARK: URL Keys
    struct URLKeys {
        static let UserID = "id"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        static let Results = "results"
        
    }

}
