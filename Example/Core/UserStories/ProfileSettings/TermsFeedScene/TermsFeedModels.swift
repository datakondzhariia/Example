//
//  TermsFeedModels.swift
//  Example
//
//  Created by Data Kondzhariia on 4/18/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

enum TermsFeedInfo {
    
    enum SetupInfo {
        
        struct Request {
        }
        
        struct Response {
            
            let value: String?
            let mode: ExampleInfoMode
            let error: ExampleError?
        }
        
        struct ViewModel {
            
            struct DisplayedTermsFeedInfo {
                
                let title: String!
                let infoMessage: String?
            }
            
            let displayedTermsFeedInfo: DisplayedTermsFeedInfo
            let error: ExampleError?
        }
    }
    
    enum FinishSignUp {
        
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
