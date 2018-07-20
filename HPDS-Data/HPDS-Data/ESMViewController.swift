//
//  ESMViewController.swift
//  HPDS-Data
//
//  Created by Michael Cooper on 2018-07-16.
//  Copyright © 2018 Michael Cooper. All rights reserved.
//

import UIKit
import AWAREFramework

class ESMViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let esm = IOSESM(awareStudy: AppDelegate.shared().study)
        esm?.startSensor(withURL: "https://api.awareframework.com/index.php/webservice/index/1888/UqMEKGUkE07T", tableName: "ESM")
        let esmViewController = ESMViewController.init()
        self.present(esmViewController, animated: true)
//        let esmManager = AppDelegate.shared().esmManager
//
//        let schedules = esmManager?.getValidSchedules()
//        if let unwrappedSchedules = schedules {
//            if(unwrappedSchedules.count > 0){
//                let esmViewController = ESMScrollViewController.init()
//                self.present(esmViewController, animated: true) {
//                }
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
