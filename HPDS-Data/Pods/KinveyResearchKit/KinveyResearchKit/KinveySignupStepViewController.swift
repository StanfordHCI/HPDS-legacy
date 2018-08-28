//
//  KinveySignupStepViewController.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-07.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

open class KinveySignupStepViewController: ORKWaitStepViewController {
    
    var signupStep: KinveySignupStep {
        return step as! KinveySignupStep
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let registrationStepResult = signupStep.registrationStepResult
        
        var email: String? = nil
        var password: String? = nil
        var givenName: String? = nil
        var familyName: String? = nil
        var gender: String? = nil
        var dateOfBirth: Date? = nil
        
        if let results = registrationStepResult?.results {
            for result in results {
                switch result.identifier {
                case ORKRegistrationFormItemIdentifierEmail:
                    email = (result as? ORKTextQuestionResult)?.textAnswer
                case ORKRegistrationFormItemIdentifierPassword:
                    password = (result as? ORKTextQuestionResult)?.textAnswer
                case ORKRegistrationFormItemIdentifierGivenName:
                    givenName = (result as? ORKTextQuestionResult)?.textAnswer
                case ORKRegistrationFormItemIdentifierFamilyName:
                    familyName = (result as? ORKTextQuestionResult)?.textAnswer
                case ORKRegistrationFormItemIdentifierGender:
                    gender = (result as? ORKChoiceQuestionResult)?.choiceAnswers?.first as? String
                case ORKRegistrationFormItemIdentifierDOB:
                    dateOfBirth = (result as? ORKDateQuestionResult)?.dateAnswer
                default:
                    break
                }
            }
        }
        
        let user = KinveyResearchKit.KinveyUser()
        user.email = email
        user.givenName = givenName
        user.familyName = familyName
        user.gender = gender
        user.dateOfBirth = dateOfBirth
        User.signup(
            username: email!,
            password: password!,
            user: user,
            options: Options(
                client: signupStep.client
            )
        ) {
            switch $0 {
            case .success(_):
                self.goForward()
            case .failure(_):
                self.goBackward()
            }
        }
    }
    
}
