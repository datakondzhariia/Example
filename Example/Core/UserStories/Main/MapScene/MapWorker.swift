//
//  MapWorker.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class MapWorker: NSObject {
    
    typealias CompletionHandler = () -> Void

    private let locationManager = CLLocationManager()

    public var updateHandler: ((_ latitude: Double?, _ longitude: Double?) -> Void)?
    public var allowedAccessHandler: ((_ latitude: Double?, _ longitude: Double?) -> Void)?
    public var deniedAccessHandler: ((_ error: ExampleError?) -> Void)?
    public var errorHandler: ((_ error: ExampleError?) -> Void)?
    
    public func setupLocationService() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func startLocationUpdating() {
        
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringVisits()
    }
    
    public func stopLocationUpdating() {
        
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringVisits()
    }
}

// MARK: - CLLocation Manager Delegate
extension MapWorker: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        updateHandler?(locations.last?.coordinate.latitude, locations.last?.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {}
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        
        stopLocationUpdating()
        
        let error = ExampleError(message: error.localizedDescription)
        errorHandler?(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        let latitude = manager.location?.coordinate.latitude
        let longitude = manager.location?.coordinate.longitude
        
        switch status {
        case .authorizedAlways:
            
            allowedAccessHandler?(latitude, longitude)
        case .authorizedWhenInUse:
            
            allowedAccessHandler?(latitude, longitude)
        case .denied:
            
            let error = ExampleError(kind: .noAccessLocation)
            deniedAccessHandler?(error)
        default:
            break
        }
    }
}
