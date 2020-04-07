//
//  MapInteractor.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol MapBusinessLogic {
    
    func setupLocationService(request: Map.SetupLocationService.Request)
    
    func showCurrentLocation(request: Map.ShowCurrentLocation.Request)
}

protocol MapDataStore {
        
    var latitude: Double? { get }
    var longitude: Double? { get }
}

class MapInteractor {
    
    public var presenter: MapPresentationLogic?
    private var worker = MapWorker()
    
    var latitude: Double?
    var longitude: Double?
}

// MARK: - Map Business Logic
extension MapInteractor: MapBusinessLogic {

    func setupLocationService(request: Map.SetupLocationService.Request) {
        
        worker.allowedAccessHandler = { [weak self] latitude, longitude in
            
            self?.latitude = latitude
            self?.longitude = longitude

            let response = Map.SetupLocationService.Response(error: nil)
            self?.presenter?.presentSetupLocationError(response: response)
        }
        
        worker.deniedAccessHandler = { [weak self] error in
            
            let response = Map.SetupLocationService.Response(error: error)
            self?.presenter?.presentSetupLocationError(response: response)
        }
        
        worker.setupLocationService()
    }

    func showCurrentLocation(request: Map.ShowCurrentLocation.Request) {
        
        let response = Map.ShowCurrentLocation.Response()
        presenter?.presentShowCurrentLocation(response: response)
    }
}

// MARK: - Map Data Store
extension MapInteractor: MapDataStore {}
