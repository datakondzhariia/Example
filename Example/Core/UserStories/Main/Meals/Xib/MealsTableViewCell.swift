//
//  MealsTableViewCell.swift
//  Example
//
//  Created by Data Kondzhariia on 24.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit

class MealsTableViewCell: UITableViewCell {

    @IBOutlet private weak var mealImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        mealImageView.setRounded()
        mainView.addShadow(location: .bottom)
    }
}

// MARK: - Public Method
extension MealsTableViewCell {
    
    public func configure(_ meal: Meals.FetchMeals.ViewModel.DisplayedMeal) {
        
        if let image = meal.imageUrl, let url = URL(string: image) {
            
            mealImageView.loadImage(for: url)
        } else {
            
            
        }
        
        nameLabel.text = meal.name
        descriptionLabel.text = meal.description
    }
}
