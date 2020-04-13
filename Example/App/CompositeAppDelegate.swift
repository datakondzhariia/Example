//
//  CompositeAppDelegate.swift
//  Example
//
//  Created by Data Kondzhariia on 04.03.2020.
//  Copyright © 2020 Data Kondzhariia. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKShareKit
import GoogleMaps
import GooglePlaces
import SwiftDate
import Firebase

typealias AppDelegateType = UIResponder & UIApplicationDelegate

class CompositeAppDelegate: AppDelegateType {
    
    private let appDelegates: [AppDelegateType]

    init(appDelegates: [AppDelegateType]) {
        self.appDelegates = appDelegates
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        appDelegates.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        appDelegates.forEach { _ = $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }
}

// MARK: - Startup Configurator AppDelegate
class StartupConfiguratorAppDelegate: AppDelegateType {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if UserDefaultsService.shared.isFirstRun() {
            
            KeychainService.shared.remove(key: .access)
            UserDefaultsService.shared.save(value: UserDefaultsKey.firstRun.rawValue, key: .firstRun)
        }

        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: R.font.nunitoBold(size: 18)!, NSAttributedString.Key.foregroundColor: R.color.salem()!], for: .normal)
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: R.font.nunitoBold(size: 18)!]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: R.font.nunitoBold(size: 10)!], for: .normal)
        UITabBar.appearance().tintColor = R.color.apple()
        UITabBar.appearance().isTranslucent = false
        UIDatePicker.appearance().minuteInterval = 15

        return true
    }
}

// MARK: - Third Parties Configurator AppDelegate
class ThirdPartiesConfiguratorAppDelegate: AppDelegateType {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()

        GMSServices.provideAPIKey(DeafultGooglePlacesSettings.Dev.key)
        GMSPlacesClient.provideAPIKey(DeafultGooglePlacesSettings.Dev.key)

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = R.color.salem()
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Setup SwiftDate
        let currentRegion = Region(calendar: Calendars.gregorian, zone: TimeZone.current, locale: Locale.current)
        SwiftDate.defaultRegion = currentRegion
        
        CurrentLocation.shared.startLocationUpdating()

        return true
    }
}
