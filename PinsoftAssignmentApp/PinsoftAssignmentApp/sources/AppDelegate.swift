//
//  AppDelegate.swift
//  PinsoftAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 23.08.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        window?.rootViewController = RootController()
        
        return true
    }
}
