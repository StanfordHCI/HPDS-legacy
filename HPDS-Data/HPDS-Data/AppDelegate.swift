//
//  AppDelegate.swift
//  HPDS-Data
//
//  Created by Michael Cooper on 2018-07-12.
//  Copyright © 2018 Michael Cooper. All rights reserved.
//

import UIKit
import AWAREFramework
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var core: AWARECore!
    var study: AWAREStudy!
    var manager: AWARESensorManager!
    var rk: RKSensor!

    static func shared() -> AppDelegate {
        //Returns an instance of the current AppDelegate - this is used to access class-level
        //variables of this AppDelegate in other files.
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func getUrl() -> String {
        //Returns the URL of the AWARE study on which this application is running
        return "https://api.awareframework.com/index.php/webservice/index/1888/UqMEKGUkE07T"
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.core = AWARECore.shared()!                         //Initialize AWARE Core
        self.study = AWAREStudy.shared()                        //Initialize AWARE Study
        self.study.setDebug(false)                               //Debugging settings - turn off when running in production
        self.manager = AWARESensorManager.shared()              //Initialize AWARE Sensor Manager
        
        
        core.activate()

        //Request permission to perform background sensing
        core.requestPermissionForBackgroundSensing()
        
        //Declare, initialize AWARE sensors
        let healthkit = AWAREHealthKit(awareStudy: self.study)
        let activity = IOSActivityRecognition(awareStudy: self.study)

        //Setup background fetching interval
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        //Add AWARE sensors to the sensor manager
        manager?.add(healthkit)
        manager?.add(activity)

        //Set study url to the url listed on AWARE Dashboard
        let studyurl = getUrl()
        self.study?.setStudyURL(studyurl)
        
        self.rk = RKSensor(awareStudy: self.study)              //Since this is a class-level variable, we can access it in ViewController.swift
                                                                //We define it here so that the study has a URL
        
        //Testing things from Yuuki's Slack suggestion
        let url = Bundle.main.url(forResource: "SampleDB", withExtension: "momd")
        ExternalCoreDataHandler.shared()!.overwriteManageObjectModel(withFileURL: url)
//        let sqliteURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
//        ExternalCoreDataHandler.shared()!.sqliteFileURL  = sqliteURL?.appendingPathComponent("SampleDB.sqlite")
        
        self.study?.join(withURL: studyurl, completion: { (settings, studyState, error) in
            self.manager?.createDBTablesOnAwareServer()             //Initialize database for sensors
            self.manager?.addSensors(with: self.study)              //Add sensors to study
            self.manager?.startAllSensors()                         //Start sensors running
        })
        
        print("Setup complete.")

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        //Here we use this to sync up our data with AWARE.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //Start sensors operating in the background
        self.manager?.startAllSensors()

    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
