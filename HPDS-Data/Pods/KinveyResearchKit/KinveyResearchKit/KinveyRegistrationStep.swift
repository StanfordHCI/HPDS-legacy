//
//  KinveyRegistrationStep.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-07.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit

open class KinveyRegistrationStep: ORKRegistrationStep {
    
    public var signupStep: KinveySignupStep?
    
    open override func stepViewControllerClass() -> AnyClass {
        return KinveyRegistrationStepViewController.self
    }
    
}
