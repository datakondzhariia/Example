//
//  HomeRouter.swift
//  Example
//
//  Created by Data Kondzhariia on 5/13/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    
    func routeToMap(segue: UIStoryboardSegue)
}

class HomeRouter: NSObject {
    
    weak var viewController: HomeViewController?
    weak var mapViewController: MapViewController?
}

// MARK: - Home Routing Logic
extension HomeRouter: HomeRoutingLogic {
    
    func routeToMap(segue: UIStoryboardSegue) {
        
        if let mapViewController = segue.destination as? MapViewController {
            
            self.mapViewController = mapViewController
            self.mapViewController?.delegate = viewController
        }
    }
}
