//
//  Constants.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright © 2019 Example. All rights reserved.
//

import CoreGraphics
import UIKit

let profileSettingsTopInset: CGFloat = 50

struct ExampleInfo {
    
    static let phoneNumber = "+380 98 865 5887"
    static let git = "www.example.com"
    static let email = "data199494@gmail.com"
    static let address = "Plaza 9 Kd Tower, Cotterells, Hemel Hempstead, Herts, United Kingdom, HP1 1F"
}

struct DeafultGooglePlacesSettings {
    
    enum Dev {
        
        static let key = "AIzaSyCZ2KTzNTSZWaVe1cjGgk76hjDkld3JANg"
    }

    // Default coordinates (London)
    enum Coordinates {
        
        static let latitude: Double = 51.509865
        static let longitude: Double = -0.118092
    }
    
    enum Camera {
        
        static let zoom: Float = 15
    }
}

enum ExampleTabBar: Int {
    
    case search = 0, profile
}
