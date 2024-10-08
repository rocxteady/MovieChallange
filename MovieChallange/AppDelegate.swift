//
//  AppDelegate.swift
//  MovieChallange
//
//  Created by Ulaş Sancak on 15.08.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        OMDbAPI.configureWith(apiKey: "d09320a9")
        let viewController = MainViewController()
        let navigationViewController = UINavigationController(rootViewController: viewController)
        window = UIWindow()
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        return true
    }
    
}

