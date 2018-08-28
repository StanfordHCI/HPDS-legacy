//
//  PSATResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-06.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

extension ORKPSATSample: StaticMappable {

    /// This is function that can be used to:
    ///		1) provide an existing cached object to be used for mapping
    ///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
    public static func objectForMapping(map: Map) -> BaseMappable? {
        return ORKPSATSample()
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public func mapping(map: Map) {
        isCorrect <- map["correct"]
        digit <- map["digit"]
        answer <- map["answer"]
        time <- map["time"]
    }
    
}

open class PSATResult: Result {
    
    @objc dynamic var presentationMode: ORKPSATPresentationMode = []
    @objc dynamic var interStimulusInterval: TimeInterval = 0
    @objc dynamic var stimulusDuration: TimeInterval = 0
    @objc dynamic var length: Int = 0
    @objc dynamic var totalCorrect: Int = 0
    @objc dynamic var totalDyad: Int = 0
    @objc dynamic var totalTime: TimeInterval = 0
    @objc dynamic var initialDigit: Int = 0
    @objc dynamic var samples: [ORKPSATSample]?
    
    convenience init(psatResult: ORKPSATResult) {
        self.init(result: psatResult)
        
        presentationMode = psatResult.presentationMode
        interStimulusInterval = psatResult.interStimulusInterval
        stimulusDuration = psatResult.stimulusDuration
        length = psatResult.length
        totalCorrect = psatResult.totalCorrect
        totalDyad = psatResult.totalDyad
        totalTime = psatResult.totalTime
        initialDigit = psatResult.initialDigit
        samples = psatResult.samples
    }
    
    override open class func collectionName() -> String {
        return "PSATResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        presentationMode <- map["presentationMode"]
        interStimulusInterval <- map["interStimulusInterval"]
        stimulusDuration <- map["stimulusDuration"]
        length <- map["length"]
        totalCorrect <- map["totalCorrect"]
        totalDyad <- map["totalDyad"]
        totalTime <- map["totalTime"]
        initialDigit <- map["initialDigit"]
        samples <- map["samples"]
    }
    
}
