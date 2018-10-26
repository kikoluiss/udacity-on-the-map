//
//  StudentInformation.swift
//  On The Map
//
//  Created by Kiko Santos on 26/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import Foundation

class StudentInformationModel: NSObject {
    var studentInformationArray: [StudentInformation]?

    // MARK: Shared Instance
    
    class func sharedInstance() -> StudentInformationModel {
        struct Singleton {
            static var sharedInstance = StudentInformationModel()
        }
        return Singleton.sharedInstance
    }
}

struct StudentInformation: Codable {
    var createdAt: String
    var firstName: String
    var lastName: String
    var latitude: Double
    var longitude: Double
    var mapString: String
    var mediaURL: String
    var objectId: String
    var uniqueKey: String
    var updatedAt: String
}

extension StudentInformation {
    init(infos : Dictionary<String,Any>) {
        createdAt = infos["createdAt"] as? String ?? ""
        firstName = infos["firstName"] as? String ?? ""
        lastName = infos["lastName"] as? String ?? ""
        latitude = infos["latitude"] as? Double ?? 0.0
        longitude = infos["longitude"] as? Double ?? 0.0
        mapString = infos["mapString"] as? String ?? ""
        mediaURL = infos["mediaURL"] as? String ?? ""
        objectId = infos["objectId"] as? String ?? ""
        uniqueKey = infos["uniqueKey"] as? String ?? ""
        updatedAt = infos["updatedAt"] as? String ?? ""
    }
}

struct StudentInformationToSend: Codable {
    var firstName: String
    var lastName: String
    var latitude: Double
    var longitude: Double
    var mapString: String
    var mediaURL: String
    var uniqueKey: String
}

extension StudentInformationToSend {
    init(infos : Dictionary<String,Any>) {
        firstName = infos["firstName"] as? String ?? ""
        lastName = infos["lastName"] as? String ?? ""
        latitude = infos["latitude"] as? Double ?? 0.0
        longitude = infos["longitude"] as? Double ?? 0.0
        mapString = infos["mapString"] as? String ?? ""
        mediaURL = infos["mediaURL"] as? String ?? ""
        uniqueKey = infos["uniqueKey"] as? String ?? ""
    }
}
