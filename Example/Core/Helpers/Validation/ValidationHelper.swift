//
//  ValidationHelper.swift
//  Example
//
//  Created by Data Kondzhariia on 4/11/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

typealias ValidationBlock = (_ isValid: Bool, _ validationMessage: String) -> Void

class ValidationHelper {
    
    static let shared = ValidationHelper()
    
    private init() {}
    
    // Email
    private func isVaidEmailForRegex(email: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let regex = try! NSRegularExpression(pattern: emailRegEx, options: .caseInsensitive)
        return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
    }

    func isValidFirstName(firstName: String?) -> Bool {
        
        guard let firstName = firstName, firstName.isEmpty == false else {
            return false
        }
        return true
    }
    
    func isValidLastName(lastName: String?) -> Bool {
        
        guard let lastName = lastName, lastName.isEmpty == false else {
            return false
        }
        return true
    }

    func isValidEmail(email: String?) -> Bool {
        
        guard let email = email, email.isEmpty == false else {
            return false
        }
        
        guard isVaidEmailForRegex(email: email) else {
            return false
        }
        return true
    }
    
    func isValidPassword(password: String?) -> Bool {
        
        guard let password = password, password.isEmpty == false else {
            return false
        }
        
        guard password.count >= 8 else {
            return false
        }
        return true
    }
    
    // MARK: - Validation with message
    func isValidFirstName(firstName: String?, validationBlock: ValidationBlock) {
        
        guard let firstName = firstName, firstName.isEmpty == false else {
            
            validationBlock(false, R.string.localizable.emptyFirstNameField())
            return
        }
        
        if firstName.count > 30 {
            
            validationBlock(false, R.string.localizable.countCharactersFirstNameField())
            return
        }
        validationBlock(true, "")
    }
    
    func isValidLastName(lastName: String?, validationBlock: ValidationBlock) {
        
        guard let lastName = lastName, lastName.isEmpty == false else {
            
            validationBlock(false, R.string.localizable.emptyLastNameField())
            return
        }
                
        if lastName.count > 30 {
            
            validationBlock(false, R.string.localizable.countCharactersLastNameField())
            return
        }
        validationBlock(true, "")
    }
    
    func isValidEmail(email: String?, validationBlock: ValidationBlock) {
        
        guard let email = email, email.isEmpty == false else {
            
            validationBlock(false, R.string.localizable.emptyEmailField())
            return
        }
        
        guard isVaidEmailForRegex(email: email) else {
            
            validationBlock(false, R.string.localizable.regexEmail())
            return
        }
        validationBlock(true, "")
    }
        
    func isValidPassword(password: String?, validationBlock: ValidationBlock) {
        
        guard let password = password, password.isEmpty == false else {
            
            validationBlock(false, R.string.localizable.emptyPasswordField())
            return
        }
        
        guard password.count >= 6 else {
            
            validationBlock(false, R.string.localizable.regexPassword())
            return
        }
        
        validationBlock(true, "")
    }
}
