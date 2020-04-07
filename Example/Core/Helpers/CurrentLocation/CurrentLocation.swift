//
//  CurrentLocation.swift
//  Example
//
//  Created by Data Kondzhariia on 10/15/19.
//  Copyright © 2019 Example. All rights reserved.
//

import CoreLocation

class CurrentLocation {
    
    static let shared = CurrentLocation()
    
    private let locationManager = CLLocationManager()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
}

// MARK: - Public Methods
extension CurrentLocation {
    
    public func startLocationUpdating() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringVisits()
    }
    
    public func stopLocationUpdating() {
        
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringVisits()
    }
}
