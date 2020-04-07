//
//  ProfileSettingsRouter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

@objc protocol ProfileSettingsRoutingLogic {
    
    func navigateToSignIn()
        
    func navigateToTermsAndConditions()
    
    func navigateToPrivacyPolicy()
    
    func routeToTermsAndConditions(segue: UIStoryboardSegue)
    
    func routeToPrivacyPolicy(segue: UIStoryboardSegue)
}

protocol ProfileSettingsDataPassing {
    
    var dataStore: ProfileSettingsDataStore? { get }
}

class ProfileSettingsRouter: NSObject {
    
    weak var viewController: ProfileSettingsViewController?
    public var dataStore: ProfileSettingsDataStore?
}

// MARK: - Profile Settings Routing Logic
extension ProfileSettingsRouter: ProfileSettingsRoutingLogic {
    
    func navigateToSignIn() {

        guard let window = UIApplication.shared.windows.first else {
            return
        }

        window.rootViewController = R.storyboard.signIn.navigationSignIn()

        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {})
    }
    
    func navigateToTermsAndConditions() {
        
        viewController?.performSegue(withIdentifier: R.segue.profileSettingsViewController.termsAndConditions.identifier, sender: .none)
    }
    
    func navigateToPrivacyPolicy() {
        
        viewController?.performSegue(withIdentifier: R.segue.profileSettingsViewController.privacyPolicy.identifier, sender: .none)
    }
    
    func routeToTermsAndConditions(segue: UIStoryboardSegue) {
                
        let termsFeedViewController = segue.destination as! TermsFeedViewController
        let termsFeedDataSource = termsFeedViewController.router?.dataStore
        termsFeedDataSource?.setupTermsConditionsInfo()
    }
    
    func routeToPrivacyPolicy(segue: UIStoryboardSegue) {
        
        let termsFeedViewController = segue.destination as! TermsFeedViewController
        let termsFeedDataSource = termsFeedViewController.router?.dataStore
        termsFeedDataSource?.setupPrivacyPolicy()
    }
}

// MARK: - Profile Settings Data Passing
extension ProfileSettingsRouter: ProfileSettingsDataPassing {}
