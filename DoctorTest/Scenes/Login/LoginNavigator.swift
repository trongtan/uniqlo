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
}

struct LoginNavigator: LoginNavigatorType {
    unowned let viewController: UIViewController
    unowned let defaultAssembler: Assembler

    var navigator: UINavigationController? {
        return viewController.navigationController
    }
}
