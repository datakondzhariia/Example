//
//  WelcomeWorker.swift
//  Example
//
//  Created by Data Kondzhariia on 4/10/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

class WelcomeWorker {
    
    typealias ResponseSuccess = () -> Void
    typealias ResponseError = (_ error: ExampleError?) -> Void
}

// MARK: - Public Methods
extension WelcomeWorker {
    
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
