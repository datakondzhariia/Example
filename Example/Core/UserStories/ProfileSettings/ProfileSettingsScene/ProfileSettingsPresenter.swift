//
//  ProfileSettingsPresenter.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol ProfileSettingsPresentationLogic {
    
    func presentProfileInfo(response: ProfileSettings.SetupInfo.Response)
    
    func presentUpdateUserInfo(response: ProfileSettings.UpdateUserInfo.Response)
    
    func presentAppVersion(response: ProfileSettings.Version.Response)
    
    func presentLogOut(response: ProfileSettings.LogOut.Response)
}

class ProfileSettingsPresenter {
    
    weak var viewController: ProfileSettingsDisplayLogic?
}

// MARK: - Profile Settings Presentation Logic
extension ProfileSettingsPresenter: ProfileSettingsPresentationLogic {
    
    func presentProfileInfo(response: ProfileSettings.SetupInfo.Response) {

        let displayedUser = ProfileSettings.DisplayedUser(fullName: response.user.fullName, email: response.user.email)
        
        let viewModel = ProfileSettings.SetupInfo.ViewModel(displayedUser: displayedUser)
        viewController?.displayProfileInfo(viewModel: viewModel)
    }
    
    func presentUpdateUserInfo(response: ProfileSettings.UpdateUserInfo.Response) {
        
        let displayedUser = ProfileSettings.DisplayedUser(fullName: response.user.fullName, email: response.user.email)

        let viewModel = ProfileSettings.UpdateUserInfo.ViewModel(displayedUser: displayedUser, error: response.error)
        
        if response.error == nil {
            
            viewController?.displayUpdateUserInfoSuccess(viewModel: viewModel)
        } else {
            
            viewController?.displayUpdateUserInfoError(viewModel: viewModel)
        }
    }

    func presentAppVersion(response: ProfileSettings.Version.Response) {
        
        let viewModel = ProfileSettings.Version.ViewModel(appVersion: response.appVersion)
        viewController?.displayAppVersion(viewModel: viewModel)
    }
    
    func presentLogOut(response: ProfileSettings.LogOut.Response) {
        
        let viewModel = ProfileSettings.LogOut.ViewModel(error: response.error)
        
        if response.error == nil {
            
            viewController?.displayLogOutSuccess(viewModel: viewModel)
        } else {
            
            viewController?.displayLogOutError(viewModel: viewModel)
        }
    }
}
