//
//  UserDefaultsService.swift
//  Example
//
//  Created by Data Kondzhariia on 29.02.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

enum UserDefaultsKey: String {
    
    case firstRun
}

class UserDefaultsService {
    
    static let shared = UserDefaultsService()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
}

// MARK: - Public Methods
extension UserDefaultsService {
    
    public func save(value: Any, key: UserDefaultsKey) {
        
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    public func get(key: UserDefaultsKey) -> String? {
        
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    public func isFirstRun() -> Bool {
        
        guard get(key: .firstRun) == nil else {
            return false
        }
        
        return true
    }
}
