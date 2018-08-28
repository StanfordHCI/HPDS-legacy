//
//  QuestionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-26.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

public enum QuestionType: Int {
    
    case none, scale, singleChoice, multipleChoice, decimal, integer, boolean, text, timeOfDay, dateAndTime, date, timeInterval, height, location, multiplePicker
    
    var stringValue: String {
        switch self {
        case .none:
            return "None"
        case .scale:
            return "Scale"
        case .singleChoice:
            return "SingleChoice"
        case .multipleChoice:
            return "MultipleChoice"
        case .decimal:
            return "Decimal"
        case .integer:
            return "Integer"
        case .boolean:
            return "Boolean"
        case .text:
            return "Text"
        case .timeOfDay:
            return "TimeOfDay"
        case .dateAndTime:
            return "DateAndTime"
        case .date:
            return "Date"
        case .timeInterval:
            return "TimeInterval"
        case .height:
            return "Height"
        case .location:
            return "Location"
        case .multiplePicker:
            return "MultiplePicker"
        }
    }
    
    init(_ questionType: ORKQuestionType) {
        switch questionType {
        case .none:
            self = .none
        case .scale:
            self = .scale
        case .singleChoice:
            self = .singleChoice
        case .multipleChoice:
            self = .multipleChoice
        case .decimal:
            self = .decimal
        case .integer:
            self = .integer
        case .boolean:
            self = .boolean
        case .text:
            self = .text
        case .timeOfDay:
            self = .timeOfDay
        case .dateAndTime:
            self = .dateAndTime
        case .date:
            self = .date
        case .timeInterval:
            self = .timeInterval
        case .height:
            self = .height
        case .location:
            self = .location
        case .multiplePicker:
            self = .multiplePicker
        }
    }
    
    init?(_ questionType: String) {
        switch questionType {
            case "None":
                self = .none
            case "Scale":
                self = .scale
            case "SingleChoice":
                self = .singleChoice
            case "MultipleChoice":
                self = .multipleChoice
            case "Decimal":
                self = .decimal
            case "Integer":
                self = .integer
            case "Boolean":
                self = .boolean
            case "Text":
                self = .text
            case "TimeOfDay":
                self = .timeOfDay
            case "DateAndTime":
                self = .dateAndTime
            case "Date":
                self = .date
            case "TimeInterval":
                self = .timeInterval
            case "Location":
                self = .location
            default:
                return nil
        }
    }
    
}

class QuestionTypeTransformer: TransformType {
    
    typealias Object = QuestionType
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value as? String {
            return QuestionType(value)
        }
        return nil
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return value.stringValue
        }
        return nil
    }
    
}

open class QuestionResult: Result {
    
    @objc private dynamic var _questionType: Int = QuestionType.none.rawValue
    
    var questionType: QuestionType {
        get {
            return QuestionType(rawValue: _questionType)!
        }
        set {
            _questionType = newValue.rawValue
        }
    }
    
    convenience init(questionResult: ORKQuestionResult) {
        self.init(result: questionResult)
        
        questionType = QuestionType(questionResult.questionType)
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        questionType <- (map["questionType"], QuestionTypeTransformer())
    }
    
}
