//
//  ProfileSettingsInteractor.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol ProfileSettingsBusinessLogic {
    
    func setupProfileInfo(request: ProfileSettings.SetupInfo.Request)
    
    func setupAppVersion(request: ProfileSettings.Version.Request)
    
    func updateUserInfo(request: ProfileSettings.UpdateUserInfo.Request)
    
    func logOut(request: ProfileSettings.LogOut.Request)
}

protocol ProfileSettingsDataStore {}

class ProfileSettingsInteractor {

    public var presenter: ProfileSettingsPresentationLogic?
    private var worker = ProfileSettingsWorker()
}

// MARK: - Profile Settings Business Logic
extension ProfileSettingsInteractor: ProfileSettingsBusinessLogic {
    
    func setupProfileInfo(request: ProfileSettings.SetupInfo.Request) {
        
        let user = DataBaseManager.shared.getObjectResults(object: User.self).last

        let response = ProfileSettings.SetupInfo.Response(user: user)
        presenter?.presentProfileInfo(response: response)
    }
    
    func setupAppVersion(request: ProfileSettings.Version.Request) {
        
        if let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
         
            let response = ProfileSettings.Version.Response(appVersion: "Version \(appVersion)")
            presenter?.presentAppVersion(response: response)
        }
    }
    
    func updateUserInfo(request: ProfileSettings.UpdateUserInfo.Request) {
     
        worker.getUserData(responseSuccess: { [weak self] user in
            
            let response = ProfileSettings.UpdateUserInfo.Response(user: user, error: nil)
            self?.presenter?.presentUpdateUserInfo(response: response)
        }, responseError: { [weak self] error in
            
            let user = DataBaseManager.shared.getObjectResults(object: User.self).last

            let response = ProfileSettings.UpdateUserInfo.Response(user: user, error: error)
            self?.presenter?.presentUpdateUserInfo(response: response)
        })
    }

    func logOut(request: ProfileSettings.LogOut.Request) {
     
        worker.logOut(responseSuccess: { [weak self] in
                        
            let response = ProfileSettings.LogOut.Response(error: nil)
            self?.presenter?.presentLogOut(response: response)
        }, responseError: { [weak self] (error) in
            
            let response = ProfileSettings.LogOut.Response(error: error)
            self?.presenter?.presentLogOut(response: response)
        })
    }
}

// MARK: - Profile Settings Data Store
extension ProfileSettingsInteractor: ProfileSettingsDataStore {}
