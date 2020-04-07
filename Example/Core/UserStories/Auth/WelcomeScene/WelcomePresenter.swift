//
//  WelcomePresenter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/10/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

protocol WelcomePresentationLogic {
    
    func presentSignUpFacebook(response: Welcome.Facebook.Response)
    
    func presentCreateFacebookUser(response: Welcome.CreateFacebookUser.Response)
    
    func presentFetchUser(response: Welcome.FetchUser.Response)
}

class WelcomePresenter {
    
    weak var viewController: WelcomeDisplayLogic?
}

// MARK: - Welcome Presentation Logic
extension WelcomePresenter: WelcomePresentationLogic {
    
    func presentSignUpFacebook(response: Welcome.Facebook.Response) {
        
        let viewModel = Welcome.Facebook.ViewModel(error: response.error)
        
        if response.error == nil {
            
            viewController?.displayFacebookSuccess(viewModel: viewModel)
        } else {
            
            viewController?.displayFacebookError(viewModel: viewModel)
        }
    }
    
    func presentCreateFacebookUser(response: Welcome.CreateFacebookUser.Response) {
     
        let viewModel = Welcome.CreateFacebookUser.ViewModel(error: response.error)
        
        if response.error == nil {
         
            viewController?.displayCreateFacebookUserSuccess(viewModel: viewModel)
        } else {

            viewController?.displayCreateFacebookUserError(viewModel: viewModel)
        }
    }
    
    func presentFetchUser(response: Welcome.FetchUser.Response) {
        
        let viewModel = Welcome.FetchUser.ViewModel(error: response.error)

        if response.error == nil {
            
            viewController?.displayFetchUserSuccess(viewModel: viewModel)
            
        } else {
            
            viewController?.displayFetchUserError(viewModel: viewModel)
        }
    }
}
