//
//  KinveyVerificationStep.swift
//  KinveyResearchKit
//
//  Created by Victor Hugo on 2016-11-01.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import ResearchKit
import Kinvey

open class KinveyVerificationStep: ORKVerificationStep {
    
    let client: Client
    
    public typealias VerificationHandler = (KinveyVerificationViewController, Swift.Error?) -> Void
    
    public var registrationStep: KinveyRegistrationStep?
    var completionHandler: VerificationHandler?
    
    public init(identifier: String, text: String?, client: Client = Kinvey.sharedClient, completionHandler: VerificationHandler? = nil) {
        self.client = client
        self.completionHandler = completionHandler
        super.init(identifier: identifier, text: text, verificationViewControllerClass: KinveyVerificationViewController.self)
    }
    
    public required init(coder aDecoder: NSCoder) {
        client = aDecoder.decodeObject(forKey: "client") as! Client
        super.init(coder: aDecoder)
    }
    
}
