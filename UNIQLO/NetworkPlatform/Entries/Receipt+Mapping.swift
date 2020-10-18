//
//  Recepit+Mapping.swift
//  BaseProject
//
//  Created by tan vu on 8/1/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation
import ObjectMapper

extension Receipt: Mappable {
    init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        receiptCode <- map["receiptCode"]
        date <- map["date"]
        totalAmount <- map["totalAmount"]
        retailStoreID <- map["retailStoreID"]
        isBusiness <- map["isBusiness"]
        name <- map["name"]
        legalName <- map["legalName"]
        taxCode <- map["taxCode"]
        address <- map["address"]
        city <- map["city"]
        district <- map["district"]
        fax <- map["fax"]
        email <- map["email"]
        phone <- map["phone"]
        bankAccount <- map["bankAccount"]
        bankName <- map["bankName"]
        notes <- map["notes"]
    }
}
