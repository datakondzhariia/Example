//
//  PasswordResetWorker.swift
//  Example
//
//  Created by Data Kondzhariia on 4/22/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

class PasswordResetWorker {
    
    typealias ResponseSuccess = () -> Void
    typealias ResponseError = (_ error: ExampleError?) -> Void

    func forgot(email: String, responseSuccess:  @escaping ResponseSuccess, responseError: @escaping ResponseError) {

        NetworkService.shared.resetPassword(email: email, responseSuccess: responseSuccess, responseError: responseError)
    }
}
