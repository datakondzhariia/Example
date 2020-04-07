//
//  ProfileSettingsViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit
import SVProgressHUD

enum SettingsCellRowType {
    
    enum Profile: Int {
        case name = 1
    }
    
    enum Information: Int {
        case aboutUs = 4, terms, privacyPolicy, logOut
    }
}

protocol ProfileSettingsDisplayLogic: class {
    
    func displayProfileInfo(viewModel: ProfileSettings.SetupInfo.ViewModel)
    
    func displayAppVersion(viewModel: ProfileSettings.Version.ViewModel)
    
    func displayUpdateUserInfoSuccess(viewModel: ProfileSettings.UpdateUserInfo.ViewModel)
    func displayUpdateUserInfoError(viewModel: ProfileSettings.UpdateUserInfo.ViewModel)
        
    func displayLogOutSuccess(viewModel: ProfileSettings.LogOut.ViewModel)
    func displayLogOutError(viewModel: ProfileSettings.LogOut.ViewModel)
}

class ProfileSettingsViewController: UITableViewController {
    
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var versionLabel: UILabel!
    
    public var interactor: ProfileSettingsBusinessLogic?
    public var router: (NSObjectProtocol & ProfileSettingsRoutingLogic & ProfileSettingsDataPassing)?
    
    private var displyedUser: ProfileSettings.DisplayedUser!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ProfileSettingsConfigurator.shared.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
        setupAppVersion()
        setupUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        prepareRoute(for: segue, router: router)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case SettingsCellRowType.Information.terms.rawValue:
            router?.navigateToTermsAndConditions()
        case SettingsCellRowType.Information.privacyPolicy.rawValue:
            router?.navigateToPrivacyPolicy()
        case SettingsCellRowType.Information.logOut.rawValue:
            showlogOutAlertController()
        default:
            break
        }
    }
}

// MARK: - Private Methods
extension ProfileSettingsViewController {
    
    private func setupUI() {
        
        setNavigationShadow()
    }
    
    // MARK: - Setup Info
    private func setupUserInfo() {
        
        let request = ProfileSettings.SetupInfo.Request()
        interactor?.setupProfileInfo(request: request)
    }
    
    private func setupAppVersion() {
        
        let request = ProfileSettings.Version.Request()
        interactor?.setupAppVersion(request: request)
    }
    
    private func updateUserInfo() {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)

        let request = ProfileSettings.UpdateUserInfo.Request()
        interactor?.updateUserInfo(request: request)
    }
    
    private func fetchUserInfo() {
        
        fullNameLabel.text = displyedUser.fullName
        emailLabel.text = displyedUser.email
    }

    // MARK: - Log Out
    private func showlogOutAlertController() {
        
        let alert = ExampleAlertController(title: R.string.localizable.alertTitleLogOut(), message: R.string.localizable.alertMessageLogOut(), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { [weak self] action in
            
            self?.logOut()
        }
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        alert.preferredAction = yesAction
        present(alert, animated: true)
    }
    
    private func logOut() {
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)

        let request = ProfileSettings.LogOut.Request()
        interactor?.logOut(request: request)
    }
}

// MARK: - Profile Settings Display Logic
extension ProfileSettingsViewController: ProfileSettingsDisplayLogic {

    func displayProfileInfo(viewModel: ProfileSettings.SetupInfo.ViewModel) {
        
        displyedUser = viewModel.displayedUser
        
        fetchUserInfo()
        updateUserInfo()
    }
    
    func displayAppVersion(viewModel: ProfileSettings.Version.ViewModel) {
     
        versionLabel.text = viewModel.appVersion
    }
    
    func displayUpdateUserInfoSuccess(viewModel: ProfileSettings.UpdateUserInfo.ViewModel) {
        
        displyedUser = viewModel.displayedUser

        SVProgressHUD.dismiss()
        fetchUserInfo()
    }
    
    func displayUpdateUserInfoError(viewModel: ProfileSettings.UpdateUserInfo.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
    
    func displayLogOutSuccess(viewModel: ProfileSettings.LogOut.ViewModel) {
        
        SVProgressHUD.dismiss()
        router?.navigateToSignIn()
    }
    
    func displayLogOutError(viewModel: ProfileSettings.LogOut.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
        
        router?.navigateToSignIn()
    }
}
