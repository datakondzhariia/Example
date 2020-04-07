//
//  WelcomeModels.swift
//  Example
//
//  Created by Data Kondzhariia on 4/10/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

enum Welcome {
    
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
}
