//
//  PasswordField.swift
//  Example
//
//  Created by Data Kondzhariia on 4/16/19.
//  Copyright © 2019 Example. All rights reserved.
//

import TweeTextField

extension TweeAttributedTextField {
    
    public func setSecureButton() {
        
        rightViewMode = .always
        let secureButton = UIButton()
        secureButton.setImage(R.image.showPasswordIcon(), for: .normal)
        secureButton.sizeToFit()
        rightView = secureButton

        secureButton.addTarget(self, action: #selector(didTapSecureButton(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapSecureButton(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            
            sender.setImage(R.image.hidePasswordIcon(), for: .normal)
            isSecureTextEntry = false
            sender.tag = 1
        case 1:
            
            sender.setImage(R.image.showPasswordIcon(), for: .normal)
            isSecureTextEntry = true
            sender.tag = 0
        default:
            break
        }
    }
}

