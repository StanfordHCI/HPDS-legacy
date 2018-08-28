//
//  DateQuestionResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-04.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

fileprivate let BuddhistCalendar = "Buddhist"
fileprivate let ChineseCalendar = "Chinese"
fileprivate let CopticCalendar = "Coptic"
fileprivate let EthiopicAmeteAlemCalendar = "EthiopicAmeteAlem"
fileprivate let EthiopicAmeteMihretCalendar = "EthiopicAmeteMihret"
fileprivate let GregorianCalendar = "Gregorian"
fileprivate let HebrewCalendar = "Hebrew"
fileprivate let IndianCalendar = "Indian"
fileprivate let IslamicCalendar = "Islamic"
fileprivate let IslamicCivilCalendar = "IslamicCivil"
fileprivate let IslamicTabularCalendar = "IslamicTabular"
fileprivate let IslamicUmmAlQuraCalendar = "IslamicUmmAlQura"
fileprivate let ISO8601Calendar = "ISO8601"
fileprivate let JapaneseCalendar = "Japanese"
fileprivate let PersianCalendar = "Persian"
fileprivate let RepublicOfChinaCalendar = "RepublicOfChina"

extension Calendar {
    
    init?(identifier: String) {
        switch identifier {
        case BuddhistCalendar:
            self.init(identifier: .buddhist)
        case ChineseCalendar:
            self.init(identifier: .chinese)
        case CopticCalendar:
            self.init(identifier: .coptic)
        case EthiopicAmeteAlemCalendar:
            self.init(identifier: .ethiopicAmeteAlem)
        case EthiopicAmeteMihretCalendar:
            self.init(identifier: .ethiopicAmeteMihret)
        case GregorianCalendar:
            self.init(identifier: .gregorian)
        case HebrewCalendar:
            self.init(identifier: .hebrew)
        case IndianCalendar:
            self.init(identifier: .indian)
        case IslamicCalendar:
            self.init(identifier: .islamic)
        case IslamicCivilCalendar:
            self.init(identifier: .islamicCivil)
        case IslamicTabularCalendar:
            self.init(identifier: .islamicTabular)
        case IslamicUmmAlQuraCalendar:
            self.init(identifier: .islamicUmmAlQura)
        case ISO8601Calendar:
            self.init(identifier: .iso8601)
        case JapaneseCalendar:
            self.init(identifier: .japanese)
        case PersianCalendar:
            self.init(identifier: .persian)
        case RepublicOfChinaCalendar:
            self.init(identifier: .republicOfChina)
        default:
            return nil
        }
    }
    
}

extension Calendar.Identifier {
    
    var stringValue: String {
        switch self {
        case .buddhist:
            return BuddhistCalendar
        case .chinese:
            return ChineseCalendar
        case .coptic:
            return CopticCalendar
        case .ethiopicAmeteAlem:
            return EthiopicAmeteAlemCalendar
        case .ethiopicAmeteMihret:
            return EthiopicAmeteMihretCalendar
        case .gregorian:
            return GregorianCalendar
        case .hebrew:
            return HebrewCalendar
        case .indian:
            return IndianCalendar
        case .islamic:
            return IslamicCalendar
        case .islamicCivil:
            return IslamicCivilCalendar
        case .islamicTabular:
            return IslamicTabularCalendar
        case .islamicUmmAlQura:
            return IslamicUmmAlQuraCalendar
        case .iso8601:
            return ISO8601Calendar
        case .japanese:
            return JapaneseCalendar
        case .persian:
            return PersianCalendar
        case .republicOfChina:
            return RepublicOfChinaCalendar
        }
    }
    
}

struct CalendarTransform: TransformType {
    
    typealias Object = Calendar
    typealias JSON = String
    
    public func transformFromJSON(_ value: Any?) -> Calendar? {
        if let value = value as? String {
            return Calendar(identifier: value)
        }
        return nil
    }
    
    public func transformToJSON(_ value: Calendar?) -> String? {
        if let value = value {
            return value.identifier.stringValue
        }
        return nil
    }
    
}

extension TimeZone: Mappable {
    
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public init?(map: Map) {
        var secondsFromGMTValue: Int?
        secondsFromGMTValue <- map["secondsFromGMT"]
        guard let secondsFromGMT = secondsFromGMTValue else {
            return nil
        }
        self.init(secondsFromGMT: secondsFromGMT)
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public mutating func mapping(map: Map) {
        switch map.mappingType {
        case .toJSON:
            var identifier = self.identifier
            var abbreviation = self.abbreviation()
            var secondsFromGMT = self.secondsFromGMT()
            var isDaylightSavingTime = self.isDaylightSavingTime()
            
            identifier <- map["identifier"]
            abbreviation <- map["abbreviation"]
            secondsFromGMT <- map["secondsFromGMT"]
            isDaylightSavingTime <- map["isDaylightSavingTime"]
        default:
            break
        }
    }

    
}

open class DateQuestionResult: QuestionResult {
    
    @objc dynamic var dateAnswer: Date?
    @objc dynamic var calendar: Calendar?
    @objc dynamic var timeZone: TimeZone?
    
    convenience init(dateQuestionResult: ORKDateQuestionResult) {
        self.init(questionResult: dateQuestionResult)
        
        dateAnswer = dateQuestionResult.dateAnswer
        calendar = dateQuestionResult.calendar
        timeZone = dateQuestionResult.timeZone
    }
    
    override open class func collectionName() -> String {
        return "DateQuestionResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        dateAnswer <- (map["dateAnswer"], ISO8601DateTransform())
        calendar <- (map["calendar"], CalendarTransform())
        timeZone <- map["timeZone"]
    }
    
}
