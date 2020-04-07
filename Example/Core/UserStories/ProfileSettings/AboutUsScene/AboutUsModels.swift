//
//  AboutUsModels.swift
//  Example
//
//  Created by Data Kondzhariia on 5/2/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

enum AboutUs {
    
    enum SetupInfo {
        
        struct Request {}
        struct Response {
            
            struct ExampleInfo {
                
                let phoneNumber: String?
                let git: String?
                let email: String?
                let location: String?
                let value: String?
            }
            
            let exampleInfo: ExampleInfo!
            let error: ExampleError?
        }
        struct ViewModel {
            
            struct DisplayedInfo {
                
                let phoneNumber: String?
                let git: String?
                let email: String?
                let location: String?
                let value: String?
            }
            
            let displayedInfo: DisplayedInfo!
            let error: ExampleError?
        }
    }
    
    enum PhoneNumber {
        
        struct Request {
            
            let phoneNumber: String?
        }
        struct Response {
            
            let url: URL!
        }
        struct ViewModel {
            
            let url: URL!
        }
    }
    
    enum ComposeMail {
        
        struct Request {}
        struct Response {
            
            let error: ExampleError?
        }
        struct ViewModel {
            
            let error: ExampleError?
        }
    }
    
    enum Git {
        
        struct Request {
            
            let url: String?
        }
        struct Response {
            
            let url: URL!
        }
        struct ViewModel {
            
            let url: URL!
        }
    }
    
    enum Location {
        
        struct Request {
            
            let address: String?
        }
        
        struct Response {
            
            let url: URL!
        }
        struct ViewModel {
            
            let url: URL!
        }
    }
}
