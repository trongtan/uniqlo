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
        init(info: Receipt) {
            let parameters: [String: Any] =
                [
                    "receiptCode": info.receiptCode,
                    "date": info.date,
                    "totalAmount": info.totalAmount,
                    "retailStoreID": info.retailStoreID,
                    "isBusiness": info.isBusiness,
                    "name": info.name,
                    "legalName": info.legalName,
                    "taxCode": info.taxCode,
                    "address": info.address,
                    "city": info.city,
                    "district": info.district,
                    "fax": info.fax,
                    "email": info.email,
                    "phone": info.phone,
                    "bankAccount": info.bankAccount,
                    "bankName": info.bankName,
                    "notes": info.notes
            ]
            
            super.init(resource: .information,
                       parameters: parameters,
                       requireAccessToken: true)
            
        }
    }

    final class CustomerInfoOutput: APIOutput {
        private(set) var isSuccess: Bool?

        override func mapping(map: Map) {
            super.mapping(map: map)
            isSuccess <- map["data"]
        }
    }
}
