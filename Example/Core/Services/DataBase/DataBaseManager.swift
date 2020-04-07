//
//  DataBaseManager.swift
//  Example
//
//  Created by Data Kondzhariia on 4/16/19.
//  Copyright © 2019 Example. All rights reserved.
//

import RealmSwift

class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private var realm = try! Realm()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
}

// MARK: - General Realm Methods
extension DataBaseManager {
    
    public func saveObject(_ object: Object) {
        
        try! realm.write {
            realm.add(object, update: .all)
        }
    }
    
    public func saveObjects(_ objects: [Object]) {
        
        try! realm.write {
            realm.add(objects, update: .all)
        }
    }
    
    public func update(_ updateBlock: (() -> Void)) {
        
        try! realm.write {
            updateBlock()
        }
    }
    
    public func deleteObjectFromDataBase(_ object: Object) {
        
        try! realm.write {
            realm.delete(object)
        }
    }
    
    public func deleteObjectsFromDataBase(_ objects: [Object]) {

        try! realm.write {
            realm.delete(objects)
        }
    }
    
    public func deleteAllFromDataBase() {
        
        try! realm.write {
            realm.deleteAll()
        }
    }
}

// MARK: - Methods For Getting Objects
extension DataBaseManager {
 
    public func getObjectResults<T: Object>(object: T.Type) -> Results<T> {
        
        let results: Results<T> = realm.objects(T.self)
        return results
    }
}
