//
//  User.swift
//  Example
//
//  Created by Data Kondzhariia on 01.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Realm
import RealmSwift

class User: Object, Decodable {
        
    @objc dynamic private(set) var id: String
    @objc dynamic private(set) var firstName: String?
    @objc dynamic private(set) var lastName: String?
    @objc dynamic private(set) var email: String?
    
    public var fullName: String {
        return (firstName ?? "") + " " + (lastName ?? "")
    }

    override class func primaryKey() -> String? {
        return #keyPath(id)
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case firstName
        case lastName
        case email
    }
}

