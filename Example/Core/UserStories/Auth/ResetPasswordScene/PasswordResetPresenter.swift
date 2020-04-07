//
//  PasswordResetPresenter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/22/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol PasswordResetPresentationLogic {
    
    func presentValidationForm(response: PasswordReset.ValidationForm.Response)
    
    func presentSignIn(response: PasswordReset.Forgot.Response)
}

class PasswordResetPresenter {
    
    weak var viewController: PasswordResetDisplayLogic?
}

// MARK: - Password Reset Presentation Logic
extension PasswordResetPresenter: PasswordResetPresentationLogic {
    
    func presentValidationForm(response: PasswordReset.ValidationForm.Response) {
        
        let viewModel = PasswordReset.ValidationForm.ViewModel(validationStatus: response.validationStatus)
        
        if response.validationStatus.success {
            
            viewController?.displayFieldSuccess(viewModel: viewModel)
            viewController?.displayFormSuccess(viewModel: viewModel)
        } else {
            
            viewController?.displayFieldError(viewModel: viewModel)
        }
    }
    
    func presentSignIn(response: PasswordReset.Forgot.Response) {
        
        let viewModel = PasswordReset.Forgot.ViewModel(error: response.error)
        
        if response.error == nil {
            
            viewController?.displayForgotSuccess(viewModel: viewModel)
            
        } else {
            
            viewController?.displayForgotError(viewModel: viewModel)
        }
    }
}
