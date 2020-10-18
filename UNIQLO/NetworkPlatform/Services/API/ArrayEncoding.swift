//
//  ArrayEncoding.swift
//  Spinamic
//
//  Created by tan vu on 11/5/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire

let arrayParametersKey = "arrayParametersKey"

/// Convert the parameters into a json array, and it is added as the request body.
/// The array must be sent as parameters using its `asParameters` method.
struct ArrayEncoding: ParameterEncoding {
    let defaultEncoder: ParameterEncoding
    
    init(defaultEncoder: ParameterEncoding) {
        self.defaultEncoder = defaultEncoder
    }
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard let array = parameters?[arrayParametersKey] else {
            return try defaultEncoder.encode(urlRequest, with: parameters)
        }
        
        return try JSONEncoding.default.encode(urlRequest, withJSONObject: array)
    }
}

/// Extension that allows an array be sent as a request parameters
extension Array {
    /// Convert the receiver array to a `Parameters` object.
    func asParameters() -> Parameters {
        return [arrayParametersKey: self]
    }
}

