//
//  ServerConfigNavigator.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ServerConfigNavigatorType {
    func dismiss()
}

struct ServerConfigNavigator: ServerConfigNavigatorType {
    unowned let viewController: UIViewController
    unowned let defaultAssembler: Assembler

    var navigator: UINavigationController? {
        return viewController.navigationController
    }
    
    func dismiss() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
