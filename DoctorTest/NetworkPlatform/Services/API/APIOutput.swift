//
//  APIOutput.swift
//  DemoCleanArchitecture-IOS
//
//  Created by TanVu on 4/1/19.
//  Copyright © 2019 TanVu. All rights reserved.
//

import ObjectMapper

class APIOutput: APIOutputBase {
    private(set) var code: Int!
    private(set) var field: ErrorField!
    private(set) var message: String!

    override func mapping(map: Map) {
        code <- map["errors.code"]
        field <- map["errors.field"]
        message <- map["errors.message"]
    }
}

enum ErrorField: String {
    case others
}
