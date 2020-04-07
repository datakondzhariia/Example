//
//  SignUpInteractor.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol SignUpBusinessLogic {
    
    func validationFileds(request: SignUp.ValidationForm.Request)
    
    func signUp(request: SignUp.Register.Request)
    
    func signUpFacebook(request: SignUp.Facebook.Request)
    
    // Create user to Firebase Database
    func createUser(request: SignUp.CreateUser.Request)
    
    func createFacebookUser(request: SignUp.CreateFacebookUser.Request)
    
    func fetchUser(request: SignUp.FetchUser.Request)

    func formCleanUp(request: SignUp.FormCleanUp.Request)
}

protocol SignUpDataStore {}

class SignUpInteractor {
    
    public var presenter: SignUpPresentationLogic?
    private var worker = SignUpWorker()
}

// MARK: - Sign Up Business Logic
extension SignUpInteractor: SignUpBusinessLogic {

    func validationFileds(request: SignUp.ValidationForm.Request) {
        
        var validationStatuses = [ValidationStatus]()
        
        ValidationHelper.shared.isValidFirstName(firstName: request.firstName) { success, error in
            
            let validationStatus = ValidationStatus(validationType: .firstName, errorMessage: error)
            validationStatuses.append(validationStatus)
        }
        
        ValidationHelper.shared.isValidLastName(lastName: request.lastName) { success, error in
            
            let validationStatus = ValidationStatus(validationType: .lastName, errorMessage: error)
            validationStatuses.append(validationStatus)
        }
        
        ValidationHelper.shared.isValidEmail(email: request.email) { success, error in
            
            let validationStatus = ValidationStatus(validationType: .email, errorMessage: error)
            validationStatuses.append(validationStatus)
        }
        
        ValidationHelper.shared.isValidPassword(password: request.password) { success, error in
            
            let validationStatus = ValidationStatus(validationType: .password, errorMessage: error)
            validationStatuses.append(validationStatus)
        }
        
        // Failure Fields Validation
        let response = SignUp.ValidationForm.Response(validationStatuses: validationStatuses)
        presenter?.presentValidationForm(response: response)
    }
    
    func signUp(request: SignUp.Register.Request) {
        
        worker.manualSignUp(firstName: request.firstName ?? "", lastName: request.lastName ?? "", email: request.email ?? "", password: request.password ?? "", responseSuccess: { [weak self] in
            
            let response = SignUp.Register.Response(error: nil)
            self?.presenter?.presentSignUp(response: response)
        }, responseError: { [weak self] error in
            
            let response = SignUp.Register.Response(error: error)
            self?.presenter?.presentSignUp(response: response)
        })
    }
    
    func signUpFacebook(request: SignUp.Facebook.Request) {
        
        FacebookHelper.shared.auth(responseSuccess: { token in
                        
            RegistrationHelper.shared.saveToken(token, for: .facebookSignUp)

            self.worker.signInFacebook(token: token, responseSuccess: { [weak self] in
                
                let response = SignUp.Facebook.Response(error: nil)
                self?.presenter?.presentSignUpFacebook(response: response)
            }, responseError: { [weak self] error in
                
                let response = SignUp.Facebook.Response(error: error)
                self?.presenter?.presentSignUpFacebook(response: response)
            })
        }, responseError: { [weak self] error in
            
            let response = SignUp.Facebook.Response(error: error)
            self?.presenter?.presentSignUpFacebook(response: response)
        })
    }
    
    func createUser(request: SignUp.CreateUser.Request) {
        
        let userID = RegistrationHelper.shared.getUserId()
        
        worker.createUser(id: userID ?? "", firstName: request.firstName ?? "", lastName: request.lastName ?? "", email: request.email ?? "", responseSuccess: { [weak self] in
            
            let response = SignUp.CreateUser.Response(error: nil)
            self?.presenter?.presentCreateUser(response: response)
        }, responseError: { [weak self] error in
            
            let response = SignUp.CreateUser.Response(error: error)
            self?.presenter?.presentCreateUser(response: response)
        })
    }
    
    func createFacebookUser(request: SignUp.CreateFacebookUser.Request) {
        
        let userID = RegistrationHelper.shared.getUserId()
        
        FacebookHelper.shared.getUser(responseSuccess: { [weak self] user in
            
            self?.worker.createUser(id: userID ?? "", firstName: user.firstName ?? "", lastName: user.lastName ?? "", email: user.email ?? "", responseSuccess: {
                
                let response = SignUp.CreateFacebookUser.Response(error: nil)
                self?.presenter?.presentCreateFacebookUser(response: response)
            }, responseError: { error in
                
                let response = SignUp.CreateFacebookUser.Response(error: error)
                self?.presenter?.presentCreateFacebookUser(response: response)
            })
        }, responseError: { [weak self] error in
            
            let response = SignUp.CreateFacebookUser.Response(error: error)
            self?.presenter?.presentCreateFacebookUser(response: response)
        })
    }

    func fetchUser(request: SignUp.FetchUser.Request) {
        
        let userID = RegistrationHelper.shared.getUserId()
        
        worker.getUser(id: userID ?? "", responseSuccess: { [weak self] in
            
            let response = SignUp.FetchUser.Response(error: nil)
            self?.presenter?.presentFetchUser(response: response)
        }, responseError: { [weak self] error in
            
            let response = SignUp.FetchUser.Response(error: error)
            self?.presenter?.presentFetchUser(response: response)
        })
    }

    func formCleanUp(request: SignUp.FormCleanUp.Request) {
        
        let response = SignUp.FormCleanUp.Response()
        presenter?.presentFormCleanUp(response: response)
    }
}

// MARK: - Sign Up Data Store
extension SignUpInteractor: SignUpDataStore {}
