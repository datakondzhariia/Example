//
//  RegistrationHelper.swift
//  Example
//
//  Created by Data Kondzhariia on 4/17/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class AuthInfo {
    
    let registerState: RegisterState!
    var token: String?
    var userId: String?
    
    init(registerState: RegisterState) {
        
        self.registerState = registerState
        token = nil
        userId = nil
    }
}

enum RegisterScreen {
    
    case welcome
    case signIn
    case manualSignUp
    case passwordReset
}

enum RegisterState {
    
    case none
    case signIn
    case manualSignUp
    case facebookSignUp
    case passwordReset
    
    static func getCurrentState(from registerScreen: RegisterScreen) -> RegisterState {
        
        switch registerScreen {
        case .welcome:
            return .none
        case .signIn:
            return .signIn
        case .manualSignUp:
            return .manualSignUp
        case .passwordReset:
            return .passwordReset
        }
    }
}

protocol RegistrationStateDataSource {
    
    func currentRegistrationScreen() -> RegisterScreen
}

class RegistrationHelper {
    
    static let shared = RegistrationHelper()
    
    fileprivate var authInfo: AuthInfo?
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
    
    public func currentRegistrationState() -> RegisterState {
        
        if let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController {
            var currentController = rootViewController
            while let presentedController = currentController.presentedViewController {
                currentController = presentedController
            }
            let navigationController = currentController as? UINavigationController
            let controller = navigationController?.viewControllers.last
            
            guard let registrationController = controller as? RegistrationStateDataSource else {
                return .none
            }
            
            return RegisterState.getCurrentState(from: registrationController.currentRegistrationScreen())
        }
        
        return .none
    }

    public func startRegister(state: RegisterState) {
        authInfo = AuthInfo(registerState: state)
    }
}

// MARK: - Facebook
extension RegistrationHelper {
    
    public func saveToken(_ token: String, for state: RegisterState? = nil) {
        
        if let authInfo = authInfo, (authInfo.registerState == state || state == nil) {
            
            authInfo.token = token
        } else if let state = state {
            
            authInfo = AuthInfo(registerState: state)
            authInfo?.token = token
        }
    }
    
    public func getFacebookToken() -> String? {
        return authInfo?.token
    }    
}

// MARK: - Finish Sign Up
extension RegistrationHelper {
    
    public func saveUserId(_ userId: String, for state: RegisterState? = nil) {
        
        if let authInfo = authInfo, (authInfo.registerState == state || state == nil) {
            
            authInfo.userId = userId
        } else if let state = state {
            
            authInfo = AuthInfo(registerState: state)
            authInfo?.userId = userId
        }
    }
    
    public func getUserId() -> String? {
        return authInfo?.userId
    }
}
