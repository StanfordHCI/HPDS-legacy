//
//  DataResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-07.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

open class DataResult: Result {
    
    @objc dynamic var contentType: String?
    @objc dynamic var filename: String?
    @objc dynamic var data: Data?
    
    convenience init(dataResult: ORKDataResult) {
        self.init(result: dataResult)
        
        contentType = dataResult.contentType
        filename = dataResult.filename
        data = dataResult.data
    }
    
    override open class func collectionName() -> String {
        return "DataResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        contentType <- map["contentType"]
        filename <- map["filename"]
        data <- map["data"]
    }
    
}
