//
//  UIImageView+Additionals.swift
//  Example
//
//  Created by Data Kondzhariia on 5/17/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(for url: URL) {
        
        DispatchQueue.global().async {
         
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            
            guard let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                
                self?.image = image
            }
        }
    }
    
    public func changeColor(color: UIColor) {
        
        image = image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
}
