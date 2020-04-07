//
//  ExampleButton.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ExampleButton: UIButton {
    
    @IBInspectable var increasingArea: CGFloat = 0 {
        
        didSet {
            
            margin = increasingArea
        }
    }

    private var margin: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setRounded()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

        let newArea = bounds.insetBy(dx: -margin, dy: -margin)
        return newArea.contains(point)
    }
}

// MARK: - Facebook Style
extension ExampleButton {
    
    public func setFacebookStyle() {
        
        if let imageView = imageView, let titleLabel = titleLabel {
            
            let padding: CGFloat = 15
            imageEdgeInsets = UIEdgeInsets(top: 5, left: padding, bottom: 5, right: titleLabel.frame.size.width)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: imageView.frame.width, bottom: 0, right: imageView.frame.width)
        }
    }
}
