//
//  AboutUsWorker.swift
//  Example
//
//  Created by Data Kondzhariia on 5/2/19.
//  Copyright (c) 2019 Example. All rights reserved.
//

import UIKit

class AboutUsWorker {
    
    typealias ResponseSuccess = (_ value: String) -> Void
    typealias ResponseError = (_ error: ExampleError?) -> Void
}

// MARK: - About Us Worker
extension AboutUsWorker {
    
    public func getValue(mode: ExampleInfoMode, responseSuccess: @escaping ResponseSuccess, responseError: @escaping ResponseError) {
        
        NetworkService.shared.getExampleInfo(mode: mode, responseSuccess: responseSuccess, responseError: responseError)
    }
}
