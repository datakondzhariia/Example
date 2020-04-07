//
//  PasswordResetRouter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/22/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

@objc protocol PasswordResetRoutingLogic {
    
    func navigateToSignUp()
    func navigateToSignIn()
}

protocol PasswordResetDataPassing {
    
    var dataStore: PasswordResetDataStore? { get }
}

class PasswordResetRouter: NSObject {
    
    weak var viewController: PasswordResetViewController?
    public var dataStore: PasswordResetDataStore?
}

// MARK: - Password Reset Routing Logic
extension PasswordResetRouter: PasswordResetRoutingLogic {
    
    func navigateToSignUp() {
        
        for viewController in viewController?.navigationController?.viewControllers ?? [] {
            
            guard let signUpViewController = viewController as? SignUpViewController else {
                break
            }
            
            signUpViewController.formCleanUp()
            self.viewController?.navigationController?.popToViewController(signUpViewController, animated: true)
            return
        }
        
        viewController?.performSegue(withIdentifier: R.segue.passwordResetViewController.signUp.identifier, sender: .none)
    }
    
    func navigateToSignIn() {
        
        for viewController in viewController?.navigationController?.viewControllers ?? [] {
            
            guard let signInViewController = viewController as? SignInViewController else {
                break
            }
            
            signInViewController.formCleanUp()
            self.viewController?.navigationController?.popToViewController(signInViewController, animated: true)
            return
        }
                
        viewController?.performSegue(withIdentifier: R.segue.passwordResetViewController.signIn.identifier, sender: .none)
    }
}

// MARK: - Password Reset Data Passing
extension PasswordResetRouter: PasswordResetDataPassing {}
