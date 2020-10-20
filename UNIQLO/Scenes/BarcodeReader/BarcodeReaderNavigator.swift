//
//  BarcodeReaderNavigator.swift
//  Uniqlo
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol BarcodeReaderNavigatorType {
    func toFillInformationPage(with receipt: Receipt)
    func backToLogin()
}

struct BarcodeReaderNavigator: BarcodeReaderNavigatorType {
    unowned let viewController: UIViewController
    unowned let defaultAssembler: Assembler

    var navigator: UINavigationController? {
        return viewController.navigationController
    }
    
    func toFillInformationPage(with receipt: Receipt) {
        let informationVC: InformationViewController = defaultAssembler.resolveViewController(receipt: receipt)
        navigator?.pushViewController(informationVC, animated: true)
    }
    
    func backToLogin() {
        navigator?.popToRootViewController(animated: true)
    }
}
