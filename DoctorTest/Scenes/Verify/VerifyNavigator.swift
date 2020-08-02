//
//  VerifyNavigator.swift
//  DoctorTest
//
//  Created by tan vu on 8/2/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol VerifyNavigatorType {
    func toServerConfig()
    func dismiss()
}

struct VerifyNavigator: VerifyNavigatorType {
    unowned let viewController: UIViewController
    unowned let defaultAssembler: Assembler
    
    var navigator: UINavigationController? {
        return viewController.navigationController
    }
    
    func toServerConfig() {
        let vc: ServerConfigViewController = defaultAssembler.resolveViewController()
        navigator?.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
