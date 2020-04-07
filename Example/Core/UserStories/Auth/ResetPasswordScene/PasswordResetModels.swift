//
//  PasswordResetModels.swift
//  Example
//
//  Created by Data Kondzhariia on 4/22/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

enum PasswordReset {
    
    enum ValidationForm {
        
        struct Request {
            
            let email: String?
        }
        
        struct Response {
            
            let validationStatus: ValidationStatus
        }
        
        struct ViewModel {
            
            let validationStatus: ValidationStatus
        }
    }
    
    enum Forgot {
        
        struct Request {
            
            let email: String?
        }
        
        struct Response {
            
            let error: ExampleError?
        }
        
        struct ViewModel {
            
            let error: ExampleError?
        }
    }
}
