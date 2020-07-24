//
//  APIInputBase.swift
//  DemoCleanArchitecture-IOS
//
//  Created by TanVu on 4/1/19.
//  Copyright © 2019 TanVu. All rights reserved.
//

import Alamofire

class APIInput: APIInputBase {
    init(resource: API.APIResource, parameters: [String: Any]?, requireAccessToken: Bool,
                  useCache: Bool = false) {
        super.init(urlString: resource.resource.route,
                   parameters: parameters,
                   requestType: resource.resource.method,
                   requireAccessToken: requireAccessToken)
//        self.headers = [
//            "Content-Type": "application/json; charset=utf-8",
//            "Accept": "application/json"
//        ]
        
        self.user = nil
        self.password = nil
    }
}
