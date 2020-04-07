//
//  ExampleHeaderView.swift
//  Example
//
//  Created by Data Kondzhariia on 4/10/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ExampleHeaderView: UIView {
    
    @IBOutlet private weak var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addBottomRoundedEdge(desiredCurve: 1)
    }
}

// MARK: - Private Method
extension ExampleHeaderView {
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed(R.nib.exampleHeaderView.name, owner: self, options: .none)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
