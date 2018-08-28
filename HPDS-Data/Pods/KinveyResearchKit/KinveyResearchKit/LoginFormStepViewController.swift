//
//  LoginStepViewController.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-10-08.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

open class LoginFormStepViewController: ORKLoginStepViewController {
    
    typealias Credential = (email: String?, password: String?)
    
    var credential: Credential {
        var email: String? = nil
        var password: String? = nil
        
        if let results = result?.results {
            for result in results {
                switch result.identifier {
                case "ORKLoginFormItemEmail":
                    email = (result as? ORKTextQuestionResult)?.textAnswer
                case "ORKLoginFormItemPassword":
                    password = (result as? ORKTextQuestionResult)?.textAnswer
                default:
                    break
                }
            }
        }
        return Credential(email: email, password: password)
    }

    var loginFormStep: LoginFormStep {
        return step as! LoginFormStep
    }
    
    open override func goForward() {
        loginFormStep.loginStep?.loginStepResult = result
        super.goForward()
    }
    
    open override func forgotPasswordButtonTapped() {
        let credential = self.credential
        guard let email = credential.email else {
            let alertTitle = NSLocalizedString("Forgot password?", comment: "")
            let alertMessage = NSLocalizedString("Please type the email used when the account was created.", comment: "")
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        User.resetPassword(usernameOrEmail: email, options: nil) {
            switch $0 {
            case .success:
                let alertTitle = NSLocalizedString("Forgot password?", comment: "")
                let alertMessage = NSLocalizedString("Email sent!", comment: "")
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case .failure(let error):
                let alertTitle = NSLocalizedString("Forgot password?", comment: "")
                let alertMessage = error.localizedDescription
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
