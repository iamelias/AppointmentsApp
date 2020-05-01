//
//  AppDelegate.swift
//  AppointmentsApp
//
//  Created by Elias Hall on 4/26/20.
//  Copyright © 2020 Elias Hall. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound], completionHandler: {(granted, error) in
            
            if granted { // app being granted permission to send notifications
                print("Allows User Notifications")
            }
            else {
                print("No permission to use User Notifications")
            }
        })
        
        
        _ = DatabaseController.persistentStoreContainer()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

}
}
