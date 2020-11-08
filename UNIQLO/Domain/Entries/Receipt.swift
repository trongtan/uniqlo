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
    var isBusiness: Bool = true
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
        return "\("Receipt code".localization):  \(receiptCode)"
    }
    
    var displayDate: String {
        return "\("Date".localization): \(date.replacingOccurrences(of: "T", with: " "))"
    }
    
    var displayTotal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formattedTotalAmountt = formatter.string(from: totalAmount as NSNumber) {
            return "\("Total".localization):  \(formattedTotalAmountt) VND"
        }
        
        return "\("Total".localization):  \(totalAmount) VND"
    }
    
    var validate: (isValid: Bool, message: String) {
//        #if DEBUG
//        return (true, "")
//        #else

        var valid = true
        var message = ""

        if !self.validateEmail(email: email) {
            valid = false
            message = "\("Email is not right format".localization)\n"
        }

        var tmp: [String] = []

        if isBusiness {
            if legalName.isEmpty || legalName.count > 255 {
                valid = false
                tmp.append("Company name".localization)
            }
        } else {
            if name.isEmpty || name.count > 255 {
                valid = false
                tmp.append("Name".localization)
            }
        }   

        if taxCode.isEmpty || taxCode.count > 20 {
            valid = false
            tmp.append("Taxcode".localization)
        }

        if address.isEmpty || address.count > 255 {
            valid = false
            tmp.append("Address".localization)
        }

//        if district.count > 50 {
//            valid = false
//            tmp.append("District".localization)
//        }
//        if city.count > 25 {
//            valid = false
//            tmp.append("City".localization)
//        }

        if phone.isEmpty || phone.count > 20 {
            valid = false
            tmp.append("Phone".localization)
        }
//        if fax.count > 20 {
//            valid = false
//            tmp.append("Fax".localization)
//        }
        if email.isEmpty || email.count > 500 {
            valid = false
            tmp.append("Email".localization)
        }
//        if bankName.count > 100 {
//            valid = false
//            tmp.append("Bank name".localization)
//        }
//        if bankAccount.count > 20 {
//            valid = false
//            tmp.append("Bank account".localization)
//        }
//        if notes.count > 255 {
//            valid = false
//            tmp.append("Notes".localization)
//        }

        let verb = tmp.count > 1 ? "are".localization : (tmp.count == 0 ? "" : "is".localization)
        let msg = tmp.count == 0 ? "" : "invalid".localization
        return (valid, "\(message)\(tmp.joined(separator: ", ")) \(verb) \(msg)")

//        #endif
    }

    //    (isValid: Bool, message: String)
    private func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailPred.evaluate(with: email)
    }
}


