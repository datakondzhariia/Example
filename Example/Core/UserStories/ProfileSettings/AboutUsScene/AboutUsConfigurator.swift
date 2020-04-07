//
//  AboutUsConfigurator.swift
//  Example
//
//  Created by Data Kondzhariia on 23.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class AboutUsConfigurator {

    static let shared = AboutUsConfigurator()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
    
    public func configure(_ viewController: AboutUsViewController) {
        
        let interactor = AboutUsInteractor()
        let presenter = AboutUsPresenter()
        let router = AboutUsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

