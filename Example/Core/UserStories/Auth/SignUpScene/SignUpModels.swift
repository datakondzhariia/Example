//
//  SignUpModels.swift
//  Example
//
//  Created by Data Kondzhariia on 4/9/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

enum SignUpFieldType {
    
    case firstName, lastName, email, password
}

struct ValidationStatus {
    
    let validationType: SignUpFieldType
    let errorMessage: String?
    
    var success: Bool {
        return errorMessage?.isEmpty ?? false
    }
}

struct ValidationSuccess {
    
    let validationType: SignUpFieldType
}

enum SignUp {
    
    enum ValidationForm {
        
        struct Request {

            let firstName: String?
            let lastName: String?
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
            
            let firstName: String?
            let lastName: String?
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
    
    enum CreateUser {
        
        struct Request {
            
            let firstName: String?
            let lastName: String?
            let email: String?
        }
        
        struct Response {
            
            let error: ExampleError?
        }
        
        struct ViewModel {
            
            let error: ExampleError?
        }
    }
    
    enum Facebook {
        
        struct Request {
        }
        
        struct Response {
            
            let error: ExampleError?
        }
        
        struct ViewModel {
            
            let error: ExampleError?
        }
    }
    
    enum CreateFacebookUser {
        
        struct Request {
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
        
        struct Request {
        }
        
        struct Response {
        }
        
        struct ViewModel {            
        }
    }
}
