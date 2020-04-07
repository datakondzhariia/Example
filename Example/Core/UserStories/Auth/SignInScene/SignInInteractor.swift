//
//  SignInInteractor.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

protocol SignInBusinessLogic {
    
    func validationFileds(request: SignIn.ValidationForm.Request)
    
    func signIn(request: SignIn.Register.Request)
    
    func fetchUser(request: SignIn.FetchUser.Request)
    
    func formCleanUp(request: SignIn.FormCleanUp.Request)
}

protocol SignInDataStore {}

class SignInInteractor {
    
    public var presenter: SignInPresentationLogic?
    private var worker = SignInWorker()
    
    private var phoneCode: String!
    private var region: String!
}

// MARK: - Sign In Business Logic
extension SignInInteractor: SignInBusinessLogic {
    
    func validationFileds(request: SignIn.ValidationForm.Request) {
        
        var validationStatuses = [ValidationStatus]()

        ValidationHelper.shared.isValidEmail(email: request.email, validationBlock: { success, error in
            
            let validationStatus = ValidationStatus(validationType: .email, errorMessage: error)
            validationStatuses.append(validationStatus)
        })
        
        ValidationHelper.shared.isValidPassword(password: request.password) { success, error in
            
            let validationStatus = ValidationStatus(validationType: .password, errorMessage: error)
            validationStatuses.append(validationStatus)
        }
        
        // Failure Fields Validation
        let response = SignIn.ValidationForm.Response(validationStatuses: validationStatuses)
        presenter?.presentValidationForm(response: response)
    }
    
    func signIn(request: SignIn.Register.Request) {
        
        worker.signIn(email: request.email ?? "", password: request.password ?? "", responseSuccess: { [weak self] in
            
            let response = SignIn.Register.Response(error: nil)
            self?.presenter?.presentSignIn(response: response)
        }, responseError: { [weak self] error in
            
            let response = SignIn.Register.Response(error: error)
            self?.presenter?.presentSignIn(response: response)
        })
    }
    
    func fetchUser(request: SignIn.FetchUser.Request) {
        
        let userID = RegistrationHelper.shared.getUserId()
        
        worker.getUser(id: userID ?? "", responseSuccess: { [weak self] in
            
            let response = SignIn.FetchUser.Response(error: nil)
            self?.presenter?.presentFetchUser(response: response)
        }, responseError: { [weak self] error in
            
            let response = SignIn.FetchUser.Response(error: error)
            self?.presenter?.presentFetchUser(response: response)
        })
    }
    
    func formCleanUp(request: SignIn.FormCleanUp.Request) {
        
        let response = SignIn.FormCleanUp.Response()
        presenter?.presentFormCleanUp(response: response)
    }
}

// MARK: - SignInDataStore realisation methods
extension SignInInteractor: SignInDataStore {}
