//
//  TermsFeedWorker.swift
//  Example
//
//  Created by Data Kondzhariia on 4/18/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

class TermsFeedWorker {
    
    typealias ResponseSuccess = (_ value: String) -> Void
    typealias ResponseError = (_ error: ExampleError?) -> Void
}

// MARK: - Public Methods
extension TermsFeedWorker {
    
    public func getValue(mode: ExampleInfoMode, responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        
        NetworkService.shared.getExampleInfo(mode: mode, responseSuccess: responseSuccess, responseError: responseError)
    }
}
