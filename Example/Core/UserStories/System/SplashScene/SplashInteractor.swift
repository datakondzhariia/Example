//
//  SplashInteractor.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol SplashBusinessLogic {
    
    func checkAuthorizedUser(request: Splash.CheckAuth.Request)
}

protocol SplashDataStore {}

class SplashInteractor {
    
    public var presenter: SplashPresentationLogic?
}

// MARK: - Private Method
extension SplashInteractor {
    
    private func isAuthorized() -> Bool {
        
        guard let token = KeychainService.shared.get(key: .access) else {
            return false
        }
        
        return token.isEmpty == false
    }
}

// MARK: - Splash Business Logic
extension SplashInteractor: SplashBusinessLogic {
    
    func checkAuthorizedUser(request: Splash.CheckAuth.Request) {
        
        let response = Splash.CheckAuth.Response(isAuthorized: isAuthorized())
        presenter?.presentCheckAuthorizedUser(response: response)
    }
}

// MARK: - Splash Data Store
extension SplashInteractor: SplashDataStore {}
