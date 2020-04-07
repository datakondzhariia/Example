//
//  SignUpWorker.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import Foundation

class SignUpWorker {
 
    typealias ResponseSuccess = () -> Void
    typealias ResponseError = (_ response: ExampleError?) -> Void
}

// MARK: - Public Methods
extension SignUpWorker {
    
    public func manualSignUp(firstName: String, lastName: String, email: String, password: String, responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        
        NetworkService.shared.manualSignUp(firstName: firstName, lastName: lastName, email: email, password: password, responseSuccess: { token, userID in
            
            KeychainService.shared.save(token: token, key: .access)
            // Save into Registration Helper for finishSignUp request
            RegistrationHelper.shared.saveUserId(userID, for: .manualSignUp)
            
            responseSuccess()
            
        }, responseError: responseError)
    }
    
    public func signInFacebook(token: String, responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        
        NetworkService.shared.signInFacebook(token: token, responseSuccess: { token, userID in
                        
            KeychainService.shared.save(token: token, key: .access)
            // Save into Registration Helper for finishSignUp request
            RegistrationHelper.shared.saveUserId(userID, for: .facebookSignUp)
            
            responseSuccess()
            
        }, responseError: responseError)
    }
    
    public func createUser(id: String, firstName: String, lastName: String, email: String, responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {

        NetworkService.shared.createUser(id: id, firstName: firstName, lastName: lastName, email: email, responseSuccess: responseSuccess, responseError: responseError)
    }
    
    public func getUser(id: String, responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        
        NetworkService.shared.getUser(id: id, responseSuccess: { user in
            
            // Save to DataBase
            DataBaseManager.shared.saveObject(user)
            
            responseSuccess()
            
        }, responseError: responseError)
    }
}
