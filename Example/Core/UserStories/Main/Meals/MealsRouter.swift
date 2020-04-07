//
//  MealsRouter.swift
//  Example
//
//  Created by Data Kondzhariia on 24.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

@objc protocol MealsRoutingLogic {

}

protocol MealsDataPassing {
    
    var dataStore: MealsDataStore? { get }
}

class MealsRouter: NSObject {
    
    weak var viewController: MealsViewController?
    public var dataStore: MealsDataStore?
}

// MARK: - Meals Routing Logic
extension MealsRouter: MealsRoutingLogic {}

// MARK: - Meals Data Passing
extension MealsRouter: MealsDataPassing {}
