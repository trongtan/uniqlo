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
    var date: Date = Date() //2020-05-28T08:05:51
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
        return "Date: \(date)"  
    }
    
    var displayTotal: String {
        return "Total:  \(totalAmount)"
    }
}


