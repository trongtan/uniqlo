//
//  InformationNavigator.swift
//  Uniqlo
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol InformationNavigatorType {
    func backToBarCodeReader()
    func toFinishView()
}

struct InformationNavigator: InformationNavigatorType {
    unowned let viewController: UIViewController
    unowned let defaultAssembler: Assembler

    var navigator: UINavigationController? {
        return viewController.navigationController
    }
    
    func backToBarCodeReader() {
        navigator?.popViewController(animated: true)
    }
    
    func toFinishView() {
        let vc: FinishViewController = defaultAssembler.resolveViewController()
        navigator?.pushViewController(vc, animated: true)
    }
}
