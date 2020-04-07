//
//  SplashPresenter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol SplashPresentationLogic {
    
    func presentCheckAuthorizedUser(response: Splash.CheckAuth.Response)
}

class SplashPresenter {
    
    weak var viewController: SplashDisplayLogic?
}

// MARK: - Splash Presentation Logic
extension SplashPresenter: SplashPresentationLogic {
    
    func presentCheckAuthorizedUser(response: Splash.CheckAuth.Response) {

        let viewModel = Splash.CheckAuth.ViewModel()
        
        if response.isAuthorized {
            
            viewController?.displayAuthorized(viewModel: viewModel)
        } else {
            
            viewController?.displayUnauthorized(viewModel: viewModel)
        }
    }
}
