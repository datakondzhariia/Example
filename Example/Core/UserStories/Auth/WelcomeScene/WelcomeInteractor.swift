//
//  WelcomeInteractor.swift
//  Example
//
//  Created by Data Kondzhariia on 4/10/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol WelcomeBusinessLogic {
    
    func signUpFacebook(request: Welcome.Facebook.Request)

    func createFacebookUser(request: Welcome.CreateFacebookUser.Request)
    
    func fetchUser(request: Welcome.FetchUser.Request)
}

protocol WelcomeDataStore {}

class WelcomeInteractor {
    
    public var presenter: WelcomePresentationLogic?
    private var worker = WelcomeWorker()
}

// MARK: - Welcome Business Logic
extension WelcomeInteractor: WelcomeBusinessLogic {
    
    func signUpFacebook(request: Welcome.Facebook.Request) {
        
        FacebookHelper.shared.auth(responseSuccess: { token in
                        
            RegistrationHelper.shared.saveToken(token, for: .facebookSignUp)

            self.worker.signInFacebook(token: token, responseSuccess: { [weak self] in
                
                let response = Welcome.Facebook.Response(error: nil)
                self?.presenter?.presentSignUpFacebook(response: response)
            }, responseError: { [weak self] error in
                
                let response = Welcome.Facebook.Response(error: error)
                self?.presenter?.presentSignUpFacebook(response: response)
            })
        }, responseError: { [weak self] error in
            
            let response = Welcome.Facebook.Response(error: error)
            self?.presenter?.presentSignUpFacebook(response: response)
        })
    }
    
    func createFacebookUser(request: Welcome.CreateFacebookUser.Request) {

        let userID = RegistrationHelper.shared.getUserId()
        
        FacebookHelper.shared.getUser(responseSuccess: { [weak self] user in
            
            self?.worker.createUser(id: userID ?? "", firstName: user.firstName ?? "", lastName: user.lastName ?? "", email: user.email ?? "", responseSuccess: {
                
                let response = Welcome.CreateFacebookUser.Response(error: nil)
                self?.presenter?.presentCreateFacebookUser(response: response)
            }, responseError: { error in
                
                let response = Welcome.CreateFacebookUser.Response(error: error)
                self?.presenter?.presentCreateFacebookUser(response: response)
            })
        }, responseError: { [weak self] error in
            
            let response = Welcome.CreateFacebookUser.Response(error: error)
            self?.presenter?.presentCreateFacebookUser(response: response)
        })
    }
    
    func fetchUser(request: Welcome.FetchUser.Request) {
        
        let userID = RegistrationHelper.shared.getUserId()
        
        worker.getUser(id: userID ?? "", responseSuccess: { [weak self] in
            
            let response = Welcome.FetchUser.Response(error: nil)
            self?.presenter?.presentFetchUser(response: response)
        }, responseError: { [weak self] error in
                
            let response = Welcome.FetchUser.Response(error: error)
            self?.presenter?.presentFetchUser(response: response)
        })
    }
}

// MARK: - Welcome Data Store
extension WelcomeInteractor: WelcomeDataStore {}
