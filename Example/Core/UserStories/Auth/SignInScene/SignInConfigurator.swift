//
//  SignInConfigurator.swift
//  Example
//
//  Created by Data Kondzhariia on 23.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class SignInConfigurator {

    static let shared = SignInConfigurator()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
    
    public func configure(_ viewController: SignInViewController) {
        
        let interactor = SignInInteractor()
        let presenter = SignInPresenter()
        let router = SignInRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}


