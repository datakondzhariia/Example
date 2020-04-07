//
//  SignInModels.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

enum SignIn {
        
    enum ValidationForm {
        
        struct Request {
            
            let email: String?
            let password: String?
        }
        
        struct Response {
            
            let validationStatuses: [ValidationStatus]
        }
        
        struct ViewModel {
            
            let validationStatuses: [ValidationStatus]
        }
    }

    enum Register {
        
        struct Request {
            
            let email: String?
            let password: String?
        }
        
        struct Response {
            
            let error: ExampleError?
        }
        
        struct ViewModel {
            
            let error: ExampleError?
        }
    }
    
    enum FetchUser {
        
        struct Request {
        }
        
        struct Response {
            
            let error: ExampleError?
        }
        
        struct ViewModel {
            
            let error: ExampleError?
        }
    }
    
    enum FormCleanUp {
        
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
}
