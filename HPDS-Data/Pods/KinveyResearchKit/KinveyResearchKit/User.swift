//
//  User.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-08.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import Kinvey
import ObjectMapper

@objc
open class KinveyUser: Kinvey.User {
    
    var givenName: String?
    var familyName: String?
    var gender: String?
    var dateOfBirth: Date?
    
    open override func mapping(map: Map) {
        super.mapping(map: map)
        
        givenName <- map["givenName"]
        familyName <- map["familyName"]
        gender <- map["gender"]
        dateOfBirth <- (map["dateOfBirth"], ISO8601DateTransform())
    }
    
}
