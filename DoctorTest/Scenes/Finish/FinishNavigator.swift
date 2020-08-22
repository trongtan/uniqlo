//
//  FinishNavigator.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FinishNavigatorType {
    func backToBarCodeReader()
}

struct FinishNavigator: FinishNavigatorType {
    unowned let viewController: UIViewController
    unowned let defaultAssembler: Assembler
    
    var navigator: UINavigationController? {
        return viewController.navigationController
    }
    
    func backToBarCodeReader() {
        if let vc =  navigator?.viewControllers.filter({$0 is BarcodeReaderViewController}).first as? BarcodeReaderViewController {
            vc.resetUI()
            navigator?.popToViewController(vc, animated: true)
        }
    }
}
