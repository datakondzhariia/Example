//
//  ProfileSettingsModels.swift
//  Example
//
//  Created by Data Kondzhariia on 4/24/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

enum ProfileSettings {
    
    struct DisplayedUser {
        
        let fullName: String!
        let email: String?
    }
    
    enum SetupInfo {
        
        struct Request {
        }
        
        struct Response {
            
            let user: User!
        }
        
        struct ViewModel {
            
            let displayedUser: DisplayedUser!
        }
    }
    
    enum UpdateUserInfo {
        
        struct Request {
        }
        
        struct Response {
            
            let user: User!
            let error: ExampleError?
        }
        
        struct ViewModel {
            
            let displayedUser: DisplayedUser!
            let error: ExampleError?
        }
    }
    
    enum LogOut {
        
        struct Request {
        }
        
        struct Response {
            
            let error: ExampleError?
        }
        
        struct ViewModel {
            
            let error: ExampleError?
        }
    }
    
    enum Version {
        
        struct Request {
        }
        
        struct Response {
            
            let appVersion: String!
        }
        
        struct ViewModel {
            
            let appVersion: String!
        }
    }
}
