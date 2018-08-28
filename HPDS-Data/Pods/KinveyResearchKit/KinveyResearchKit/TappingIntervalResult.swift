//
//  TappingIntervalResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-06.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

class TappingButtonIdentifierTransform: TransformType {
    
    typealias Object = ORKTappingButtonIdentifier
    typealias JSON = String
    
    static let None = "None"
    static let Left = "Left"
    static let Right = "Right"
    
    public func transformFromJSON(_ value: Any?) -> ORKTappingButtonIdentifier? {
        if let value = value as? String {
            switch value {
            case TappingButtonIdentifierTransform.None:
                return .none
            case TappingButtonIdentifierTransform.Left:
                return .left
            case TappingButtonIdentifierTransform.Right:
                return .right
            default:
                return nil
            }
        }
        return nil
    }
    
    public func transformToJSON(_ value: ORKTappingButtonIdentifier?) -> String? {
        if let value = value {
            switch value {
            case .none:
                return TappingButtonIdentifierTransform.None
            case .left:
                return TappingButtonIdentifierTransform.Left
            case .right:
                return TappingButtonIdentifierTransform.Right
            }
        }
        return nil
    }
    
}

extension ORKTappingSample: StaticMappable {
    
    /// This is function that can be used to:
    ///		1) provide an existing cached object to be used for mapping
    ///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
    public static func objectForMapping(map: Map) -> BaseMappable? {
        return ORKTappingSample()
    }

    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public func mapping(map: Map) {
        timestamp <- map["timestamp"]
        buttonIdentifier <- (map["buttonIdentifier"], TappingButtonIdentifierTransform())
        location <- map["location"]
    }
    
}

open class TappingIntervalResult: Result {
    
    @objc dynamic var samples: [ORKTappingSample]?
    @objc dynamic var stepViewSize: CGSize = CGSize.zero
    @objc dynamic var buttonRect1: CGRect = CGRect.zero
    @objc dynamic var buttonRect2: CGRect = CGRect.zero
    
    convenience init(tappingIntervalResult: ORKTappingIntervalResult) {
        self.init(result: tappingIntervalResult)
        
        samples = tappingIntervalResult.samples
        stepViewSize = tappingIntervalResult.stepViewSize
        buttonRect1 = tappingIntervalResult.buttonRect1
        buttonRect2 = tappingIntervalResult.buttonRect2
    }
    
    override open class func collectionName() -> String {
        return "TappingIntervalResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        samples <- map["samples"]
        stepViewSize <- map["stepViewSize"]
        buttonRect1 <- map["buttonRect1"]
        buttonRect2 <- map["buttonRect2"]
    }
    
    override open class func ignoredProperties() -> [String] {
        var ignoredProperties = super.ignoredProperties()
        ignoredProperties.append("stepViewSize")
        ignoredProperties.append("buttonRect1")
        ignoredProperties.append("buttonRect2")
        return ignoredProperties
    }
    
}
