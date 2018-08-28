//
//  HolePegTestResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-06.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

extension ORKHolePegTestSample: StaticMappable {
    /// This is function that can be used to:
    ///		1) provide an existing cached object to be used for mapping
    ///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
    public static func objectForMapping(map: Map) -> BaseMappable? {
        return ORKHolePegTestSample()
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public func mapping(map: Map) {
        time <- map["time"]
        distance <- map["distance"]
    }
    
}

class BodySagittalTransform: TransformType {
    
    typealias Object = ORKBodySagittal
    typealias JSON = String
    
    static let Left = "Left"
    static let Right = "Right"
    
    public func transformFromJSON(_ value: Any?) -> ORKBodySagittal? {
        if let value = value as? String {
            switch value {
            case BodySagittalTransform.Left:
                return .left
            case BodySagittalTransform.Right:
                return .right
            default:
                return nil
            }
        }
        return nil
    }
    
    public func transformToJSON(_ value: ORKBodySagittal?) -> String? {
        if let value = value {
            switch value {
            case .left:
                return BodySagittalTransform.Left
            case .right:
                return BodySagittalTransform.Right
            }
        }
        return nil
    }
    
}

open class HolePegTestResult: Result {
    
    @objc dynamic var movingDirection: ORKBodySagittal = .left
    @objc dynamic var dominantHandTested: Bool = false
    @objc dynamic var numberOfPegs: Int = 0
    @objc dynamic var threshold: Double = 0
    @objc dynamic var rotated: Bool = false
    @objc dynamic var totalSuccesses: Int = 0
    @objc dynamic var totalFailures: Int = 0
    @objc dynamic var totalTime: TimeInterval = 0
    @objc dynamic var totalDistance: Double = 0
    @objc dynamic var samples: [ORKHolePegTestSample]?
    
    convenience init(holePegTestResult: ORKHolePegTestResult) {
        self.init(result: holePegTestResult)
        
        movingDirection = holePegTestResult.movingDirection
        dominantHandTested = holePegTestResult.isDominantHandTested
        numberOfPegs = holePegTestResult.numberOfPegs
        threshold = holePegTestResult.threshold
        rotated = holePegTestResult.isRotated
        totalSuccesses = holePegTestResult.totalSuccesses
        totalFailures = holePegTestResult.totalFailures
        totalTime = holePegTestResult.totalTime
        totalDistance = holePegTestResult.totalDistance
        samples = holePegTestResult.samples?.map { $0 as! ORKHolePegTestSample }
    }
    
    override open class func collectionName() -> String {
        return "HolePegTestResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        movingDirection <- (map["movingDirection"], BodySagittalTransform())
        dominantHandTested <- map["dominantHandTested"]
        numberOfPegs <- map["numberOfPegs"]
        threshold <- map["threshold"]
        rotated <- map["rotated"]
        totalSuccesses <- map["totalSuccesses"]
        totalFailures <- map["totalFailures"]
        totalTime <- map["totalTime"]
        totalDistance <- map["totalDistance"]
        samples <- map["samples"]
    }
    
}
