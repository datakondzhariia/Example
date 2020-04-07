//
//  TermsFeedConfigurator.swift
//  Example
//
//  Created by Data Kondzhariia on 23.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class TermsFeedConfigurator {

    static let shared = TermsFeedConfigurator()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
    
    public func configure(_ viewController: TermsFeedViewController) {
        
        let interactor = TermsFeedInteractor()
        let presenter = TermsFeedPresenter()
        let router = TermsFeedRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
