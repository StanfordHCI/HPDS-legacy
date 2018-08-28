//
//  PasscodeResult.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-05.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey
import ObjectMapper

open class PasscodeResult: Result {
    
    @objc dynamic var isPasscodeSaved: Bool = false
    
    convenience init(passcodeResult: ORKPasscodeResult) {
        self.init(result: passcodeResult)
        
        isPasscodeSaved = passcodeResult.isPasscodeSaved
    }
    
    override open class func collectionName() -> String {
        return "PasscodeResult"
    }
    
    override open func propertyMapping(_ map: Map) {
        super.propertyMapping(map)
        
        isPasscodeSaved <- map["isPasscodeSaved"]
    }
    
}
