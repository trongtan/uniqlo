//
//  FinishAssembler.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// TODO: PLease copy "FinishAssembler" to protocol Assembler 
// and remove me after done

protocol FinishAssembler {
    func resolveViewController() -> FinishViewController
    func resolveViewModel(navigator: FinishNavigatorType, interactor: FinishInteractorType) -> FinishViewModel
    func resolveNavigator(viewController: UIViewController) -> FinishNavigatorType
    func resolveInteractor() -> FinishInteractorType
}

extension FinishAssembler {
    func resolveViewController() -> FinishViewController {
        let vc = FinishViewController.instantiate()
        let navigator = resolveNavigator(viewController: vc)
        let interactor = resolveInteractor()
        let vm: FinishViewModel = resolveViewModel(navigator: navigator, interactor: interactor)

        vc.bindViewModel(to: vm)
        return vc
    }

    func resolveViewModel(navigator: FinishNavigatorType, interactor: FinishInteractorType) -> FinishViewModel {
        return FinishViewModel(navigator: navigator, interactor: interactor)
    }
}

extension FinishAssembler where Self: DefaultAssembler {
    func resolveNavigator(viewController: UIViewController) -> FinishNavigatorType {
        return FinishNavigator(viewController: viewController, defaultAssembler: DefaultAssembler.shared)
    }

    func resolveInteractor() -> FinishInteractorType {
        return FinishInteractor(/*usecase: DefaultUseCaseAssembler.shared.resolve()*/)
    }
}
