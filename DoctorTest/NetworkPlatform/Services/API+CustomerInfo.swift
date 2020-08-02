//
//  API+CustomerInfo.swift
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
    func submitCustomerInfo(_ input: CustomerInfoInput) -> Observable<CustomerInfoOutput> {
        return request(input)
    }
}
// MARK: - Login
extension API {
    final class CustomerInfoInput: APIInput {
        init(info: CustomerInfo) {
            let parameters: [String: Any] =
                ["barcode": "barcode"]
            
            super.init(resource: .information,
                       parameters: parameters,
                       requireAccessToken: false)
            
        }
    }

    final class CustomerInfoOutput: APIOutput {
        private(set) var isSuccess: Bool?

        override func mapping(map: Map) {
            super.mapping(map: map)
            isSuccess = true
//            receipt = Receipt(map: map)
        }
    }
}
