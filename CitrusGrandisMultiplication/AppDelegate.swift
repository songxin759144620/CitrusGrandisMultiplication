//
//  AppDelegate.swift
//  CitrusGrandisMultiplication
//
//  Created by songxin on 2022/11/4.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AQBaseNavigationController(rootViewController: AQTabbarViewController())
        window?.makeKeyAndVisible()
        
        return true
    }


}

