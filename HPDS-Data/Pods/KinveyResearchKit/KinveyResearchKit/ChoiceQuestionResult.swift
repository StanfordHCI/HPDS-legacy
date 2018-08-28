//
//  ChoiceQuestionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-04.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

open class ChoiceQuestionResult: QuestionResult {
    
    @objc dynamic var choiceAnswers: [Any]?
    
    convenience init(choiceQuestionResult: ORKChoiceQuestionResult) {
        self.init(questionResult: choiceQuestionResult)
        
        choiceAnswers = choiceQuestionResult.choiceAnswers
    }
    
    override open class func collectionName() -> String {
        return "ChoiceQuestionResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        choiceAnswers <- map["choiceAnswers"]
    }
    
}
