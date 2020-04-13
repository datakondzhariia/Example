//
//  AppDelegate.swift
//  Example
//
//  Created by Data Kondzhariia on 3/4/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import FBSDKShareKit

enum AppDelegateFactory {
    
    static func makeDefault() -> AppDelegateType {
        
        return CompositeAppDelegate(appDelegates: [StartupConfiguratorAppDelegate(), ThirdPartiesConfiguratorAppDelegate()])
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let appDelegate = AppDelegateFactory.makeDefault()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        _ = appDelegate.application?(application, didFinishLaunchingWithOptions: launchOptions)

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        AppEvents.activateApp()
    }
}
