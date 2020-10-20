//
//  UniqloEncoding.swift
//  Uniqlo
//
//  Created by tan vu on 7/23/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Alamofire

struct CustomEncoding: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return urlRequest }
        
        let postString = parameters.map { "\($0)=\($1)"}.joined(separator: "&")
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        return urlRequest
    }
}
