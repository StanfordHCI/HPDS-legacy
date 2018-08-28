//
//  BooleanQuestionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-04.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

open class BooleanQuestionResult: QuestionResult {
    
    @objc dynamic var booleanAnswer: NSNumber?
    
    convenience init(booleanQuestionResult: ORKBooleanQuestionResult) {
        self.init(questionResult: booleanQuestionResult)
        
        booleanAnswer = booleanQuestionResult.booleanAnswer
    }
    
    override open class func collectionName() -> String {
        return "BooleanQuestionResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        booleanAnswer <- map["booleanAnswer"]
    }
    
}
