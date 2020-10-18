//
//  APIOutput.swift
//  DemoCleanArchitecture-IOS
//
//  Created by TanVu on 4/1/19.
//  Copyright © 2019 TanVu. All rights reserved.
//

import ObjectMapper

class APIOutput: APIOutputBase {
    private(set) var statusCode: Int!
    private(set) var error: ErrorField!
    private(set) var message: String!

    override func mapping(map: Map) {
        statusCode <- map["statusCode"]
        error <- map["error"]
        message <- map["message"]
    }
}

enum ErrorField: String {
    case others
}
