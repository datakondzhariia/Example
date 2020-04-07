//
//  ProfileSettingsWorker.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

class ProfileSettingsWorker {
    
    typealias ResponseUserSuccess = (_ user: User) -> Void
    typealias ResponseSuccess = () -> Void
    typealias ResponseError = (_ error: ExampleError?) -> Void
}

// MARK: - Private Method
extension ProfileSettingsWorker {
    
    private func cleatUserInfo() {
        
        if let user = DataBaseManager.shared.getObjectResults(object: User.self).last {

            DataBaseManager.shared.deleteObjectFromDataBase(user)
        }

        KeychainService.shared.remove(key: .access)
    }
}

// MARK: - Public Methods
extension ProfileSettingsWorker {    
    
    public func getUserData(responseSuccess: @escaping ResponseUserSuccess, responseError: @escaping ResponseError) {
     
        let user = DataBaseManager.shared.getObjectResults(object: User.self).last
        
        NetworkService.shared.getUser(id: user?.id ?? "", responseSuccess: { user in
            
            DataBaseManager.shared.saveObject(user)
            
            responseSuccess(user)
            
        }, responseError: responseError)
    }
    
    public func logOut(responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        
        NetworkService.shared.logOut(responseSuccess: { [weak self] in
            
            self?.cleatUserInfo()
            
            responseSuccess()
            
        }, responseError: { [weak self] error in
            
            self?.cleatUserInfo()

            responseError(error)
        })
    }
}
