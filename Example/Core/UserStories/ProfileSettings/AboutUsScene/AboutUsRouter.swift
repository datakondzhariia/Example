//
//  AboutUsRouter.swift
//  Example
//
//  Created by Data Kondzhariia on 5/2/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

@objc protocol AboutUsRoutingLogic {}

protocol AboutUsDataPassing {
    
    var dataStore: AboutUsDataStore? { get }
}

class AboutUsRouter: NSObject {

    weak var viewController: AboutUsViewController?
    public var dataStore: AboutUsDataStore?
}

// MARK: - About Us Routing Logic
extension AboutUsRouter: AboutUsRoutingLogic {}

// MARK: - About Us Data Passing
extension AboutUsRouter: AboutUsDataPassing {}
