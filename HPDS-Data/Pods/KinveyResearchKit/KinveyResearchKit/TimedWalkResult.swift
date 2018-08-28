//
//  TimedWalkResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-06.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

open class TimedWalkResult: Result {
    
    @objc dynamic var distanceInMeters: Double = 0
    @objc dynamic var timeLimit: TimeInterval = 0
    @objc dynamic var duration: TimeInterval = 0
    
    convenience init(timedWalkResult: ORKTimedWalkResult) {
        self.init(result: timedWalkResult)
        
        distanceInMeters = timedWalkResult.distanceInMeters
        timeLimit = timedWalkResult.timeLimit
        duration = timedWalkResult.duration
    }
    
    override open class func collectionName() -> String {
        return "TimedWalkResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        distanceInMeters <- map["distanceInMeters"]
        timeLimit <- map["timeLimit"]
        duration <- map["duration"]
    }
    
}
