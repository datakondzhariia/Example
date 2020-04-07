
//
//  MapModels.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import GoogleMaps

struct GMSCoordinates {
    
    let startLatitude: Double?
    let startLongitude: Double?
    
    let endLatitude: Double?
    let endLongitude: Double?
}

enum Map {
    
    struct DisplayedProvider: Equatable {
        
        let iconNamed: String!
        let latitude: Double!
        let longitude: Double!
    }
        
    enum SetupLocationService {
        
        struct Request {}
        struct Response {
            
            let error: ExampleError?
        }
        struct ViewModel {
            
            let error: ExampleError?
        }
    }
    
    enum UpdatingLocation {
        
        struct Request {}
        struct Response {
            
            let latitude: Double?
            let longitude: Double?
            let error: ExampleError?
        }
        struct ViewModel {
            
            struct DisplayedLocation {
                
                let latitude: Double?
                let longitude: Double?
            }
            
            let displayedLocation: DisplayedLocation!
            let error: ExampleError?
        }
    }
    
    enum StopLocation {
        
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
    
    enum ShowCurrentLocation {
     
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
    
    enum ChangeCameraLocation {
        
        struct Request {
            let latitude: Double?
            let longitude: Double?
        }
        struct Response {}
        struct ViewModel {}
    }
    
    enum ShowRouteToProvider {
        
        struct Request {
            
            let provider: DisplayedProvider!
        }
        struct Response {
            
            let provider: DisplayedProvider!
            let path: GMSPath?
            let coordinates: GMSCoordinates?
            let error: ExampleError?
        }
        struct ViewModel {
            
            let provider: DisplayedProvider!
            let path: GMSPath?
            let coordinates: GMSCoordinates?
            let error: ExampleError?
        }
    }
    
    enum CancelRoute {
        
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
}
