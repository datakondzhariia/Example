//
//  MealsInteractor.swift
//  Example
//
//  Created by Data Kondzhariia on 24.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol MealsBusinessLogic {
    
    func fetchMeals(request: Meals.FetchMeals.Request)
}

protocol MealsDataStore {}

class MealsInteractor {
    
    public var presenter: MealsPresentationLogic?
    private var worker = MealsWorker()
    
    private var meals = [Meal]()
}

// MARK: - Meals Business Logic
extension MealsInteractor: MealsBusinessLogic {
    
    func fetchMeals(request: Meals.FetchMeals.Request) {
        
        worker.getMeals(responseSuccess: { [weak self] meals in
            
            self?.meals = meals
            
            let response = Meals.FetchMeals.Response(meals: meals, error: nil)
            self?.presenter?.presentFetchMeals(response: response)
        }, responseError: { [weak self] error in
            
            let response = Meals.FetchMeals.Response(meals: [], error: error)
            self?.presenter?.presentFetchMeals(response: response)
        })
    }
}

// MARK: - Meals Data Store
extension MealsInteractor: MealsDataStore {}
