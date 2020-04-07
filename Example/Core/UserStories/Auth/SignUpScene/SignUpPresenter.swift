//
//  SignUpPresenter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

protocol SignUpPresentationLogic {
    
    func presentValidationForm(response: SignUp.ValidationForm.Response)
    
    func presentSignUp(response: SignUp.Register.Response)
    
    func presentSignUpFacebook(response: SignUp.Facebook.Response)
    
    func presentCreateUser(response: SignUp.CreateUser.Response)
    
    func presentCreateFacebookUser(response: SignUp.CreateFacebookUser.Response)
    
    func presentFetchUser(response: SignUp.FetchUser.Response)

    func presentFormCleanUp(response: SignUp.FormCleanUp.Response)
}

class SignUpPresenter {
    
    weak var viewController: SignUpDisplayLogic?
}

// MARK: - Sign Up Presentation Logic
extension SignUpPresenter: SignUpPresentationLogic {
    
    func presentValidationForm(response: SignUp.ValidationForm.Response) {
        
        let successFields = response.validationStatuses.filter { $0.success == true }
        let failedFields = response.validationStatuses.filter { $0.success == false }
        
        if successFields.isEmpty == false {
            
            let viewModel = SignUp.ValidationForm.ViewModel(validationStatuses: successFields)
            viewController?.displayFieldSuccess(viewModel: viewModel)
        }
        
        if failedFields.isEmpty == false {
            
            let viewModel = SignUp.ValidationForm.ViewModel(validationStatuses: failedFields)
            viewController?.displayFieldError(viewModel: viewModel)
        } else {
            
            let viewModel = SignUp.ValidationForm.ViewModel(validationStatuses: response.validationStatuses)
            viewController?.displayFormSuccess(viewModel: viewModel)
        }
    }

    func presentSignUp(response: SignUp.Register.Response) {
        
        let viewModel = SignUp.Register.ViewModel(error: response.error)
        
        if response.error != nil {
            
            viewController?.displayRegistrationError(viewModel: viewModel)
        } else {
            
            viewController?.displayRegistrationSuccess(viewModel: viewModel)
        }
    }
    
    func presentSignUpFacebook(response: SignUp.Facebook.Response) {

        let viewModel = SignUp.Facebook.ViewModel(error: response.error)
        
        if response.error == nil {
            
            viewController?.displayFacebookSuccess(viewModel: viewModel)
        } else {
            
            viewController?.displayFacebookError(viewModel: viewModel)
        }
    }
    
    func presentCreateUser(response: SignUp.CreateUser.Response) {
        
        let viewModel = SignUp.CreateUser.ViewModel(error: response.error)
        
        if response.error == nil {
         
            viewController?.displayCreateUserSuccess(viewModel: viewModel)
        } else {

            viewController?.displayCreateUserError(viewModel: viewModel)
        }
    }
    
    func presentCreateFacebookUser(response: SignUp.CreateFacebookUser.Response) {
        
        let viewModel = SignUp.CreateFacebookUser.ViewModel(error: response.error)
        
        if response.error == nil {
         
            viewController?.displayCreateFacebookUserSuccess(viewModel: viewModel)
        } else {

            viewController?.displayCreateFacebookUserError(viewModel: viewModel)
        }
    }
    
    func presentFetchUser(response: SignUp.FetchUser.Response) {
        
        let viewModel = SignUp.FetchUser.ViewModel(error: response.error)

        if response.error == nil {
            
            viewController?.displayFetchUserSuccess(viewModel: viewModel)
            
        } else {
            
            viewController?.displayFetchUserError(viewModel: viewModel)
        }
    }
    
    func presentFormCleanUp(response: SignUp.FormCleanUp.Response) {
        
        let viewModel = SignUp.FormCleanUp.ViewModel()
        viewController?.displayCleanForm(viewModel: viewModel)
    }
}
