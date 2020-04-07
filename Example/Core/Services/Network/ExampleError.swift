//
//  ExampleError.swift
//  Example
//
//  Created by Data Kondzhariia on 4/12/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

enum StatusCode: Int {
    
    case cancelled = -999
    case unauthorized = 401
}

struct ExampleError: Error {
    
    enum Kind {
        
        case custom
        case emptyBody
        case wrongDataFormat
        case noAccessLocation
        case noInternetConnection
        case mailNotAvailable
        case mealFromOtherProvider
        case currentUserNotFound
        case confirmPayment
        case other
    }
    
    let statusCode: Int?
    let message: String?
    let kind: Kind?
    
    init(kind: Kind) {
        
        self.kind = kind
        self.statusCode = 666
        switch kind {
        case .emptyBody:
            message = R.string.localizable.emptyBody()
        case .wrongDataFormat:
            message = R.string.localizable.wrongDataFormat()
        case .noAccessLocation:
            message = R.string.localizable.noAccessLocation()
        case .noInternetConnection:
            message = R.string.localizable.noInternetConnection()
        case .mailNotAvailable:
            message = R.string.localizable.mailNotAvailable()
        case .currentUserNotFound:
            message = R.string.localizable.currentUserNotFound()
        case .other:
            message = R.string.localizable.other()
        default:
            message = R.string.localizable.other()
        }
    }
    
    init(statusCode: Int?, message: String?) {
        
        self.kind = .custom
        self.message = message
        self.statusCode = statusCode
    }
    
    init(message: String?) {
        
        self.kind = .custom
        self.message = message
        self.statusCode = nil
    }
}

