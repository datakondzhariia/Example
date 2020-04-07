//
//  WelcomeRouter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/10/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import Foundation

@objc protocol WelcomeRoutingLogic {
    
    func navigateToMain()
    func navigateToSignIn()
}

protocol WelcomeDataPassing {
    
    var dataStore: WelcomeDataStore? { get }
}

class WelcomeRouter: NSObject {
    
    weak var viewController: WelcomeViewController?
    public var dataStore: WelcomeDataStore?
}

// MARK: - Welcome Routing Logic
extension WelcomeRouter: WelcomeRoutingLogic {
    
    func navigateToMain() {
                
        viewController?.performSegue(withIdentifier: R.segue.welcomeViewController.main.identifier, sender: .none)
    }
    
    func navigateToSignIn() {
        
        for viewController in viewController?.navigationController?.viewControllers ?? [] {
            
            guard viewController is SignInViewController else {
                break
            }
            
            self.viewController?.navigationController?.popToViewController(viewController, animated: true)
            return
        }

        viewController?.performSegue(withIdentifier: R.segue.welcomeViewController.signIn.identifier, sender: .none)
    }
}

// MARK: - Welcome Data Passing
extension WelcomeRouter: WelcomeDataPassing {}
