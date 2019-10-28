//
//  AppDelegate.swift
//  Cleanse
//
//  Created by Alek Matthiessen on 10/26/19.
//  Copyright © 2019 The Matthiessen Group, LLC. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import FirebaseDatabase
import FirebaseStorage
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarBuyer : UITabBarController = mainStoryboardIpad.instantiateViewController(withIdentifier: "HomeTab") as! UITabBarController
        
        tabBarBuyer.selectedIndex = 0
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabBarBuyer
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle




}

