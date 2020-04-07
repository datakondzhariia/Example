//
//  Dictionary+Additionals.swift
//  Example
//
//  Created by Data Kondzhariia on 03.03.2020.
//  Copyright © 2020 Data Kondzhariia. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func convertData<T: Decodable>(to expectedType: T.Type) -> T? {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            return try? JSONDecoder().decode(expectedType, from: data)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
