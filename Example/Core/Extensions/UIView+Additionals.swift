//
//  UIView+Additionals.swift
//  Example
//
//  Created by Data Kondzhariia on 4/18/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

//MARK: - Shadow
enum VerticalLocation: String {
    
    case bottom
    case top
}

extension UIView {
    
    func addShadow(location: VerticalLocation, color: UIColor = .lightGray, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 3), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -3), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
}

// Extension for HeaderView (mask)
extension UIView {
    
  func addBottomRoundedEdge(desiredCurve: CGFloat?) {
    
        let offset: CGFloat = self.frame.width / desiredCurve!
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        self.layer.mask = maskLayer
    }
}

// Extension for UIView Constraints
extension UIView {
    
    /**
     Adds specified view as subview of current view. Setup constraints of subview to make alignment all edges to be the same as of current view
     - Parameters:
     - view: view to add
     */
    func addFullsizeSubview(_ view: UIView) {
        let container = self
        container.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:[], metrics:nil, views: bindings))
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:[], metrics:nil, views: bindings))
    }
    
    /**
     Removes specified view as subview of current view.
     - Parameters:
     - view: view to remove
     */
    func removeFullsizeSubview(_ view: UIView) {
        view.removeFromSuperview()
    }
}

extension UIView {
    
    public func setRounded() {
        
        layer.cornerRadius = frame.size.height / 2
        clipsToBounds = true
    }
}
