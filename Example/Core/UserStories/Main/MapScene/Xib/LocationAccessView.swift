//
//  LocationAccessView.swift
//  Example
//
//  Created by Data Kondzhariia on 5/23/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class LocationAccessView: UIView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var locationImageView: UIImageView!
    @IBOutlet private weak var detailsArrowImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUIElements()
    }
}

// MARK: - Private Method
extension LocationAccessView {
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed(R.nib.locationAccessView.name, owner: self, options: .none)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

// MARK: - Public Method
extension LocationAccessView {

    @IBAction func didTapLocationServicesButton(_ sender: UIButton) {
        
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            
            UIApplication.shared.open(settingsUrl)
        }
    }
}

// MARK: - Private Methods
extension LocationAccessView {
    
    // MARK: - Setup UI
    private func setupUIElements() {
        
        changeTintColorForImageViews()
        setBottomShadow()
    }
    
    private func changeTintColorForImageViews() {
        
        locationImageView.image = locationImageView.image?.withRenderingMode(.alwaysTemplate)
        locationImageView.tintColor = R.color.sunflower()
        
        detailsArrowImageView.image = detailsArrowImageView.image?.withRenderingMode(.alwaysTemplate)
        detailsArrowImageView.tintColor = R.color.sunflower()
    }
    
    private func setBottomShadow() {
        
        addShadow(location: .bottom)
    }
}
