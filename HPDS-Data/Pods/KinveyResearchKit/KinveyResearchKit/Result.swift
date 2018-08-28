//
//  KNVTask.swift
//  KinveyResearchKit
//
//  Created by Tejas on 8/25/16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import RealmSwift
import PromiseKit
import ObjectMapper

open class Result: Entity {
    
    @objc dynamic var identifier: String?
    @objc dynamic var startDate: Date?
    @objc dynamic var endDate: Date?
    @objc dynamic var userInfo: [AnyHashable : Any]?
    let saveable = RealmOptional<Bool>()
    
    internal convenience init(result: ORKResult) {
        self.init()
        
        identifier = result.identifier
        endDate = result.endDate
        startDate = result.startDate
        userInfo = result.userInfo
        saveable.value = result.isSaveable
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        identifier <- map["identifier"]
        startDate <- map["startDate"]
        endDate <- map["endDate"]
        userInfo <- map["userInfo"]
        saveable.value <- map["saveable"]
    }
    
    internal func saveReferences() -> Promise<[ObjectReference]> {
        return Promise<[ObjectReference]> { fulfill, reject in
            fulfill([])
        }
    }
    
}
