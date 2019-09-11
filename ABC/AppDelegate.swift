//
//  AppDelegate.swift
//  test2
//
//  Created by Nadia.Lin on 2019/8/13.
//  Copyright © 2019 Nadia.Lin. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    /* //NOT AIQUA
     
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
    }
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         
         let localNotification = UNUserNotificationCenter.current()
         localNotification.delegate = self
         localNotification.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
         print("User's permision: \(granted)")
         }
         
         //Local Notification
         UIApplication.shared.registerForRemoteNotifications()
     
         //Push Notification
         //UIApplication.shared.registerForRemoteNotifications(I)
     
        return true
    }
    */
    
    /*
    the user responds to the notification by opening the application,
    dismissing the notification, or choosing the UNNotificationAction
    */
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler:@escaping() -> Void) {
        QGSdk.getSharedInstance().userNotificationCenter(center, didReceive: response)
        completionHandler()
    }
    
    //push notification in the foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        QGSdk.getSharedInstance().userNotificationCenter(center, willPresent: notification)
        completionHandler([.alert, .badge, .sound]);
    }
    
    // AIQUA SDK
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        // initialize
        // App id: PROD  344bebd53f5687b47602
        // App id: Staging  3d308e6914083699a4eb
        let QG = QGSdk.getSharedInstance()
        #if DEBUG
        QG.onStart("344bebd53f5687b47602", withAppGroup:"group.AiquaSwift", setDevProfile: true)
        #else
        QG.onStart("344bebd53f5687b47602", withAppGroup:"group.AiquaSwift", setDevProfile: false)
        #endif
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .carPlay, .alert, .sound]) { (granted, error) in
                print("Granted: \(granted), Error: \(error)")
            }
        } else {
            // Fallback on earlier versions
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        //Controlling Push Permissions in iOS 12
//
//        if #available(iOS 10.0, *) {
//            let center = UNUserNotificationCenter.current()
//
//            center.delegate = self
//
//            var categories: Set<UNNotificationCategory> = Set.init()
//            categories.insert(QGSdk.getQGSliderPushActionCategory(withNextButtonTitle: ">> Next >>", withOpenAppButtonTitle: "Interested"))
//            center.setNotificationCategories(categories)
//
//            var options = UNAuthorizationOptions([.alert, .sound, .badge, .carPlay])
//            if #available(iOS 12.0, *) {
//                options.update(with: .provisional)
//            }
//            center.requestAuthorization(options: options) { (granted, error) in
//                print("Granted: \(granted), Error: \(error?.localizedDescription)")
//            }
//        } else {
//            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            UIApplication.shared.registerUserNotificationSettings(settings)
//        }
        
        return true
    }

    // QG set token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("My Device Token: \(token)")
        
        let QG = QGSdk.getSharedInstance()
        print("APP token is: \(deviceToken.debugDescription)")
        QG.setToken(deviceToken)
    }
    
    // QG fail to set token
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to get token, error: %@", error.localizedDescription)
    }
    
    // Handling Push Notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let QG = QGSdk.getSharedInstance()
        // to enable track click on notification
        QG.application(application, didReceiveRemoteNotification: userInfo)
        completionHandler(UIBackgroundFetchResult.noData)
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

