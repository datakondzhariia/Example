//
//  SignInWorker.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

class SignInWorker {
    
    typealias ResponseSuccess = () -> Void
    typealias ResponseError = (_ error: ExampleError?) -> Void
}

// MARK: - Public Method
extension SignInWorker {
    
    public func signIn(email: String, password: String, responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        
        NetworkService.shared.signIn(email: email, password: password, responseSuccess: { token, userID in
            
            KeychainService.shared.save(token: token, key: .access)
            
            RegistrationHelper.shared.saveUserId(userID, for: .signIn)
            
            responseSuccess()
            
        }, responseError: responseError)
    }
    
    public func getUser(id: String, responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        
        NetworkService.shared.getUser(id: id, responseSuccess: { user in
            
            // Save to DataBase
            DataBaseManager.shared.saveObject(user)
            
            responseSuccess()
            
        }, responseError: responseError)
    }
}
