//
//  SplashConfigurator.swift
//  Example
//
//  Created by Data Kondzhariia on 23.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

final class SplashConfigurator {

    static let shared = SplashConfigurator()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
    
    public func configure(_ viewController: SplashViewController) {
        
        let interactor = SplashInteractor()
        let presenter = SplashPresenter()
        let router = SplashRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
