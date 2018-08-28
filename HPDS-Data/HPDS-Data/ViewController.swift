//
//  ViewController.swift
//  HPDS-Data
//
//  Created by Michael Cooper on 2018-07-12.
//  Copyright © 2018 Michael Cooper. All rights reserved.
//

import UIKit
import AWAREFramework
import ResearchKit
import SafariServices

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Hides the default parent level navigation bar upon navigating to a child screen
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     * Action: syncSensors
     * Description: Syncs all AWARE sensors with the AWARE server.
     */
    @IBAction func syncSensors(_ sender: Any) {
        //Pull in the sensorManager from our AppDelegate file.
        let sensorManager = AppDelegate.shared().manager!
        //Sync the sensor data with the AWARE server.
        sensorManager.syncAllSensors()
    }
    
    /*
     * Action: openEmail
     * Description: Opens the user's default email client, and an email within
     * the client addressed to the email address below.
     */
    @IBAction func openEmail(_ sender: Any) {
        let email = "foo@bar.com" // To be updated with real contact info
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    /*
     * Action: openSurvey
     * Description: Opens the ESM survey using Safari-based in-app browsing.
     */
    
    @IBAction func openSurvey(_ sender: Any) {
        let urlString = NSURL(string: "https://stanforduniversity.qualtrics.com/jfe/form/SV_3dwr3XJjCyzY0Ul")
        let svc = SFSafariViewController(url: urlString! as URL)
        self.present(svc, animated: true, completion: nil)
    }
    
}
