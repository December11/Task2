//
//  AppDelegate.swift
//  Task2
//
//  Created by Alla Shkolnik on 24.06.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabbarController = TabBarController()
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
