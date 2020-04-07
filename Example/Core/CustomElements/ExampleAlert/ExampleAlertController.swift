//
//  ExampleAlertController.swift
//  Example
//
//  Created by Data Kondzhariia on 4/10/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ExampleAlertController: UIAlertController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIElements()
    }
}

// MARK: - Setup UI
extension ExampleAlertController {

    private func setupUIElements() {
        
        setupFontForTitle()
        setupFontForMessage()
        setupTintColor()
    }
    
    private func setupFontForTitle() {
        
        let attributedTitle = NSMutableAttributedString(string: title ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: R.font.nunitoBold(size: 18)!])
        setValue(attributedTitle, forKey: "attributedTitle")
    }

    private func setupFontForMessage() {
        
        let attributedMessage = NSMutableAttributedString(string: "\n\(message ?? "")", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: R.font.nunitoRegular(size: 14)!])
        setValue(attributedMessage, forKey: "attributedMessage")
    }
    
    private func setupTintColor() {
        
        view.tintColor = R.color.regalBlue()
    }
}
