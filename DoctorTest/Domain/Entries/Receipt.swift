//
//  Receipt.swift
//  BaseProject
//
//  Created by tan vu on 7/31/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation

struct Receipt: Codable {
    
    static let fakeReceipt = Receipt(code: "2010010199129010101", date: "01/08/2020 16:00:15", total: "500000 VND")
    var code: String = ""
    var date: String = ""
    var total: String = ""
    
    var displayCode: String {
        return "Receipt code:  \(code)"
    }
    
    var displayDate: String {
        return "Date: \(date)"  
    }
    
    var displayTotal: String {
        return "Total:  \(total)"
    }
}
