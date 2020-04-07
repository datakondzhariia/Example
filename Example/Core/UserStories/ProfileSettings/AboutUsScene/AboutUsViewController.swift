//
//  AboutUsViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 5/2/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import WebKit
import MessageUI
import SVProgressHUD

private enum CellRowType: Int {
    case phoneNumber = 1, website = 2, email = 3, location = 4, aboutUs = 6
}

protocol AboutUsDisplayLogic: class {
    
    func displayExampleInfoSuccess(viewModel: AboutUs.SetupInfo.ViewModel)
    func displayExampleInfoError(viewModel: AboutUs.SetupInfo.ViewModel)
    
    func displayCallPhoneNumber(viewModel: AboutUs.PhoneNumber.ViewModel)
    
    func displayComposeMailSuccess(viewModel: AboutUs.ComposeMail.ViewModel)
    func displayComposeMailError(viewModel: AboutUs.ComposeMail.ViewModel)
    
    func displayGit(viewModel: AboutUs.Git.ViewModel)
    
    func displayAddressOnMap(viewModel: AboutUs.Location.ViewModel)
}

class AboutUsViewController: UITableViewController {
    
    @IBOutlet private weak var exampleHeaderView: ExampleHeaderView!
    @IBOutlet private weak var exampleWebView: ExampleWebView!
    @IBOutlet private weak var exampleLogoImageView: UIImageView!
    
    public var interactor: AboutUsBusinessLogic?
    public var router: (NSObjectProtocol & AboutUsRoutingLogic & AboutUsDataPassing)?

    private var displayedInfo: AboutUs.SetupInfo.ViewModel.DisplayedInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AboutUsConfigurator.shared.configure(self)
        
        setupUI()
        setupExampleInfo()
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == CellRowType.aboutUs.rawValue {
            return exampleWebView.contentHeight
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case CellRowType.phoneNumber.rawValue:
            callPhoneNumber()
        case CellRowType.website.rawValue:
            openWebsite()
        case CellRowType.email.rawValue:
            composeMessage()
        case CellRowType.location.rawValue:
            openAddressOnMap()
        default:
            break
        }
    }
}

// MARK: - Private Methods
extension AboutUsViewController {

    private func setupUI() {
        
        exampleWebView.delegate = self
        exampleHeaderView.bringSubviewToFront(exampleLogoImageView)
    }

    // MARK: - Setup Info
    private func setupExampleInfo() {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)

        let request = AboutUs.SetupInfo.Request()
        interactor?.setupExampleInfo(request: request)
    }
    
    private func callPhoneNumber() {
        
        let request = AboutUs.PhoneNumber.Request(phoneNumber: ExampleInfo.phoneNumber)
        interactor?.callPhoneNumber(request: request)
    }
    
    private func composeMessage() {
        
        let request = AboutUs.ComposeMail.Request()
        interactor?.composeMail(request: request)
    }
    
    private func openWebsite() {
        
        let request = AboutUs.Git.Request(url: ExampleInfo.git)
        interactor?.openGit(request: request)
    }
    
    private func openAddressOnMap() {
        
        let request = AboutUs.Location.Request(address: ExampleInfo.address)
        interactor?.openAddressOnMap(request: request)
    }
}

// MARK: - About Us Display Logic
extension AboutUsViewController: AboutUsDisplayLogic {
    
    func displayExampleInfoSuccess(viewModel: AboutUs.SetupInfo.ViewModel) {

        SVProgressHUD.dismiss()

        displayedInfo = viewModel.displayedInfo
        exampleWebView.loadHTMLContent(displayedInfo.value ?? "")
    }
    
    func displayExampleInfoError(viewModel: AboutUs.SetupInfo.ViewModel) {
        
        SVProgressHUD.dismiss()
        
        displayedInfo = viewModel.displayedInfo

        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayCallPhoneNumber(viewModel: AboutUs.PhoneNumber.ViewModel) {
        
        UIApplication.shared.open(viewModel.url, options: [:])
    }
    
    func displayComposeMailSuccess(viewModel: AboutUs.ComposeMail.ViewModel) {
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients([ExampleInfo.email])
        present(mail, animated: true)
    }
    
    func displayComposeMailError(viewModel: AboutUs.ComposeMail.ViewModel) {
        
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayGit(viewModel: AboutUs.Git.ViewModel) {
        
        UIApplication.shared.open(viewModel.url)
    }
    
    func displayAddressOnMap(viewModel: AboutUs.Location.ViewModel) {
        
        UIApplication.shared.open(viewModel.url)
    }
}

// MARK: - About Us Display Logic
extension AboutUsViewController: ExampleWebViewDelegate {
    
    func exampleWebViewDidReloadAfterCalculationOfHeight(_ exampleWebView: ExampleWebView) {
        
        tableView.reloadData()
    }
}

// MARK: - MFMessage Compose View Controller Delegate
extension AboutUsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true)
    }
}
