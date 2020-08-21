//
//  Receipt.swift
//  BaseProject
//
//  Created by tan vu on 7/31/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation

struct Receipt: Codable {
    
    static let fakeReceipt = Receipt(receiptCode: "2010010199129010101", totalAmount: 500000)
    
    
    var receiptCode: String = ""
    var date: String = ""
    var totalAmount: Int = 0
    
    var retailStoreID: Int = 0
    var isBusiness: Bool = false
    var name: String = ""
    var legalName: String = ""
    var taxCode: String = ""
    var address: String = ""
    var city: String = ""
    var district: String = ""
    var fax: String = ""
    var email: String = ""
    var phone: String = ""
    var bankAccount: String = ""
    var bankName: String = ""
    var notes: String = ""
    
    var displayCode: String {
        return "Receipt code:  \(receiptCode)"
    }
    
    var displayDate: String {
        return "Date: \(date.replacingOccurrences(of: "T", with: " "))"
    }
    
    var displayTotal: String {
        return "Total:  \(totalAmount) VND"
    }

    var isValid: Bool {
        return true
//        return !name.isEmpty &&
//            !legalName.isEmpty &&
//            !taxCode.isEmpty &&
//            !address.isEmpty &&
//            !district.isEmpty &&
//            !city.isEmpty &&
//            !phone.isEmpty &&
//            !fax.isEmpty &&
//            !email.isEmpty &&
//            !bankName.isEmpty &&
//            !bankAccount.isEmpty
    }
}


