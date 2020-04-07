//
//  SignInRouter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import Foundation

@objc protocol SignInRoutingLogic {
    
    func navigateToPasswordReset()
    func navigateToSignUp()
    func navigateToMain()
}

protocol SignInDataPassing {
    
    var dataStore: SignInDataStore? { get }
}

class SignInRouter: NSObject {

    weak var viewController: SignInViewController?
    var dataStore: SignInDataStore?
}

// MARK: - Sign In Routing Logic
extension SignInRouter: SignInRoutingLogic {
    
    func navigateToPasswordReset() {
        
        RegistrationHelper.shared.startRegister(state: .passwordReset)
                
        viewController?.performSegue(withIdentifier: R.segue.signInViewController.passwordReset.identifier, sender: .none)
    }
    
    func navigateToSignUp() {
        
        for viewController in viewController?.navigationController?.viewControllers ?? [] {
            
            guard let signUpViewController = viewController as? SignUpViewController else {
                break
            }
            
            signUpViewController.formCleanUp()
            self.viewController?.navigationController?.popToViewController(signUpViewController, animated: true)
            return
        }
                
        viewController?.performSegue(withIdentifier: R.segue.signInViewController.signUp.identifier, sender: .none)
    }
    
    func navigateToMain() {
                
        viewController?.performSegue(withIdentifier: R.segue.signInViewController.main.identifier, sender: .none)
    }
}

// MARK: - Sign In Data Passing 
extension SignInRouter: SignInDataPassing {}
