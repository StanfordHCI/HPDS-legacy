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

    static func shared() -> AppDelegate {
        //Returns an instance of the current AppDelegate
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.core = AWARECore.shared()!
        self.study = AWAREStudy.shared()
        self.study.setDebug(true) //Debugging settings
        self.manager = AWARESensorManager.shared()
        
        core.activate()
        // Request the following permission if you need to collect sensor data in the background.
        
        core.requestPermissionForBackgroundSensing()
        
        let healthkit = AWAREHealthKit(awareStudy: self.study)
        let activity = IOSActivityRecognition(awareStudy: self.study)
        let esm = IOSESM(awareStudy: self.study)

        //Setup background fetching
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        manager?.add(healthkit)
        manager?.add(activity)
        manager?.add(esm)

        let url = "https://api.awareframework.com/index.php/webservice/index/1888/UqMEKGUkE07T"
        self.study?.setStudyURL(url)
        esm?.startSensor(withURL: url, tableName: "esm")
        print("Started ESM Sensor!")
        print("Started ESM Sensor!")
        print("Started ESM Sensor!")
        print("Started ESM Sensor!")
        print("Started ESM Sensor!")
        
        self.study?.join(withURL: url, completion: { (settings, studyState, error) in
            self.manager?.createDBTablesOnAwareServer()
            self.manager?.addSensors(with: self.study)
            self.manager?.startAllSensors()
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
