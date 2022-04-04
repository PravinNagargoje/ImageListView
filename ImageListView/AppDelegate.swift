//
//  AppDelegate.swift
//  ImageListView
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var newWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let window = newWindow {
            window.backgroundColor = .white
            window.rootViewController = UINavigationController(rootViewController: ViewController())
            window.makeKeyAndVisible()
        }
        return true
    }
}
