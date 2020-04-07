//
//  KeychainService.swift
//  Example
//
//  Created by Data Kondzhariia on 29.02.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import KeychainAccess

enum KeychainKey: String {
    
    case access
    /*case device*/
}

class KeychainService {
    
    static let shared = KeychainService()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
}

// MARK: - Public Methods
extension KeychainService {

    public func save(token: String, key: KeychainKey) {
        
        let keychain = Keychain()
        try? keychain.set(token, key: key.rawValue)
    }
    
    public func get(key: KeychainKey) -> String? {
        
        let keychain = Keychain()
        return try? keychain.get(key.rawValue)
    }
    
    public func remove(key: KeychainKey) {
        
        let keychain = Keychain()
        try? keychain.remove(key.rawValue)
    }
}
