//
//  MapConfigurator.swift
//  Example
//
//  Created by Data Kondzhariia on 23.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

final class MapConfigurator {

    static let shared = MapConfigurator()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
    
    public func configure(_ viewController: MapViewController) {
        
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        
        viewController.interactor = interactor        
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
