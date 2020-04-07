//
//  WelcomeViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 4/10/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import Nantes
import FBSDKLoginKit
import SVProgressHUD

protocol WelcomeDisplayLogic: class {

    func displayFacebookError(viewModel: Welcome.Facebook.ViewModel)
    func displayFacebookSuccess(viewModel: Welcome.Facebook.ViewModel)
    
    func displayCreateFacebookUserError(viewModel: Welcome.CreateFacebookUser.ViewModel)
    func displayCreateFacebookUserSuccess(viewModel: Welcome.CreateFacebookUser.ViewModel)
    
    func displayFetchUserError(viewModel: Welcome.FetchUser.ViewModel)
    func displayFetchUserSuccess(viewModel: Welcome.FetchUser.ViewModel)
}

class WelcomeViewController: UIViewController {
    
    @IBOutlet private weak var signUpWithPhoneNumerButton: ExampleButton!
    @IBOutlet private weak var signUpWithFacebookButton: ExampleButton!
    @IBOutlet private weak var signInNantesLabel: NantesLabel!
    
    private var facebookButton: FBLoginButton!
    
    public var interactor: WelcomeBusinessLogic?
    public var router: (NSObjectProtocol & WelcomeRoutingLogic & WelcomeDataPassing)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WelcomeConfigurator.shared.configure(self)
        
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Setup UI
extension WelcomeViewController {
    
    private func setupUI() {
        
        setupFacebookButtonStyle()
        setupSignInNantesLabelType()
    }

    private func setupSignInNantesLabelType() {
                
        signInNantesLabel.delegate = self
        signInNantesLabel.linkAttributes = [NSAttributedString.Key.font: R.font.nunitoBold(size: 18)!]
        signInNantesLabel.addLink(to: URL(string: "Signin")!, withRange: ((signInNantesLabel.text ?? "") as NSString).range(of: "Sign in"))
    }
    
    private func setupFacebookButtonStyle() {
        
        facebookButton = FBLoginButton(permissions: [.publicProfile, .email])
        signUpWithFacebookButton.setFacebookStyle()
    }
}

// MARK: - Actions
extension WelcomeViewController {
    
    @IBAction func didTapFacebookButton(_ sender: ExampleButton) {
        
        let request = Welcome.Facebook.Request()
        interactor?.signUpFacebook(request: request)
    }
}

// MARK: - Nantes Label Delegate
extension WelcomeViewController: NantesLabelDelegate {
    
    func attributedLabel(_ label: NantesLabel, didSelectLink link: URL) {
        
        router?.navigateToSignIn()
    }
}

// MARK: - Welcome Display Logic
extension WelcomeViewController: WelcomeDisplayLogic {

    func displayFacebookError(viewModel: Welcome.Facebook.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayFacebookSuccess(viewModel: Welcome.Facebook.ViewModel) {

        let request = Welcome.CreateFacebookUser.Request()
        interactor?.createFacebookUser(request: request)
    }
    
    func displayCreateFacebookUserError(viewModel: Welcome.CreateFacebookUser.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayCreateFacebookUserSuccess(viewModel: Welcome.CreateFacebookUser.ViewModel) {
        
        let request = Welcome.FetchUser.Request()
        interactor?.fetchUser(request: request)
    }
    
    func displayFetchUserError(viewModel: Welcome.FetchUser.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayFetchUserSuccess(viewModel: Welcome.FetchUser.ViewModel) {
        
        router?.navigateToMain()
    }
}

// MARK: - Registration State Data Source
extension WelcomeViewController: RegistrationStateDataSource {
    
    func currentRegistrationScreen() -> RegisterScreen {
        return .welcome
    }
}
