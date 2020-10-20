//
//  AppDelegate.swift
//  Uniqlo
//
//  Created by tan vu on 7/20/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import UIKit
import RxSwift
import CoreData
import IQKeyboardManagerSwift

let GET_APP_DELEGATE = UIApplication.shared.delegate as? AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    let disposeBad = DisposeBag()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        navigationController = initNavi()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        
        return true
    }
    
    func goSystemConfigMenu() {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        
    }
}

extension AppDelegate {
    func initNavi() -> UINavigationController {
        let loginVC: LoginViewController = DefaultAssembler.shared.resolveViewController()
        let barCodeVC: BarcodeReaderViewController = DefaultAssembler.shared.resolveViewController()
        
        let navigationVc = UINavigationController(rootViewController: loginVC)
        if !UserDefaults.accessToken.isEmpty {
            navigationVc.pushViewController(barCodeVC, animated: false)
        }

        navigationVc.navigationBar.tintColor = .white
        return navigationVc
    }
}



extension UIApplication {
    func topNav() -> UINavigationController? {
        return UIApplication.shared.windows.first?.rootViewController as? UINavigationController
    }
}

extension UserDefaults {
    static var serverURL: String {
        return UserDefaults.standard.value(forKey: Constants.Key.serverURL) as? String ?? ""
    }
    
    static var serverPort: String {
        return UserDefaults.standard.value(forKey: Constants.Key.serverPort) as? String ?? ""
    }

    static var accessToken: String {
        return UserDefaults.standard.value(forKey: Constants.Key.token) as? String ?? ""
    }
}

