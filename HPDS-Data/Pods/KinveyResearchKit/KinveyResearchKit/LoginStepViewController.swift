//
//  KinveyLoginStepViewController.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-08.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit

open class LoginStepViewController: ORKWaitStepViewController {
    
    typealias Credential = (email: String?, password: String?)
    
    var credential: Credential {
        var email: String? = nil
        var password: String? = nil
        
        if let results = loginStep.loginStepResult?.results {
            for result in results {
                switch result.identifier {
                case ORKLoginFormItemIdentifierEmail:
                    email = (result as? ORKTextQuestionResult)?.textAnswer
                case ORKLoginFormItemIdentifierPassword:
                    password = (result as? ORKTextQuestionResult)?.textAnswer
                default:
                    break
                }
            }
        }
        
        return Credential(email: email, password: password)
    }
    
    var loginStep: LoginStep {
        return step as! LoginStep
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let credential = self.credential
        
        guard let email = credential.email, let password = credential.password else {
            return
        }
        
        KinveyResearchKit.KinveyUser.login(username: email, password: password) { user, error in
            if user != nil {
                self.goForward()
            } else if let error = error {
                let alertTitle = NSLocalizedString("Login Error", comment: "")
                let alertMessage = error.localizedDescription
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { alertAction in
                    self.goForward()
                })
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
