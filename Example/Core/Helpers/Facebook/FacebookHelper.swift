//
//  FacebookHelper.swift
//  Example
//
//  Created by Data Kondzhariia on 4/17/19.
//  Copyright © 2019 Example. All rights reserved.
//

import FBSDKLoginKit

struct FacebookUser: Codable {
    
    let firstName: String?
    let lastName: String?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        
        case firstName = "first_name"
        case lastName = "last_name"
        case email
    }
}

class FacebookHelper {
    
    static let shared = FacebookHelper()

    typealias ResponseSuccess = (_ token: String) -> Void
    typealias ResponseError = (_ error: ExampleError?) -> Void

    private init() {
        // Private initialization to ensure just one instance is created
    }
}

// MARK: - Public Methods
extension FacebookHelper {
    
    public func auth(responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {

        let loginManager = LoginManager()
        loginManager.logOut()
        
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil, completion: { result in
            
            switch result {
                
            case .failed(let error):
                
                let error = ExampleError(message: error.localizedDescription)
                responseError(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(granted: _, declined: _, token: let accessToken):
                
                let token = accessToken.tokenString
                responseSuccess(token)
            }
        })
    }
    
    public func getUser(responseSuccess: @escaping(_ user: FacebookUser) -> Void, responseError: @escaping(_ error: ExampleError?) -> Void) {
        
        let request = GraphRequest(graphPath: "me", parameters: ["fields": "first_name, last_name, email"])
        request.start { connection, result, error in
            
            guard error == nil, let userInfo = result as? [String: Any] else {
                
                let error = ExampleError(kind: .other)
                responseError(error)
                return
            }

            guard let user = userInfo.convertData(to: FacebookUser.self) else {
                
                let error = ExampleError(kind: .other)
                responseError(error)
                return
            }
            
            responseSuccess(user)
        }
    }
}
