//
//  EverfitNavigator.swift
//  Spinamic
//
//  Created by tan vu on 3/9/20.
//  Copyright (c) 2020 . All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LoginNavigatorType: NavigatorType {
    func toBarCodeReader()
    func toVerifyServerConfig()
}

struct LoginNavigator: LoginNavigatorType {
    unowned let viewController: UIViewController
    unowned let defaultAssembler: Assembler

    var navigator: UINavigationController? {
        return viewController.navigationController
    }
    
    func toBarCodeReader() {
        let vc: BarcodeReaderViewController = defaultAssembler.resolveViewController()
        navigator?.pushViewController(vc, animated: true)
    }
    
    func toVerifyServerConfig() {
         let vc: VerifyViewController = defaultAssembler.resolveViewController()
        let nav = UINavigationController(rootViewController: vc)
        navigator?.present(nav, animated: true, completion: nil)
    }
}
