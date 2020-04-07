//
//  HomeConfigurator.swift
//  Example
//
//  Created by Data Kondzhariia on 23.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class HomeConfigurator {

    static let shared = HomeConfigurator()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
    
    public func configure(_ viewController: HomeViewController) {
        
        let router = HomeRouter()        
        viewController.router = router
        router.viewController = viewController
    }
}
