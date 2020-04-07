//
//  PasswordResetViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 4/22/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import TweeTextField
import Nantes
import SVProgressHUD

protocol PasswordResetDisplayLogic: class {
    
    func displayFieldError(viewModel: PasswordReset.ValidationForm.ViewModel)
    func displayFieldSuccess(viewModel: PasswordReset.ValidationForm.ViewModel)
    func displayFormSuccess(viewModel: PasswordReset.ValidationForm.ViewModel)
    
    func displayForgotSuccess(viewModel: PasswordReset.Forgot.ViewModel)
    func displayForgotError(viewModel: PasswordReset.Forgot.ViewModel)
}

class PasswordResetViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: TweeAttributedTextField!
    @IBOutlet private weak var signUpNantesLabel: NantesLabel!

    public var interactor: PasswordResetBusinessLogic?
    public var router: (NSObjectProtocol & PasswordResetRoutingLogic & PasswordResetDataPassing)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PasswordResetConfigurator.shared.configure(self)
        
        setupUI()
    }
}

// MARK: - Setup UI
extension PasswordResetViewController {
    
    private func setupUI() {
        
        setupSignUpNantesLabelType()
    }

    private func setupSignUpNantesLabelType() {
        
        signUpNantesLabel.delegate = self
        signUpNantesLabel.linkAttributes = [NSAttributedString.Key.font: R.font.nunitoBold(size: 18)!]
        signUpNantesLabel.addLink(to: URL(string: R.string.localizable.signUp())!, withRange: ((signUpNantesLabel.text ?? "") as NSString).range(of: "Sign up"))
    }
}

// MARK: - Actions
extension PasswordResetViewController {
    
    @IBAction func didTapSubmitButton(_ sender: ExampleButton) {
        
        view.endEditing(true)
        
        let request = PasswordReset.ValidationForm.Request(email: emailTextField.text)
        interactor?.validationFiled(request: request)
    }
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        
        router?.navigateToSignIn()
    }
}

// MARK: - Text Field Delegate
extension PasswordResetViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                
        return string.rangeOfCharacter(from: .whitespaces) == nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Nantes Label Delegate
extension PasswordResetViewController: NantesLabelDelegate {
    
    func attributedLabel(_ label: NantesLabel, didSelectLink link: URL) {

        view.endEditing(true)

        router?.navigateToSignUp()
    }
}

// MARK: - Password Reset Display Logic
extension PasswordResetViewController: PasswordResetDisplayLogic {
    
    func displayFieldError(viewModel: PasswordReset.ValidationForm.ViewModel) {
                      
        emailTextField.infoLabel.adjustsFontSizeToFitWidth = true
        emailTextField.lineColor = R.color.cardinal()!
        emailTextField.infoTextColor = R.color.cardinal()!
        emailTextField.showInfo(viewModel.validationStatus.errorMessage ?? "")
    }
    
    func displayFieldSuccess(viewModel: PasswordReset.ValidationForm.ViewModel) {
     
        emailTextField.lineColor = R.color.regalBlue()!
        emailTextField.hideInfo()
    }
    
    func displayFormSuccess(viewModel: PasswordReset.ValidationForm.ViewModel) {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)

        let request = PasswordReset.Forgot.Request(email: emailTextField.text)
        interactor?.forgot(request: request)
    }
    
    func displayForgotSuccess(viewModel: PasswordReset.Forgot.ViewModel) {
        
        SVProgressHUD.dismiss()
        showSuccessAlert(message: R.string.localizable.alertMessagePasswordReset())
        router?.navigateToSignIn()
    }
    
    func displayForgotError(viewModel: PasswordReset.Forgot.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
}

// MARK: - Registration State Data Source
extension PasswordResetViewController: RegistrationStateDataSource {
    
    func currentRegistrationScreen() -> RegisterScreen {
        return .passwordReset
    }
}
