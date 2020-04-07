//
//  SignInViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import TweeTextField
import Nantes
import SVProgressHUD

protocol SignInDisplayLogic: class {
    
    func displayFieldError(viewModel: SignIn.ValidationForm.ViewModel)
    func displayFieldSuccess(viewModel: SignIn.ValidationForm.ViewModel)
    func displayFormSuccess(viewModel: SignIn.ValidationForm.ViewModel)
    
    func displayRegistrationError(viewModel: SignIn.Register.ViewModel)
    func displayRegistrationSuccess(viewModel: SignIn.Register.ViewModel)
    
    func displayFetchUserError(viewModel: SignIn.FetchUser.ViewModel)
    func displayFetchUserSuccess(viewModel: SignIn.FetchUser.ViewModel)
    
    func displayCleanForm(viewModel: SignIn.FormCleanUp.ViewModel)
}

class SignInViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: TweeAttributedTextField!
    @IBOutlet private weak var passwordTextField: TweeAttributedTextField!
    @IBOutlet private weak var signUpNantesLabel: NantesLabel!
    
    public var interactor: SignInBusinessLogic?
    public var router: (NSObjectProtocol & SignInRoutingLogic & SignInDataPassing)?
      
    override func awakeFromNib() {
        super.awakeFromNib()
        
        SignInConfigurator.shared.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cleanUpFieldStyle(textField: passwordTextField)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Private Methods
extension SignInViewController {

    private func setupUI() {
        
        setupSignUpNantesLabelType()
        passwordTextField.setSecureButton()
    }
    
    private func setupSignUpNantesLabelType() {

        signUpNantesLabel.delegate = self
        signUpNantesLabel.linkAttributes = [NSAttributedString.Key.font: R.font.nunitoBold(size: 18)!]
        signUpNantesLabel.addLink(to: URL(string: R.string.localizable.signUp())!, withRange: ((signUpNantesLabel.text ?? "") as NSString).range(of: "Sign up"))
    }
    
    private func setupFieldsFontSize(infoFont: UIFont) {
        
        let textFont = R.font.nunitoRegular(size: 16)

        emailTextField.font = textFont
        passwordTextField.font = textFont
        
        emailTextField.infoLabel.font = infoFont
        passwordTextField.infoLabel.font = infoFont
    }
        
    // MARK: - Fields Style
    private func setErrorStyle(textField: TweeAttributedTextField) {
        
        textField.infoLabel.adjustsFontSizeToFitWidth = true
        textField.lineColor = R.color.cardinal()!
        textField.infoTextColor = R.color.cardinal()!
    }
    
    private func setSuccessStyle(textField: TweeAttributedTextField) {
        
        textField.lineColor = R.color.regalBlue()!
        textField.hideInfo()
    }
    
    private func cleanUpFieldStyle(textField: TweeAttributedTextField) {
        
        textField.text = nil
        textField.placeholderColor = R.color.regalBlueWithOpacity()
        textField.lineColor = R.color.regalBlueWithOpacity()!
        textField.hideInfo()
    }
}

// MARK: - Public Methods
extension SignInViewController {
    
    public func formCleanUp() {
        
        let request = SignIn.FormCleanUp.Request()
        interactor?.formCleanUp(request: request)
    }
}

// MARK: - Text Field Delegate
extension SignInViewController: UITextFieldDelegate {
    
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
extension SignInViewController: NantesLabelDelegate {

    func attributedLabel(_ label: NantesLabel, didSelectLink link: URL) {
        
        view.endEditing(true)

        router?.navigateToSignUp()
    }
}

// MARK: - Actions
extension SignInViewController {
    
    @IBAction func didTapForgotPasswordButton(_ sender: UIButton) {
        
        view.endEditing(true)

        router?.navigateToPasswordReset()
    }
    
    @IBAction func didTapSignInButton(_ sender: ExampleButton) {
        
        view.endEditing(true)
        
        let request = SignIn.ValidationForm.Request(email: emailTextField.text, password: passwordTextField.text)
        interactor?.validationFileds(request: request)
    }
}

// MARK: - Sign In Display Logic
extension SignInViewController: SignInDisplayLogic {
    
    func displayFieldError(viewModel: SignIn.ValidationForm.ViewModel) {

        for validationError in viewModel.validationStatuses {
            
            switch validationError.validationType {
            case .email:
                setErrorStyle(textField: emailTextField)
                emailTextField.showInfo(validationError.errorMessage ?? "")
            case .password:
                setErrorStyle(textField: passwordTextField)
                passwordTextField.showInfo(validationError.errorMessage ?? "")
            default:
                break
            }
        }
    }
    
    func displayFieldSuccess(viewModel: SignIn.ValidationForm.ViewModel) {
        
        for validationSuccess in viewModel.validationStatuses {

            switch validationSuccess.validationType {
            case .email:
                setSuccessStyle(textField: emailTextField)
            case .password:
                setSuccessStyle(textField: passwordTextField)
            default:
                break
            }
        }
    }
    
    func displayFormSuccess(viewModel: SignIn.ValidationForm.ViewModel) {

        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)

        let request = SignIn.Register.Request(email: emailTextField.text, password: passwordTextField.text)
        interactor?.signIn(request: request)
    }
    
    func displayRegistrationError(viewModel: SignIn.Register.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayRegistrationSuccess(viewModel: SignIn.Register.ViewModel) {
        
        let request = SignIn.FetchUser.Request()
        interactor?.fetchUser(request: request)
    }
    
    func displayFetchUserError(viewModel:SignIn.FetchUser.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayFetchUserSuccess(viewModel:SignIn.FetchUser.ViewModel) {
        
        SVProgressHUD.dismiss()
        router?.navigateToMain()
    }
    
    func displayCleanForm(viewModel: SignIn.FormCleanUp.ViewModel) {
     
        cleanUpFieldStyle(textField: emailTextField)
    }
}

// MARK: - Registration State Data Source
extension SignInViewController: RegistrationStateDataSource {
    
    func currentRegistrationScreen() -> RegisterScreen {
        return .signIn
    }
}
