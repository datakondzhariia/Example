//
//  NetworkService.swift
//  Example
//
//  Created by Data Kondzhariia on 4/11/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum ExampleInfoMode: String {
    
    public var title: String {
        switch self {
        case .termsConditions:
            return "Terms & Conditions"
        case .privacyPolicy:
            return "Privacy Policy"
        case .aboutUs:
            return "About Us"
        }
    }
    
    case termsConditions = "terms"
    case privacyPolicy = "privacy"
    case aboutUs = "aboutus"
}

class NetworkService {

    static let shared = NetworkService()
    
    private init() {
        // Private initialization to ensure just one instance is created
    }
}

// MARK: - Private Methods
extension NetworkService {
    
    public func manualSignUp(firstName: String, lastName: String, email: String, password: String, responseSuccess: @escaping(_ token: String, _ userID: String) -> Void, responseError: @escaping(ExampleError?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in

            guard let result = result else {

                let error = ExampleError(message: error?.localizedDescription)
                responseError(error)
                return
            }

            result.user.getIDToken(completion: { token, error in

                guard let token = token else {

                    let error = ExampleError(message: error?.localizedDescription)
                    responseError(error)
                    return
                }

                responseSuccess(token, result.user.uid)
            })
        })
    }
    
    public func signInFacebook(token: String, responseSuccess: @escaping(_ token: String, _ userID: String) -> Void, responseError: @escaping(ExampleError?) -> Void) {
        
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        
        Auth.auth().signIn(with: credential) { result, error in
            
            guard let result = result else {
                
                let error = ExampleError(message: error?.localizedDescription)
                responseError(error)
                return
            }
            
            result.user.getIDToken(completion: { token, error in
                
                guard let token = token else {
                    
                    let error = ExampleError(message: error?.localizedDescription)
                    responseError(error)
                    return
                }
                
                responseSuccess(token, result.user.uid)
            })
        }
    }
    
    public func signIn(email: String, password: String, responseSuccess: @escaping(_ token: String, _ userID: String) -> Void, responseError: @escaping(ExampleError?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            
            guard let result = result else {
                
                let error = ExampleError(message: error?.localizedDescription)
                responseError(error)
                return
            }
            
            result.user.getIDToken(completion: { token, error in
                
                guard let token = token else {
                    
                    let error = ExampleError(message: error?.localizedDescription)
                    responseError(error)
                    return
                }
                
                responseSuccess(token, result.user.uid)
            })
        })
    }
    
    // Create user to Firebase Database
    public func createUser(id: String, firstName: String, lastName: String, email: String, responseSuccess: @escaping() -> Void, responseError: @escaping(ExampleError?) -> Void) {
        
        let db = Firestore.firestore()
        
        let data = ["id": id, "firstName": firstName, "lastName": lastName, "email": email]
        db.collection("users").addDocument(data: data, completion: { error in
            
            guard error == nil else {
                
                let error = ExampleError(message: error?.localizedDescription)
                responseError(error)
                return
            }
            
            responseSuccess()
        })
    }
    
    public func getUser(id: String, responseSuccess: @escaping(_ user: User) -> Void, responseError: @escaping(_ error: ExampleError?) -> Void) {
        
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments(completion: { snapshot, error in
            
            guard let snapshot = snapshot else {
                
                let error = ExampleError(message: error?.localizedDescription)
                responseError(error)
                return
            }
            
            var userData: User?
            
            for document in snapshot.documents {
                
                if let userID = document.data()["id"] as? String, userID == id {
                    
                    userData = document.data().convertData(to: User.self)
                    break
                }
            }
            
            guard let user = userData else {
                
                let error = ExampleError(kind: .other)
                responseError(error)
                return
            }
            
            responseSuccess(user)
        })
    }
    
    public func resetPassword(email: String, responseSuccess: @escaping() -> Void, responseError: @escaping(_ error: ExampleError?) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            
            guard error == nil else {
                
                let error = ExampleError(message: error?.localizedDescription)
                responseError(error)
                return
            }
            
            responseSuccess()
        }
    }
    
    public func getExampleInfo(mode: ExampleInfoMode, responseSuccess: @escaping(_ value: String) -> Void, responseError: @escaping(_ error: ExampleError?) -> Void) {
        
        let db = Firestore.firestore()
        
        db.collection(mode.rawValue).getDocuments(completion: { snapshot, error in
            
            guard error == nil else {
                
                let error = ExampleError(message: error?.localizedDescription)
                responseError(error)
                return
            }
            
            let value = snapshot?.documents.first?["value"] as? String
            responseSuccess(value ?? "")
        })
    }
    
    public func logOut(responseSuccess: @escaping() -> Void, responseError: @escaping(_ error: ExampleError?) -> Void) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            responseSuccess()
        } catch let error {
            
            let error = ExampleError(message: error.localizedDescription)
            responseError(error)
        }
    }
    
    public func getMeals(responseSuccess: @escaping(_ meals: [Meal]) -> Void, responseError: @escaping(_ error: ExampleError?) -> Void) {
        
        let db = Firestore.firestore()

        db.collection("meals").getDocuments(completion: { snapshot, error in
            
            guard let snapshot = snapshot else {
                
                let error = ExampleError(message: error?.localizedDescription)
                responseError(error)
                return
            }
            
            var meals = [Meal]()
            
            if let document = snapshot.documents.first, let data = document.data()["data"] as? [[String: Any]] {

                for meal in data {
                    
                    guard let meal = meal.convertData(to: Meal.self) else {
                        return
                    }
                    
                    meals.append(meal)
                }
            }
            
            responseSuccess(meals)
        })
    }
}

