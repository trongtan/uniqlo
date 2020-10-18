//
//  Utilities.swift
//  DemoCleanArchitecture-IOS
//
//  Created by TanVu on 4/1/19.
//  Copyright © 2019 TanVu. All rights reserved.
//

import Foundation
import UIKit

var alert: UIAlertController?

func getNewWindowNavigation() -> UINavigationController {
    let win = UIWindow(frame: UIScreen.main.bounds)
    let nav = GET_APP_DELEGATE?.navigationController ?? UINavigationController()
    win.rootViewController = nav
    win.makeKeyAndVisible()
    return nav
}

func stringFromTimeInterval(interval: TimeInterval) -> String {
    let interval = Int(interval)
//    let seconds = interval % 60
    let minutes = (interval / 60) % 60
    let hours = (interval / 3600)
    return String(format: "%02d:%02d", hours, minutes)
}

func appVersion() -> String {
    guard let dictionary = Bundle.main.infoDictionary,
        let version = dictionary["CFBundleShortVersionString"] as? String,
        let bundleVersion = dictionary["CFBundleVersion"] as? String else { return "" }
    
    let versionAndBuild: String = "\(version).(\(bundleVersion))"
    return versionAndBuild
}
