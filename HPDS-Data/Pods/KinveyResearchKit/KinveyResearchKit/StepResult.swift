//
//  StepResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-09-22.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

open class StepResult: CollectionResult {

    convenience init(stepResult: ORKStepResult) {
        self.init(collectionResult: stepResult)
    }

    override open class func collectionName() -> String {
        return "StepResult"
    }

    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
    }

}
