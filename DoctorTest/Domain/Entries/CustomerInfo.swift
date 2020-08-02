//
//  CustomerInfo.swift
//  BaseProject
//
//  Created by tan vu on 7/31/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation

struct CustomerInfo: Codable {
    var type: String = ""
    var name: String = ""
    var company: String = ""
    var tax: String = ""
    var address: String = ""
    var state: String = ""
    var city: String = ""
    var phone: String = ""
    var fax: String = ""
    var email: String = ""
    var bankName: String = ""
    var bankAccount: String = ""
    var note: String = ""
    
    var isValid: Bool {
        return true
//        return !name.isEmpty &&
//            !name.isEmpty &&
//            !company.isEmpty &&
//            !tax.isEmpty &&
//            !address.isEmpty &&
//            !state.isEmpty &&
//            !city.isEmpty &&
//            !phone.isEmpty &&
//            !fax.isEmpty &&
//            !email.isEmpty &&
//            !bankName.isEmpty &&
//            !bankAccount.isEmpty
    }
}

