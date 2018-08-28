//
//  TimeIntervalQuestionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-26.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

open class TimeIntervalQuestionResult: QuestionResult {
    
    @objc dynamic var intervalAnswer: NSNumber?
    
    convenience init(timeIntervalQuestionResult: ORKTimeIntervalQuestionResult) {
        self.init(questionResult: timeIntervalQuestionResult)
        
        intervalAnswer = timeIntervalQuestionResult.intervalAnswer
    }
    
    override open class func collectionName() -> String {
        return "TimeIntervalQuestionResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        intervalAnswer <- map["intervalAnswer"]
    }
    
}
