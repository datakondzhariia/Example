//
//  AboutUsInteractor.swift
//  Example
//
//  Created by Data Kondzhariia on 5/2/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import MessageUI

protocol AboutUsBusinessLogic {
    
    func setupExampleInfo(request: AboutUs.SetupInfo.Request)
    
    func callPhoneNumber(request: AboutUs.PhoneNumber.Request)
    
    func composeMail(request: AboutUs.ComposeMail.Request)
    
    func openGit(request: AboutUs.Git.Request)
    
    func openAddressOnMap(request: AboutUs.Location.Request)
}

protocol AboutUsDataStore {}

class AboutUsInteractor {

    public var presenter: AboutUsPresentationLogic?
    private var worker = AboutUsWorker()
}

// MARK: - About Us Business Logic
extension AboutUsInteractor: AboutUsBusinessLogic {
    
    func setupExampleInfo(request: AboutUs.SetupInfo.Request) {
        
        worker.getValue(mode: .aboutUs, responseSuccess: { [weak self] value in
            
            let exampleInfo = AboutUs.SetupInfo.Response.ExampleInfo(phoneNumber: ExampleInfo.phoneNumber, git: ExampleInfo.git, email: ExampleInfo.email, location: ExampleInfo.address, value: value)
            
            let response = AboutUs.SetupInfo.Response.init(exampleInfo: exampleInfo, error: nil)
            self?.presenter?.presentExampleInfo(response: response)
        }, responseError: { [weak self] error in
            
            let exampleInfo = AboutUs.SetupInfo.Response.ExampleInfo(phoneNumber: ExampleInfo.phoneNumber, git: ExampleInfo.git, email: ExampleInfo.email, location: ExampleInfo.address, value: nil)
            
            let response = AboutUs.SetupInfo.Response.init(exampleInfo: exampleInfo, error: error)
            self?.presenter?.presentExampleInfo(response: response)
        })
    }
    
    func callPhoneNumber(request: AboutUs.PhoneNumber.Request) {
        
        if let phoneNumber = request.phoneNumber, let url = URL(string: "tel://\(phoneNumber)") {
            
            let response = AboutUs.PhoneNumber.Response(url: url)
            presenter?.presentCallPhoneNumber(response: response)
        }
    }
    
    func composeMail(request: AboutUs.ComposeMail.Request) {
        
        if MFMailComposeViewController.canSendMail() {
        
            let response = AboutUs.ComposeMail.Response(error: nil)
            presenter?.presentComposeMail(response: response)
            
        } else {
            
            let error = ExampleError(kind: .mailNotAvailable)
            let response = AboutUs.ComposeMail.Response.init(error: error)
            presenter?.presentComposeMail(response: response)
        }
    }
    
    func openGit(request: AboutUs.Git.Request) {
        
        if let websiteUrl = request.url, let url = URL(string: "http://\(websiteUrl)") {
            
            let response = AboutUs.Git.Response(url: url)
            presenter?.presentGit(response: response)
        }
    }
    
    func openAddressOnMap(request: AboutUs.Location.Request) {

        if request.address != nil, let url = URL(string: "http://maps.apple.com/?address=Plaza+9+Kd+Tower,+Cotterells,+Hemel+Hempstead,+Herts,+United+Kingdom,+HP1+1F") {
            let response = AboutUs.Location.Response(url: url)
            presenter?.presentAddressOnMap(response: response)
        }
    }
}

// MARK: - About Us Data Store
extension AboutUsInteractor: AboutUsDataStore {}
