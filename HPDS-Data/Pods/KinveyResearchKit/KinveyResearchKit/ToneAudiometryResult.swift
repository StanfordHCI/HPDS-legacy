//
//  ToneAudiometryResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-06.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

class AudioChannelTransform: TransformType {
    
    typealias Object = ORKAudioChannel
    typealias JSON = String
    
    static let Left = "Left"
    static let Right = "Right"
    
    public func transformFromJSON(_ value: Any?) -> ORKAudioChannel? {
        if let value = value as? String {
            switch value {
            case AudioChannelTransform.Left:
                return .left
            case AudioChannelTransform.Right:
                return .right
            default:
                return nil
            }
        }
        return nil
    }
    
    public func transformToJSON(_ value: ORKAudioChannel?) -> String? {
        if let value = value {
            switch value {
            case .left:
                return AudioChannelTransform.Left
            case .right:
                return AudioChannelTransform.Right
            }
        }
        return nil
    }
    
}

extension ORKToneAudiometrySample: StaticMappable {
    
    /// This is function that can be used to:
    ///		1) provide an existing cached object to be used for mapping
    ///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
    public static func objectForMapping(map: Map) -> BaseMappable? {
        return ORKToneAudiometrySample()
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public func mapping(map: Map) {
        frequency <- map["frequency"]
        channel <- (map["channel"], AudioChannelTransform())
        amplitude <- map["amplitude"]
    }
    
}

open class ToneAudiometryResult: Result {
    
    @objc dynamic var outputVolume: NSNumber?
    @objc dynamic var samples: [ORKToneAudiometrySample]?
    
    convenience init(toneAudiometryResult: ORKToneAudiometryResult) {
        self.init(result: toneAudiometryResult)
        
        outputVolume = toneAudiometryResult.outputVolume
        samples = toneAudiometryResult.samples
    }
    
    override open class func collectionName() -> String {
        return "ToneAudiometryResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        outputVolume <- map["outputVolume"]
        samples <- map["samples"]
    }
    
}
