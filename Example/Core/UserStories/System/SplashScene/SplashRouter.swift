//
//  SplashRouter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

@objc protocol SplashRoutingLogic {
    
    func navigateToWelcome()
    func navigateToMain()
}

protocol SplashDataPassing {
    
    var dataStore: SplashDataStore? { get }
}

// MARK: - Router class
class SplashRouter: NSObject {
    
    weak var viewController: SplashViewController?
    public var dataStore: SplashDataStore?
}

// MARK: Splash Routing Logic
extension SplashRouter: SplashRoutingLogic {
    
    func navigateToWelcome() {
        
        viewController?.performSegue(withIdentifier: R.segue.splashViewController.welcome.identifier, sender: .none)
    }
    
    func navigateToMain() {
        
        /// setup root view controller
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        
        window.rootViewController = R.storyboard.main.navigationMain()
        
        /// Though `animations` is optional, the documentation tells us that it must not be nil.
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {})
    }
}

// MARK: - Splash Data Passing
extension SplashRouter: SplashDataPassing {}
