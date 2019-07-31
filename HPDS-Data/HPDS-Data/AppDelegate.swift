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
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var core: AWARECore!
    var study: AWAREStudy!
    var manager: AWARESensorManager!

    static func shared() -> AppDelegate {
        //Returns an instance of the current AppDelegate - this is used to access class-level
        //variables of this AppDelegate in other files.
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func getUrl() -> String {
        //Returns the URL of the AWARE study on which this application is running
        return "https://api.awareframework.com/index.php/webservice/index/2439/QPnWjaZXyx6l"
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.core = AWARECore.shared()                         //Initialize AWARE Core
        self.study = AWAREStudy.shared()                        //Initialize AWARE Study
        self.study.setDebug(false)                               //Debugging settings - turn off when running in production
        self.manager = AWARESensorManager.shared()              //Initialize AWARE Sensor Manager
        
        
        core.activate()

        //Request permission to perform background sensing
        core.requestPermissionForBackgroundSensing()
        
        //Declare, initialize AWARE sensors
        let healthkit = AWAREHealthKit(awareStudy: self.study)
        let activity = IOSActivityRecognition(awareStudy: self.study)
        
        //initialize notification capabilities and enlist them
        registerForPushNotifications()
        createPushNotifications()
        
        //Setup background fetching interval
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        
        //Add AWARE sensors to the sensor manager
        manager?.add(healthkit)
        manager?.add(activity)

        //Set study url to the url listed on AWARE Dashboard
        let studyurl = getUrl()
        self.study?.setStudyURL(studyurl)
        
        self.study?.join(withURL: studyurl, completion: { (settings, studyState, error) in
            self.manager?.addSensors(with: self.study)              //Add sensors to study from AWARE study dashboard
            self.manager?.createDBTablesOnAwareServer()             //Initialize database for sensors
            self.manager?.startAllSensors()                         //Start sensors running
        })
        
        print("Setup complete.")

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        //Here we use this to sync up our data with AWARE.
        self.manager?.syncAllSensors()
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
        self.manager?.startAllSensors()

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        self.manager?.startAllSensors()
        self.manager?.syncAllSensors()
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }
    
    func createPushNotifications() {
        //notification content details
        let content = UNMutableNotificationContent()
        content.title = "ESM Survey"
        content.body = "Time for a survey! :)"
        
        //notification sending details: change interval between notifications at timeInterval (in seconds)
        var date = DateComponents()
        date.hour = 0
        date.minute = 0
        
        let uuidString = UUID().uuidString
        for i in 1...4 {
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let request = UNNotificationRequest(identifier: uuidString,
                                                content: content, trigger: trigger)
            
            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { (error) in
                if error != nil {
                    print("error occurred while sending notification request")
                }
            }
            let curHour = 6 * i
            date.hour = curHour
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }

        }
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
        ) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
}
