//
//  SignInPresenter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol SignInPresentationLogic {
    
    func presentValidationForm(response: SignIn.ValidationForm.Response)
    
    func presentSignIn(response: SignIn.Register.Response)
    
    func presentFetchUser(response: SignIn.FetchUser.Response)
    
    func presentFormCleanUp(response: SignIn.FormCleanUp.Response)
}

class SignInPresenter {
    
    weak var viewController: SignInDisplayLogic?
}

// MARK: - Sign In Presentation Logic
extension SignInPresenter: SignInPresentationLogic {
    
    func presentValidationForm(response: SignIn.ValidationForm.Response) {
        
        let successFields = response.validationStatuses.filter { $0.success == true }
        let failedFields = response.validationStatuses.filter { $0.success == false }
        
        if successFields.isEmpty == false {
            
            let viewModel = SignIn.ValidationForm.ViewModel(validationStatuses: successFields)
            viewController?.displayFieldSuccess(viewModel: viewModel)
        }
        
        if failedFields.isEmpty == false {
            
            let viewModel = SignIn.ValidationForm.ViewModel(validationStatuses: failedFields)
            viewController?.displayFieldError(viewModel: viewModel)
        } else {
            
            let viewModel = SignIn.ValidationForm.ViewModel(validationStatuses: response.validationStatuses)
            viewController?.displayFormSuccess(viewModel: viewModel)
        }
    }
    
    func presentSignIn(response: SignIn.Register.Response) {
        
        let viewModel = SignIn.Register.ViewModel(error: response.error)
        
        if response.error == nil {
            
            viewController?.displayRegistrationSuccess(viewModel: viewModel)
        } else {
            
            viewController?.displayRegistrationError(viewModel: viewModel)
        }
    }
    
    func presentFetchUser(response: SignIn.FetchUser.Response) {
        
        let viewModel = SignIn.FetchUser.ViewModel(error: response.error)

        if response.error == nil {
            
            viewController?.displayFetchUserSuccess(viewModel: viewModel)
            
        } else {
            
            viewController?.displayFetchUserError(viewModel: viewModel)
        }
    }
    
    func presentFormCleanUp(response: SignIn.FormCleanUp.Response) {
     
        let viewModel = SignIn.FormCleanUp.ViewModel()
        viewController?.displayCleanForm(viewModel: viewModel)
    }
}
