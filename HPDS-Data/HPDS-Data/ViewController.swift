//
//  ViewController.swift
//  HPDS-Data
//
//  Created by Michael Cooper on 2018-07-12.
//  Copyright © 2018 Michael Cooper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Push data to AWARE server on button press
    
    @IBAction func syncSensors(_ sender: Any) {
        let sensorManager = AppDelegate.shared().manager!
        sensorManager.syncAllSensors()
    }
}
