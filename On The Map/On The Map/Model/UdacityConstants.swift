//
//  UdacityConstants.swift
//  On The Map
//
//  Created by Kiko Santos on 19/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import Foundation

extension UdacityClient {

    // MARK: Constants
    struct Constants {
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
        
    }

    // MARK: Methods
    struct Methods {

        static let Session = "/session"
        static let UsersID = "/users/{id}"

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
        
        // MARK: Authorization
        static let Session = "session"
        static let SessionID = "id"
        
        // MARK: Account
        static let Account = "account"
        static let AccountKey = "key"
        
        // MARK: User
        static let User = "user"
        static let UserFirstName = "first_name"
        static let UserLastName = "last_name"
    
    }
    
}
