//
//  TermsFeedInteractor.swift
//  Example
//
//  Created by Data Kondzhariia on 4/18/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol TermsFeedBusinessLogic {
    
    func setupCurrentTermsFeedInfo(request: TermsFeedInfo.SetupInfo.Request)
}

protocol TermsFeedDataStore {
    
    func setupTermsConditionsInfo()
    func setupPrivacyPolicy()
}

class TermsFeedInteractor {
    
    public var presenter: TermsFeedPresentationLogic?
    private var worker = TermsFeedWorker()
    
    public var termsFeedMode: ExampleInfoMode = .termsConditions
}

// MARK: - Terms Feed Business Logic
extension TermsFeedInteractor: TermsFeedBusinessLogic {
    
    func setupCurrentTermsFeedInfo(request: TermsFeedInfo.SetupInfo.Request) {
        
        worker.getValue(mode: termsFeedMode, responseSuccess: { [weak self] value in
            
            let response = TermsFeedInfo.SetupInfo.Response(value: value, mode: self?.termsFeedMode ?? .termsConditions, error: nil)
            self?.presenter?.presentTermsFeedInfo(response: response)
        }, responseError: { [weak self] error in
            
            let response = TermsFeedInfo.SetupInfo.Response(value: nil, mode: self?.termsFeedMode ?? .termsConditions, error: error)
            self?.presenter?.presentTermsFeedInfo(response: response)
        })
    }
}

// MARK: - Terms Feed Data Store
extension TermsFeedInteractor: TermsFeedDataStore {
    
    func setupTermsConditionsInfo() {
        
        termsFeedMode = .termsConditions
    }
    
    func setupPrivacyPolicy() {
        
        termsFeedMode = .privacyPolicy
    }
}
