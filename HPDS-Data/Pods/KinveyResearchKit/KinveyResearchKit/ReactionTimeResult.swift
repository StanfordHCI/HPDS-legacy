//
//  ReactionTimeResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-06.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

open class ReactionTimeResult: Result {
    
    @objc dynamic var timestamp: TimeInterval = 0
    @objc dynamic var fileResult: FileResult?
    
    convenience init(reactionTimeResult: ORKReactionTimeResult) {
        self.init(result: reactionTimeResult)
        
        timestamp = reactionTimeResult.timestamp
        fileResult = FileResult(fileResult: reactionTimeResult.fileResult)
    }
    
    override open class func collectionName() -> String {
        return "ReactionTimeResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        timestamp <- map["timestamp"]
        fileResult <- map["fileResult"]
    }
    
}
