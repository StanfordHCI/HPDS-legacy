//
//  TimeOfDayQuestionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-05.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

extension DateComponents: Mappable {
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public init?(map: Map) {
        self.init()
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public mutating func mapping(map: Map) {
        calendar <- map["calendar"]
        timeZone <- map["timeZone"]
        era <- map["era"]
        year <- map["year"]
        month <- map["month"]
        day <- map["day"]
        hour <- map["hour"]
        minute <- map["minute"]
        second <- map["second"]
        nanosecond <- map["nanosecond"]
        weekday <- map["weekday"]
        weekdayOrdinal <- map["weekdayOrdinal"]
        quarter <- map["quarter"]
        weekOfMonth <- map["weekOfMonth"]
        weekOfYear <- map["weekOfYear"]
        yearForWeekOfYear <- map["yearForWeekOfYear"]
        isLeapMonth <- map["isLeapMonth"]
    }
    
}

open class TimeOfDayQuestionResult: QuestionResult {
    
    @objc dynamic var dateComponentsAnswer: DateComponents?
    
    convenience init(timeOfDayQuestionResult: ORKTimeOfDayQuestionResult) {
        self.init(questionResult: timeOfDayQuestionResult)
        
        dateComponentsAnswer = timeOfDayQuestionResult.dateComponentsAnswer
    }
    
    override open class func collectionName() -> String {
        return "TimeOfDayQuestionResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        dateComponentsAnswer <- map["dateComponentsAnswer"]
    }
    
}
