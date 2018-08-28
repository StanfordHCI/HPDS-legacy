//
//  KinveySignupStep.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-07.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

open class KinveySignupStep: ORKWaitStep {

    let client: Client
    var registrationStepResult: ORKStepResult?
    
    public required init(identifier: String, client: Client = Kinvey.sharedClient) {
        self.client = client
        super.init(identifier: identifier)
    }
    
    public required init(coder aDecoder: NSCoder) {
        client = aDecoder.decodeObject(forKey: "client") as! Client
        super.init(coder: aDecoder)
    }
    
    open override func stepViewControllerClass() -> AnyClass {
        return KinveySignupStepViewController.self
    }
    
}
