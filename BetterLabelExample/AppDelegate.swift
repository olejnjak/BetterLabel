//
//  AppDelegate.swift
//  BetterLabelExample
//
//  Created by Jakub Olejník on 23/10/2018.
//  Copyright © 2018 Jakub Olejník. All rights reserved.
//

import UIKit

@UIApplicationMain
open class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

