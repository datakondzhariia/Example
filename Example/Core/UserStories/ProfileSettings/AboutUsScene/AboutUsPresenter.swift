//
//  AboutUsPresenter.swift
//  Example
//
//  Created by Data Kondzhariia on 5/2/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

protocol AboutUsPresentationLogic {
    
    func presentExampleInfo(response: AboutUs.SetupInfo.Response)
    
    func presentCallPhoneNumber(response: AboutUs.PhoneNumber.Response)
    
    func presentComposeMail(response: AboutUs.ComposeMail.Response)
    
    func presentGit(response: AboutUs.Git.Response)
    
    func presentAddressOnMap(response: AboutUs.Location.Response)
}

class AboutUsPresenter {
    
    weak var viewController: AboutUsDisplayLogic?
}

// MARK: - About Us Presentation Logic
extension AboutUsPresenter: AboutUsPresentationLogic {

    func presentExampleInfo(response: AboutUs.SetupInfo.Response) {
        
        let displayedInfo = AboutUs.SetupInfo.ViewModel.DisplayedInfo(phoneNumber: response.exampleInfo.phoneNumber, git: response.exampleInfo.git, email: response.exampleInfo.email, location: response.exampleInfo.location, value: response.exampleInfo.value)
        
        let viewModel = AboutUs.SetupInfo.ViewModel(displayedInfo: displayedInfo, error: response.error)
        
        if response.error == nil {
            
            viewController?.displayExampleInfoSuccess(viewModel: viewModel)
        } else {
            
            viewController?.displayExampleInfoError(viewModel: viewModel)
        }
    }
    
    func presentCallPhoneNumber(response: AboutUs.PhoneNumber.Response) {
     
        let viewModel = AboutUs.PhoneNumber.ViewModel(url: response.url)
        viewController?.displayCallPhoneNumber(viewModel: viewModel)
    }
    
    func presentComposeMail(response: AboutUs.ComposeMail.Response) {
        
        let viewModel = AboutUs.ComposeMail.ViewModel(error: response.error)
        
        if response.error == nil {
            
            viewController?.displayComposeMailSuccess(viewModel: viewModel)
        } else {
            
            viewController?.displayComposeMailError(viewModel: viewModel)
        }
    }
    
    func presentGit(response: AboutUs.Git.Response) {
        
        let viewModel = AboutUs.Git.ViewModel(url: response.url)
        viewController?.displayGit(viewModel: viewModel)
    }
    
    func presentAddressOnMap(response: AboutUs.Location.Response) {
        
        let viewModel = AboutUs.Location.ViewModel(url: response.url)
        viewController?.displayAddressOnMap(viewModel: viewModel)
    }
}
