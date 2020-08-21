//
//  Constants.swift
//  Spinamic
//
//  Created by tan vu on 10/22/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

struct Constants {
    struct Key {
        static let token = "TOKEN"
        static let serverURL = "serverURL"
        static let serverPort = "serverPort"
    }
    
    struct Colors {
        static let uniqlo = UIColor(hex: "#f60000").withAlphaComponent(0.8)
    }
    
    struct Configs {
        static let clientID = "BD067717-C227-48C8-8135-724CD3C6D4BE"
        static let receiptCodeLength = 26
        static let defaultPassword = "lego123"
    }
}
