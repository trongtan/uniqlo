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
    struct Colors {
        static let duskBlue = #colorLiteral(red: 0.1490196078, green: 0.2705882353, blue: 0.4901960784, alpha: 1)
        static let darkSkyBlue = #colorLiteral(red: 0.3215686275, green: 0.6235294118, blue: 0.8549019608, alpha: 1)
        static let lightSkyBlue = #colorLiteral(red: 0.2571941912, green: 0.7406113148, blue: 0.7169358134, alpha: 1)
        static let connectedButtonColor = #colorLiteral(red: 0, green: 0.6705882353, blue: 0.6274509804, alpha: 1)
        static let gray = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        static let timingOuterCicleColor = #colorLiteral(red: 0.3333333333, green: 0.4274509804, blue: 0.6745098039, alpha: 1)
        static let timingOuterCicleBackgroundColor = #colorLiteral(red: 0.2588235294, green: 0.4784313725, blue: 0.8274509804, alpha: 0.12)
        static let logoutTextColor = #colorLiteral(red: 0.8784313725, green: 0.1254901961, blue: 0.1254901961, alpha: 1)
        static let settingDetailsColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 0.6)
        static let dullOrangeColor = #colorLiteral(red: 0.9411764706, green: 0.5019607843, blue: 0.1490196078, alpha: 1)
    }
    
    struct Key {
        static let token = "TOKEN"
        static let kBLEServiceUUID = "kBLEServiceUUID"
        static let kDeviceName = "kDeviceName"
        static let trackingTime = "TrackingTime"
        static let trackingDate = "TrackingDate"
        static let kUserName = "kUserName"
    }
    
    struct Messages {
        static let ForgotMessageMailSubject = "[Forgot Password - Spinamic]"
        static let ForgotMessageMailBody = "<p>Please send me the mail address you have joinded.</p> <p>We will then send you a temporary passsword to that email address</p> </br> <p> Email you have joined: </p>"
        static let ForgotMessageMailRecipients = ["contact@vntc.me"]
        static let notificationTitle = "Spinamic"
        static let notificationBody = "A Long tine passed. Please wear Spinamic right now."
    }
    
    struct Fonts {
        static let settingFont = UIFont(name:"AppleSDGothicNeo-Regular", size:15)
        static let settingDetailFont = UIFont(name:"AppleSDGothicNeo-Regular", size:12)
    }
}

let kBLEService_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
let kBLE_Characteristic_uuid_Tx = "6e400002-b5a3-f393-e0a9-e50e24dcca9e"
let kBLE_Characteristic_uuid_Rx = "6e400003-b5a3-f393-e0a9-e50e24dcca9e"
let kBLE_Characteristic_uuid_Generic_attribute = "1801"
let kBLE_Characteristic_uuid_Generic_Access = "1800"
let MaxCharacters = 20

let BLEService_UUID = CBUUID(string: kBLEService_UUID)
let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_Characteristic_uuid_Tx)//(Property = Write without response)
let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_Characteristic_uuid_Rx)// (Property = Read/Notify)


extension UserDefaults {
    func removeAllObject() {
        UserDefaults.standard.removeObject(forKey: Constants.Key.token)
        UserDefaults.standard.removeObject(forKey: Constants.Key.kBLEServiceUUID)
        UserDefaults.standard.removeObject(forKey: Constants.Key.trackingTime)
        UserDefaults.standard.removeObject(forKey: Constants.Key.trackingDate)
        UserDefaults.standard.removeObject(forKey: Constants.Key.kDeviceName)
        UserDefaults.standard.removeObject(forKey: Constants.Key.kUserName)
    }
}
