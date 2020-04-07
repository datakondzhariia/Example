//
//  UIViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 5/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import CDAlertView

extension UIViewController {

    // Shadow
    public func setNavigationShadow() {
        
        navigationController?.navigationBar.addShadow(location: .bottom, color: .lightGray, opacity: 0.3, radius: 3.0)
    }
    
    @IBAction func backButtonItem(_ sender: UIBarButtonItem? = nil) {
        
        navigationController?.popViewController(animated: true)
    }
}

extension UIViewController {
    
    public func showErrorAlert(title: String = "Error", message: String?) {
        
        let alert = CDAlertView(title: title, message: message, type: .error)
        alert.show()
    }
    
    public func showSuccessAlert(title: String = "Success", message: String?, autoHideTime: Double? = nil) {
        
        let alert = CDAlertView(title: title, message: message, type: .success)
        
        if let autoHideTime = autoHideTime {
            
            alert.autoHideTime = TimeInterval(autoHideTime)
        }
        
        alert.show()
    }
    
    public func showWarningAlert(title: String = "Warning", message: String?) {
        
        let alert = CDAlertView(title: title, message: message, type: .warning)
        alert.show()
    }
}

extension UIViewController {
    
    public func prepareRoute(for segue: UIStoryboardSegue, router: NSObjectProtocol?) {
        
        guard let identifier = segue.identifier else {
            return
        }
        
        let selector = NSSelectorFromString("routeTo\(identifier)WithSegue:")
        
        guard let router = router, router.responds(to: selector) else {
            return
        }
        
        router.perform(selector, with: segue)
    }
}
