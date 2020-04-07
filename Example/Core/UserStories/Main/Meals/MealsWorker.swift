//
//  MealsWorker.swift
//  Example
//
//  Created by Data Kondzhariia on 24.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

class MealsWorker {
    
    typealias ResponseSuccess = (_ meals: [Meal]) -> Void
    typealias ResponseError = (_ error: ExampleError?) -> Void
}

// MARK: - Public Methods
extension MealsWorker {
    
    public func getMeals(responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        
        NetworkService.shared.getMeals(responseSuccess: { meals in
        
            DataBaseManager.shared.saveObjects(meals)
            
            responseSuccess(meals)
            
        }, responseError: responseError)
    }
}
