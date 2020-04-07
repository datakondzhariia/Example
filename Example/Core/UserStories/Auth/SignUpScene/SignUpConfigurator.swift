//
//  SignUpConfigurator.swift
//  Example
//
//  Created by Data Kondzhariia on 23.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class SignUpConfigurator {

    static let shared = SignUpConfigurator()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
    
    public func configure(_ viewController: SignUpViewController) {
        
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        let router = SignUpRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
