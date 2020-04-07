//
//  TermsFeedViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 4/18/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

protocol TermsFeedDisplayLogic: class {
    
    func displayTermsFeedInfoSuccess(viewModel: TermsFeedInfo.SetupInfo.ViewModel)
    func displayTermsFeedInfoError(viewModel: TermsFeedInfo.SetupInfo.ViewModel)
}

class TermsFeedViewController: UIViewController {
    
    @IBOutlet private weak var exampleWebView: ExampleWebView!
    @IBOutlet private weak var loaderView: UIView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    public var interactor: TermsFeedBusinessLogic?
    public var router: (NSObjectProtocol & TermsFeedRoutingLogic & TermsFeedDataPassing)?
    public var dataStore: TermsFeedDataStore?

    private var displayedTermsFeedInfo: TermsFeedInfo.SetupInfo.ViewModel.DisplayedTermsFeedInfo!

    override func awakeFromNib() {
        super.viewDidLoad()
        
        TermsFeedConfigurator.shared.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
        setupTermsFeedInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Private Methods
extension TermsFeedViewController {
    
    private func setupUI() {
        
        showLoader()
        exampleWebView.delegate = self
    }
    
    private func showLoader() {
        
        activityIndicatorView.startAnimating()
        loaderView.isHidden = false
    }
    
    private func hideLoader() {
        
        activityIndicatorView.stopAnimating()
        loaderView.isHidden = true
    }
    
    // MARK: - Setup Info
    private func setupTermsFeedInfo() {
        
        let request = TermsFeedInfo.SetupInfo.Request()
        interactor?.setupCurrentTermsFeedInfo(request: request)
    }
}

// MARK: - Example Web View Delegate
extension TermsFeedViewController: ExampleWebViewDelegate {
    
    func exampleWebViewDidFinish(_ exampleWebView: ExampleWebView) {
        
        hideLoader()
    }
}

// MARK: - Terms Feed Display Logic
extension TermsFeedViewController: TermsFeedDisplayLogic {
    
    func displayTermsFeedInfoSuccess(viewModel: TermsFeedInfo.SetupInfo.ViewModel) {
    
        displayedTermsFeedInfo = viewModel.displayedTermsFeedInfo
        title = displayedTermsFeedInfo.title
        exampleWebView.loadHTMLContent(displayedTermsFeedInfo?.infoMessage ?? "")
    }
    
    func displayTermsFeedInfoError(viewModel: TermsFeedInfo.SetupInfo.ViewModel) {
        
        hideLoader()
        displayedTermsFeedInfo = viewModel.displayedTermsFeedInfo
        title = displayedTermsFeedInfo.title
            
        showErrorAlert(message: viewModel.error?.message)
    }
}
