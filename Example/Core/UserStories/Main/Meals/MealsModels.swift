//
//  MealsModels.swift
//  Example
//
//  Created by Data Kondzhariia on 24.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

enum Meals {
    
    enum FetchMeals {
        
        struct Request {
        }
        
        struct Response {
            
            let meals: [Meal]
            let error: ExampleError?;
        }
        
        struct ViewModel {
            
            struct DisplayedMeal {
                
                let name: String?
                let description: String?
                let imageUrl: String?
            }
            
            let displayedMeals: [DisplayedMeal]
            let error: ExampleError?
        }
    }
}
