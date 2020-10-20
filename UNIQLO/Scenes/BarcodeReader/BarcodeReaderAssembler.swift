//
//  BarcodeReaderAssembler.swift
//  Uniqlo
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// TODO: PLease copy "BarcodeReaderAssembler" to protocol Assembler 
// and remove me after done

protocol BarcodeReaderAssembler {
    func resolveViewController() -> BarcodeReaderViewController
    func resolveViewModel(navigator: BarcodeReaderNavigatorType, interactor: BarcodeReaderInteractorType) -> BarcodeReaderViewModel
    func resolveNavigator(viewController: UIViewController) -> BarcodeReaderNavigatorType
    func resolveInteractor() -> BarcodeReaderInteractorType
}

extension BarcodeReaderAssembler {
    func resolveViewController() -> BarcodeReaderViewController {
        let vc = BarcodeReaderViewController.instantiate()
        let navigator = resolveNavigator(viewController: vc)
        let interactor = resolveInteractor()
        let vm: BarcodeReaderViewModel = resolveViewModel(navigator: navigator, interactor: interactor)

        vc.bindViewModel(to: vm)
        return vc
    }

    func resolveViewModel(navigator: BarcodeReaderNavigatorType, interactor: BarcodeReaderInteractorType) -> BarcodeReaderViewModel {
        return BarcodeReaderViewModel(navigator: navigator, interactor: interactor)
    }
}

extension BarcodeReaderAssembler where Self: DefaultAssembler {
    func resolveNavigator(viewController: UIViewController) -> BarcodeReaderNavigatorType {
        return BarcodeReaderNavigator(viewController: viewController, defaultAssembler: DefaultAssembler.shared)
    }

    func resolveInteractor() -> BarcodeReaderInteractorType {
        return BarcodeReaderInteractor(usecase: NetworkUseCase.make() as! NetworkUseCaseType)
    }
}
