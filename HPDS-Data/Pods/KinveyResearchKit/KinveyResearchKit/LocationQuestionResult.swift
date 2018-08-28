//
//  LocationQuestionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-04.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

class CircularRegionTransform: TransformType {
    
    typealias Object = CLCircularRegion
    typealias JSON = [String : Any]
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            var json = JSON()
            json["center"] = value.center.toJSON()
            json["radius"] = value.radius
            json["identifier"] = value.identifier
            return json
        }
        return nil
    }
    
}

extension CLLocationCoordinate2D: Mappable {
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public init?(map: Map) {
        var latitude: CLLocationDegrees?
        var longitude: CLLocationDegrees?
        
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        
        guard latitude != nil, longitude != nil else {
            return nil
        }
        self.init()
    }

    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public mutating func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
    
}

class LocationTransform: TransformType {
    
    typealias Object = ORKLocation
    typealias JSON = [String : Any]
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        return nil
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            var json = JSON()
            json["coordinate"] = value.coordinate.toJSON()
            json["region"] = CircularRegionTransform().transformToJSON(value.region)
            json["userInput"] = value.userInput
            return json
        }
        return nil
    }
    
}

open class LocationQuestionResult: QuestionResult {
    
    @objc dynamic var locationAnswer: ORKLocation?
    
    convenience init(locationQuestionResult: ORKLocationQuestionResult) {
        self.init(questionResult: locationQuestionResult)
        
        locationAnswer = locationQuestionResult.locationAnswer
    }
    
    override open class func collectionName() -> String {
        return "LocationQuestionResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        locationAnswer <- (map["locationAnswer"], LocationTransform())
    }
    
}
