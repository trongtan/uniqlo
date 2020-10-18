//
//  API+Barcode.swift
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
    func receipt(_ input: ReceiptInput) -> Observable<ReceiptOutput> {
        return request(input)
    }
}
// MARK: - Login
extension API {
    final class ReceiptInput: APIInput {
        init(barcode: String) {
            let parameters: [String: Any] =
                ["receiptCode": barcode]
            
            super.init(resource: .receipt,
                       parameters: parameters,
                       requireAccessToken: true)
            
        }
    }

    final class ReceiptOutput: APIOutput {
        private(set) var receipt: Receipt?

        override func mapping(map: Map) {
            super.mapping(map: map)
            receipt <- map["data"]
        }
    }
}

