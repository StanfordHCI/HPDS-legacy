//
//  File.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-11-01.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

open class KinveyVerificationViewController : ORKVerificationStepViewController {
    
    private var verificationStep: KinveyVerificationStep {
        return step as! KinveyVerificationStep
    }
    
    override open func resendEmailButtonTapped() {
        if let user = verificationStep.client.activeUser {
            user.sendEmailConfirmation(options: Options(client: verificationStep.client)) { result in
                switch result {
                case .success:
                    if let completionHandler = self.verificationStep.completionHandler {
                        completionHandler(self, nil)
                    } else {
                        self.goForward()
                    }
                case .failure(let error):
                    if let completionHandler = self.verificationStep.completionHandler {
                        completionHandler(self, error)
                    } else {
                        self.goForward()
                    }
                }
            }
        }
    }
    
}
