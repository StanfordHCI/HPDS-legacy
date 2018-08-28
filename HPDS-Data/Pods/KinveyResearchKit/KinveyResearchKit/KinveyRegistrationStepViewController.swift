//
//  KinveyRegistrationStepViewController.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-07.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

open class KinveyRegistrationStepViewController: ORKFormStepViewController {
    
    var registrationStep: KinveyRegistrationStep {
        return step as! KinveyRegistrationStep
    }
    
    open override func goForward() {
        registrationStep.signupStep?.registrationStepResult = result
        super.goForward()
    }
    
}
