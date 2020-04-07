//
//  MealsPresenter.swift
//  Example
//
//  Created by Data Kondzhariia on 24.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol MealsPresentationLogic {
    
    func presentFetchMeals(response: Meals.FetchMeals.Response)
}

class MealsPresenter {
    
    weak var viewController: MealsDisplayLogic?
}

// MARK: - Private Method
extension MealsPresenter {
    
    private func setupDisplayedMeals(response: Meals.FetchMeals.Response) -> [Meals.FetchMeals.ViewModel.DisplayedMeal] {
        
        var meals = [Meals.FetchMeals.ViewModel.DisplayedMeal]()
        
        response.meals.forEach { meal in
            
            let displayedMeal = Meals.FetchMeals.ViewModel.DisplayedMeal(name: meal.title, description: meal.fullDescription, imageUrl: meal.imageUrl)
            meals.append(displayedMeal)
        }
        
        return meals
    }
}

// MARK: - Meals Presentation Logic
extension MealsPresenter: MealsPresentationLogic {
    
    func presentFetchMeals(response: Meals.FetchMeals.Response) {
        
        let displayedMeals = setupDisplayedMeals(response: response)
        let viewModel = Meals.FetchMeals.ViewModel(displayedMeals: displayedMeals, error: response.error)
        
        if response.error == nil {
            
            viewController?.displayFetchMealsSuccess(viewModel: viewModel)
        } else {
            
            viewController?.displayFetchMealsError(viewModel: viewModel)
        }
    }
}
