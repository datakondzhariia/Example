//
//  SignUpRouter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

@objc protocol SignUpRoutingLogic {
    
    func navigateToMain()
    func navigateToSignIn()
}

protocol SignUpDataPassing {
    
    var dataStore: SignUpDataStore? { get }
}

class SignUpRouter: NSObject {
    
    weak var viewController: SignUpViewController?
    public var dataStore: SignUpDataStore?
}

// MARK: - Sign Up Routing Logic
extension SignUpRouter: SignUpRoutingLogic {
    
    func navigateToMain() {
        
        viewController?.performSegue(withIdentifier: R.segue.signUpViewController.main.identifier, sender: .none)
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
        
        viewController?.performSegue(withIdentifier: R.segue.signUpViewController.signIn.identifier, sender: .none)
    }    
}

// MARK: - Sign Up Data Passing
extension SignUpRouter: SignUpDataPassing {}
