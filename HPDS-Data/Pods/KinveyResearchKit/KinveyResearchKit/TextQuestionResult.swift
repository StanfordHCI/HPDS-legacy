//
//  TextQuestionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-05.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

open class TextQuestionResult: QuestionResult {
    
    @objc dynamic var textAnswer: String?
    
    convenience init(textQuestionResult: ORKTextQuestionResult) {
        self.init(questionResult: textQuestionResult)
        
        switch textQuestionResult.identifier {
            case ORKLoginFormItemIdentifierPassword: break
            case ORKRegistrationFormItemIdentifierPassword: break
            case "ORKRegistrationFormItemConfirmPassword": break
            default:
                textAnswer = textQuestionResult.textAnswer
        }
    }
    
    override open class func collectionName() -> String {
        return "TextQuestionResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        textAnswer <- map["textAnswer"]
    }
    
}
