//
//  Meals.swift
//  Example
//
//  Created by Data Kondzhariia on 24.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Realm
import RealmSwift

class Meal: Object, Decodable {
        
    @objc dynamic private(set) var id: String
    @objc dynamic private(set) var fullDescription: String?
    @objc dynamic private(set) var imageUrl: String?
    @objc dynamic private(set) var title: String?
    
    override class func primaryKey() -> String? {
        return #keyPath(id)
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case fullDescription = "description"
        case imageUrl
        case title
    }
}
