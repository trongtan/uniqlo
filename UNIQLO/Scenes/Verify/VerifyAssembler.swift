//
//  VerifyAssembler.swift
//  Uniqlo
//
//  Created by tan vu on 8/2/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// TODO: PLease copy "VerifyAssembler" to protocol Assembler 
// and remove me after done

protocol VerifyAssembler {
    func resolveViewController() -> VerifyViewController
    func resolveViewModel(navigator: VerifyNavigatorType, interactor: VerifyInteractorType) -> VerifyViewModel
    func resolveNavigator(viewController: UIViewController) -> VerifyNavigatorType
    func resolveInteractor() -> VerifyInteractorType
}

extension VerifyAssembler {
    func resolveViewController() -> VerifyViewController {
        let vc = VerifyViewController.instantiate()
        let navigator = resolveNavigator(viewController: vc)
        let interactor = resolveInteractor()
        let vm: VerifyViewModel = resolveViewModel(navigator: navigator, interactor: interactor)

        vc.bindViewModel(to: vm)
        return vc
    }

    func resolveViewModel(navigator: VerifyNavigatorType, interactor: VerifyInteractorType) -> VerifyViewModel {
        return VerifyViewModel(navigator: navigator, interactor: interactor)
    }
}

extension VerifyAssembler where Self: DefaultAssembler {
    func resolveNavigator(viewController: UIViewController) -> VerifyNavigatorType {
        return VerifyNavigator(viewController: viewController, defaultAssembler: DefaultAssembler.shared)
    }

    func resolveInteractor() -> VerifyInteractorType {
        return VerifyInteractor(usecase: NetworkUseCase.make() as! NetworkUseCaseType)
    }
}
