//
//  TermsFeedRouter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/18/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

@objc protocol TermsFeedRoutingLogic {
}

protocol TermsFeedDataPassing {
    
    var dataStore: TermsFeedDataStore? { get }
}

class TermsFeedRouter: NSObject {
    
    weak var viewController: TermsFeedViewController?
    public var dataStore: TermsFeedDataStore?
    
}

// MARK: - Terms Feed Routing Logic
extension TermsFeedRouter: TermsFeedRoutingLogic {
}

// MARK: Terms Feed Data Passing
extension TermsFeedRouter: TermsFeedDataPassing {}
