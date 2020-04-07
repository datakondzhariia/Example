//
//  MapPresenter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol MapPresentationLogic {
    
    func presentSetupLocationError(response: Map.SetupLocationService.Response)
    
    func presentShowCurrentLocation(response: Map.ShowCurrentLocation.Response)
}

class MapPresenter {
    
    weak var viewController: MapDisplayLogic?
}

// MARK: - Map Presentation Logic
extension MapPresenter: MapPresentationLogic {
    
    func presentSetupLocationError(response: Map.SetupLocationService.Response) {
        
        let viewModel = Map.SetupLocationService.ViewModel(error: response.error)

        if response.error == nil {
            
            viewController?.displayAllowedLocationAccess(viewModel: viewModel)
        } else {
            
            viewController?.displayDeniedLocationAccess(viewModel: viewModel)
        }
    }
    
    func presentShowCurrentLocation(response: Map.ShowCurrentLocation.Response) {
        
        let viewModel = Map.ShowCurrentLocation.ViewModel()
        viewController?.displayCurrentLocation(viewModel: viewModel)
    }
}
