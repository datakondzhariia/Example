//
//  SignUpViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import TweeTextField
import FacebookLogin
import SVProgressHUD
import Nantes
import FBSDKLoginKit

protocol SignUpDisplayLogic: class {
    
    func displayFieldError(viewModel: SignUp.ValidationForm.ViewModel)
    func displayFieldSuccess(viewModel: SignUp.ValidationForm.ViewModel)
    func displayFormSuccess(viewModel: SignUp.ValidationForm.ViewModel)

    func displayRegistrationError(viewModel: SignUp.Register.ViewModel)
    func displayRegistrationSuccess(viewModel: SignUp.Register.ViewModel)
    
    func displayCreateUserError(viewModel: SignUp.CreateUser.ViewModel)
    func displayCreateUserSuccess(viewModel: SignUp.CreateUser.ViewModel)

    func displayFacebookError(viewModel: SignUp.Facebook.ViewModel)
    func displayFacebookSuccess(viewModel: SignUp.Facebook.ViewModel)

    func displayCreateFacebookUserError(viewModel: SignUp.CreateFacebookUser.ViewModel)
    func displayCreateFacebookUserSuccess(viewModel: SignUp.CreateFacebookUser.ViewModel)

    func displayFetchUserError(viewModel: SignUp.FetchUser.ViewModel)
    func displayFetchUserSuccess(viewModel: SignUp.FetchUser.ViewModel)

    func displayCleanForm(viewModel: SignUp.FormCleanUp.ViewModel)
}

class SignUpViewController: UIViewController {
    
    @IBOutlet private weak var firstNameTextField: TweeAttributedTextField!
    @IBOutlet private weak var lastNameTextField: TweeAttributedTextField!
    @IBOutlet private weak var emailTextField: TweeAttributedTextField!
    @IBOutlet private weak var passwordTextField: TweeAttributedTextField!
    @IBOutlet private weak var signUpButton: ExampleButton!
    @IBOutlet private weak var signUpFacebookButton: ExampleButton!
    @IBOutlet private weak var signInNantesLabel: NantesLabel!
    @IBOutlet private weak var fieldsStackView: UIStackView!
    
    public var interactor: SignUpBusinessLogic?
    public var router: (NSObjectProtocol & SignUpRoutingLogic & SignUpDataPassing)?
    
    private var facebookButton: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SignUpConfigurator.shared.configure(self)
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cleanUpFieldStyle(textFields: [passwordTextField])
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Setup UI
extension SignUpViewController {
    
    private func setupUI() {
        
        setupFacebokoButtonStyle()
        setupSignInNantesLabelType()
        passwordTextField.setSecureButton()
    }
    
    private func setupFacebokoButtonStyle() {
        
        facebookButton = FBLoginButton(permissions: [ .publicProfile, .email])
        signUpFacebookButton.setFacebookStyle()
    }
    
    private func setupSignInNantesLabelType() {
        
        signInNantesLabel.delegate = self
        signInNantesLabel.linkAttributes = [NSAttributedString.Key.font: R.font.nunitoBold(size: 18)!]
        signInNantesLabel.addLink(to: URL(string: R.string.localizable.signIn())!, withRange: ((signInNantesLabel.text ?? "") as NSString).range(of: "Sign in"))
    }
                
    // MARK: - Fields Style
    private func setupErrorStyle(textField: TweeAttributedTextField) {
        
        textField.infoLabel.adjustsFontSizeToFitWidth = true
        textField.lineColor = R.color.cardinal()!
        textField.infoTextColor = R.color.cardinal()!
    }
    
    private func setupSuccessStyle(textField: TweeAttributedTextField) {
        
        textField.lineColor = R.color.regalBlue()!
        textField.hideInfo()
    }
    
    private func cleanUpFieldStyle(textFields: [TweeAttributedTextField]) {
        
        for textField in textFields {
            
            textField.text = nil
            textField.placeholderColor = R.color.regalBlueWithOpacity()
            textField.lineColor = R.color.regalBlueWithOpacity()!
            textField.hideInfo()
        }
    }
}

// MARK: - Public Method
extension SignUpViewController {
    
    public func formCleanUp() {
        
        let request = SignUp.FormCleanUp.Request()
        interactor?.formCleanUp(request: request)
    }
}

// MARK: - Actions
extension SignUpViewController {

    @IBAction func didTapSignUpButton(_ sender: ExampleButton) {
        
        view.endEditing(true)
        
        let request = SignUp.ValidationForm.Request(firstName: firstNameTextField.text, lastName: lastNameTextField.text, email: emailTextField.text, password: passwordTextField.text)
        interactor?.validationFileds(request: request)
    }
    
    @IBAction func didTapSignUpWithFacebookButton(_ sender: ExampleButton) {
        
        view.endEditing(true)

        let request = SignUp.Facebook.Request()
        interactor?.signUpFacebook(request: request)
    }
}

// MARK: - Text Field Delegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            return false
        }
        
        switch textField {
        case passwordTextField, emailTextField:
            return string.rangeOfCharacter(from: .whitespaces) == nil
        default:
            return text.isEmpty == false || string.rangeOfCharacter(from: .whitespaces) == nil
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Nantes Label Delegate
extension SignUpViewController: NantesLabelDelegate {
    
    func attributedLabel(_ label: NantesLabel, didSelectLink link: URL) {

        view.endEditing(true)

        router?.navigateToSignIn()
    }
}

// MARK: - Sign Up Display Logic
extension SignUpViewController: SignUpDisplayLogic {
        
    func displayFieldSuccess(viewModel: SignUp.ValidationForm.ViewModel) {
        
        for validationSuccess in viewModel.validationStatuses {
            
            switch validationSuccess.validationType {
            case .firstName:
                setupSuccessStyle(textField: firstNameTextField)
            case .lastName:
                setupSuccessStyle(textField: lastNameTextField)
            case .email:
                setupSuccessStyle(textField: emailTextField)
            case .password:
                setupSuccessStyle(textField: passwordTextField)
            }
        }
    }
    
    func displayFieldError(viewModel: SignUp.ValidationForm.ViewModel) {
     
        for validationError in viewModel.validationStatuses {
            
            switch validationError.validationType {
            case .firstName:
                setupErrorStyle(textField: firstNameTextField)
                firstNameTextField.showInfo(validationError.errorMessage ?? "")
            case .lastName:
                setupErrorStyle(textField: lastNameTextField)
                lastNameTextField.showInfo(validationError.errorMessage ?? "")
            case .email:
                setupErrorStyle(textField: emailTextField)
                emailTextField.showInfo(validationError.errorMessage ?? "")
            case .password:
                setupErrorStyle(textField: passwordTextField)
                passwordTextField.showInfo(validationError.errorMessage ?? "")
            }
        }
    }
    
    func displayFormSuccess(viewModel: SignUp.ValidationForm.ViewModel) {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)
        
        let request = SignUp.Register.Request(firstName: firstNameTextField.text, lastName: lastNameTextField.text, email: emailTextField.text, password: passwordTextField.text)
        interactor?.signUp(request: request)
    }
    
    func displayRegistrationSuccess(viewModel: SignUp.Register.ViewModel) {
        
        let request = SignUp.CreateUser.Request(firstName: firstNameTextField.text, lastName: lastNameTextField.text, email: emailTextField.text)
        interactor?.createUser(request: request)
    }
    
    func displayRegistrationError(viewModel: SignUp.Register.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayCreateUserError(viewModel: SignUp.CreateUser.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayCreateUserSuccess(viewModel: SignUp.CreateUser.ViewModel) {
        
        let request = SignUp.FetchUser.Request()
        interactor?.fetchUser(request: request)
    }

    func displayFacebookError(viewModel: SignUp.Facebook.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayFacebookSuccess(viewModel: SignUp.Facebook.ViewModel) {
        
        let request = SignUp.CreateFacebookUser.Request()
        interactor?.createFacebookUser(request: request)
    }
    
    func displayCreateFacebookUserError(viewModel: SignUp.CreateFacebookUser.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayCreateFacebookUserSuccess(viewModel: SignUp.CreateFacebookUser.ViewModel) {

        let request = SignUp.FetchUser.Request()
        interactor?.fetchUser(request: request)
    }

    func displayFetchUserError(viewModel: SignUp.FetchUser.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayFetchUserSuccess(viewModel: SignUp.FetchUser.ViewModel) {
        
        SVProgressHUD.dismiss()
        router?.navigateToMain()
    }

    func displayCleanForm(viewModel: SignUp.FormCleanUp.ViewModel) {
        
        let textFields = [firstNameTextField, lastNameTextField, emailTextField] as! [TweeAttributedTextField]
        cleanUpFieldStyle(textFields: textFields)
    }
}

// MARK: - Registration State Data Source
extension SignUpViewController: RegistrationStateDataSource {
    
    func currentRegistrationScreen() -> RegisterScreen {
        return .manualSignUp
    }
}
