//
//  API+VerfifyServerConfig.swift
//  BaseProject
//
//  Created by tan vu on 8/1/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import RxCocoa
import Alamofire

extension API {
    func verifyServerConfig(_ input: ServerConfigInput) -> Observable<ServerConfigOutput> {
        return request(input)
    }
}
// MARK: - Login
extension API {
    final class ServerConfigInput: APIInput {
        init(password: String) {
            let parameters: [String: Any] =
                ["barcode": "barcode"]
            
            super.init(resource: .verifyNetworkConfig,
                       parameters: parameters,
                       requireAccessToken: false)
            
        }
    }

    final class ServerConfigOutput: APIOutput {
        private(set) var isSuccess: Bool?

        override func mapping(map: Map) {
            super.mapping(map: map)
            isSuccess = true
//            receipt = Receipt(map: map)
        }
    }
}

