//
//  SpatialSpanMemoryResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-06.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

extension CGPoint: StaticMappable {
    
    /// This is function that can be used to:
    ///		1) provide an existing cached object to be used for mapping
    ///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
    public static func objectForMapping(map: Map) -> BaseMappable? {
        return CGPoint()
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public mutating func mapping(map: Map) {
        x <- map["x"]
        y <- map["y"]
    }
    
}

extension ORKSpatialSpanMemoryGameTouchSample: StaticMappable {
    
    /// This is function that can be used to:
    ///		1) provide an existing cached object to be used for mapping
    ///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
    public static func objectForMapping(map: Map) -> BaseMappable? {
        return ORKSpatialSpanMemoryGameTouchSample()
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public func mapping(map: Map) {
        timestamp <- map["timestamp"]
        targetIndex <- map["targetIndex"]
        location <- map["location"]
        isCorrect <- map["correct"]
    }
    
}

class SpatialSpanMemoryGameStatusTransform: TransformType {
    
    typealias Object = ORKSpatialSpanMemoryGameStatus
    typealias JSON = String
    
    static let Failure = "Failure"
    static let Success = "Success"
    static let Timeout = "Timeout"
    static let Unknown = "Unknown"
    
    public func transformFromJSON(_ value: Any?) -> ORKSpatialSpanMemoryGameStatus? {
        if let value = value as? String {
            switch value {
            case SpatialSpanMemoryGameStatusTransform.Failure:
                return .failure
            case SpatialSpanMemoryGameStatusTransform.Success:
                return .success
            case SpatialSpanMemoryGameStatusTransform.Timeout:
                return .timeout
            case SpatialSpanMemoryGameStatusTransform.Unknown:
                return .unknown
            default:
                return nil
            }
        }
        return nil
    }
    
    public func transformToJSON(_ value: ORKSpatialSpanMemoryGameStatus?) -> String? {
        if let value = value {
            switch value {
            case .failure:
                return SpatialSpanMemoryGameStatusTransform.Failure
            case .success:
                return SpatialSpanMemoryGameStatusTransform.Success
            case .timeout:
                return SpatialSpanMemoryGameStatusTransform.Timeout
            case .unknown:
                return SpatialSpanMemoryGameStatusTransform.Unknown
            }
        }
        return nil
    }
    
}

class UInt32Transform: TransformType {
    
    typealias Object = UInt32
    typealias JSON = NSNumber
    
    public func transformFromJSON(_ value: Any?) -> UInt32? {
        if let value = value as? NSNumber {
            return value.uint32Value
        }
        return nil
    }
    
    public func transformToJSON(_ value: UInt32?) -> NSNumber? {
        if let value = value {
            return NSNumber(value: value)
        }
        return nil
    }
    
}

extension CGSize: StaticMappable {
    
    /// This is function that can be used to:
    ///		1) provide an existing cached object to be used for mapping
    ///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
    public static func objectForMapping(map: Map) -> BaseMappable? {
        return CGRect()
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public mutating func mapping(map: Map) {
        width <- map["width"]
        height <- map["height"]
    }
    
}

extension CGRect: StaticMappable {
    
    /// This is function that can be used to:
    ///		1) provide an existing cached object to be used for mapping
    ///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
    public static func objectForMapping(map: Map) -> BaseMappable? {
        return CGRect()
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public mutating func mapping(map: Map) {
        origin <- map["origin"]
        size <- map["size"]
    }
    
}

class NSValueArrayCGRectTransformer: TransformType {
    
    typealias Object = [NSValue]
    typealias JSON = [[String : Any]]
    
    public func transformFromJSON(_ value: Any?) -> [NSValue]? {
        return nil
    }
    
    public func transformToJSON(_ value: Array<NSValue>?) -> [[String : Any]]? {
        if let values = value {
            var rects = [[String : Any]]()
            for value in values {
                rects.append(value.cgRectValue.toJSON())
            }
            return rects
        }
        return nil
    }
    
}

extension ORKSpatialSpanMemoryGameRecord: StaticMappable {
    
    /// This is function that can be used to:
    ///		1) provide an existing cached object to be used for mapping
    ///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
    public static func objectForMapping(map: Map) -> BaseMappable? {
        return ORKSpatialSpanMemoryGameRecord()
    }

    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public func mapping(map: Map) {
        seed <- (map["seed"], UInt32Transform())
        sequence <- map["sequence"]
        gameSize <- map["gameSize"]
        targetRects <- (map["targetRects"], NSValueArrayCGRectTransformer())
        touchSamples <- map["touchSamples"]
        gameStatus <- map["gameStatus"]
        score <- map["score"]
    }
    
}

open class SpatialSpanMemoryResult: Result {
    
    @objc dynamic var score: Int = 0
    @objc dynamic var numberOfGames: Int = 0
    @objc dynamic var numberOfFailures: Int = 0
    @objc dynamic var gameRecords: [ORKSpatialSpanMemoryGameRecord]?
    
    convenience init(spatialSpanMemoryResult: ORKSpatialSpanMemoryResult) {
        self.init(result: spatialSpanMemoryResult)
        
        score = spatialSpanMemoryResult.score
        numberOfGames = spatialSpanMemoryResult.numberOfGames
        numberOfFailures = spatialSpanMemoryResult.numberOfFailures
        gameRecords = spatialSpanMemoryResult.gameRecords
    }
    
    override open class func collectionName() -> String {
        return "SpatialSpanMemoryResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        score <- map["score"]
        numberOfGames <- map["numberOfGames"]
        numberOfFailures <- map["numberOfFailures"]
        gameRecords <- map["gameRecords"]
    }
    
}
