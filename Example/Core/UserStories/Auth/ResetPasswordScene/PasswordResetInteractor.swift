//
//  PasswordResetInteractor.swift
//  Example
//
//  Created by Data Kondzhariia on 4/22/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol PasswordResetBusinessLogic {
    
    func validationFiled(request: PasswordReset.ValidationForm.Request)
    
    func forgot(request: PasswordReset.Forgot.Request)
}

protocol PasswordResetDataStore {}

class PasswordResetInteractor {
    
    public var presenter: PasswordResetPresentationLogic?
    private var worker = PasswordResetWorker()
}

// MARK: - Private Method
extension PasswordResetInteractor {
    
    func generalError() {
        
        let error = ExampleError(kind: .other)
        
        let response = PasswordReset.Forgot.Response(error: error)
        presenter?.presentSignIn(response: response)
    }
}

// MARK: - Password Reset Business Logic
extension PasswordResetInteractor: PasswordResetBusinessLogic {

    func validationFiled(request: PasswordReset.ValidationForm.Request) {
        
        ValidationHelper.shared.isValidEmail(email: request.email, validationBlock: { success, error in
            
            let validationStatus = ValidationStatus(validationType: .email, errorMessage: error)
            
            let response = PasswordReset.ValidationForm.Response(validationStatus: validationStatus)
            presenter?.presentValidationForm(response: response)
        })
    }
    
    func forgot(request: PasswordReset.Forgot.Request) {
        
        worker.forgot(email: request.email ?? "", responseSuccess: { [weak self] in
        
            let response = PasswordReset.Forgot.Response(error: nil)
            self?.presenter?.presentSignIn(response: response)
        }, responseError: { [weak self] error in
            
            let response = PasswordReset.Forgot.Response(error: error)
            self?.presenter?.presentSignIn(response: response)
        })
    }
}

// MARK: - Password Reset Data Store
extension PasswordResetInteractor: PasswordResetDataStore {}
