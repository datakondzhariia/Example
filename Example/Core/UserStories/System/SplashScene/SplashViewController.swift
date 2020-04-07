//
//  SplashViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol SplashDisplayLogic: class {
    
    func displayAuthorized(viewModel: Splash.CheckAuth.ViewModel)
    func displayUnauthorized(viewModel: Splash.CheckAuth.ViewModel)
}

class SplashViewController: UIViewController {
        
    public var interactor: SplashBusinessLogic?
    public var router: (NSObjectProtocol & SplashRoutingLogic & SplashDataPassing)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SplashConfigurator.shared.configure(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkAuth()        
    }
}

// MARK: - Private Methods
extension SplashViewController {
    
    private func checkAuth() {
        
        let request = Splash.CheckAuth.Request()
        interactor?.checkAuthorizedUser(request: request)
    }
}

// MARK: - Splash Display Logic
extension SplashViewController: SplashDisplayLogic {
    
    func displayAuthorized(viewModel: Splash.CheckAuth.ViewModel) {
        
        router?.navigateToMain()
    }
    
    func displayUnauthorized(viewModel: Splash.CheckAuth.ViewModel) {
        
        router?.navigateToWelcome()
    }
}
