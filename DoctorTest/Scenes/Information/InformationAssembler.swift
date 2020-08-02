//
//  InformationAssembler.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// TODO: PLease copy "InformationAssembler" to protocol Assembler 
// and remove me after done

protocol InformationAssembler {
    func resolveViewController(receipt: Receipt) -> InformationViewController
    func resolveViewModel(navigator: InformationNavigatorType, interactor: InformationInteractorType) -> InformationViewModel
    func resolveNavigator(viewController: UIViewController) -> InformationNavigatorType
    func resolveInteractor() -> InformationInteractorType
}

extension InformationAssembler {
    func resolveViewController(receipt: Receipt) -> InformationViewController {
        let vc = InformationViewController.instantiate()
        vc.receipt = receipt
        let navigator = resolveNavigator(viewController: vc)
        let interactor = resolveInteractor()
        let vm: InformationViewModel = resolveViewModel(navigator: navigator, interactor: interactor)

        vc.bindViewModel(to: vm)
        return vc
    }

    func resolveViewModel(navigator: InformationNavigatorType, interactor: InformationInteractorType) -> InformationViewModel {
        return InformationViewModel(navigator: navigator, interactor: interactor)
    }
}

extension InformationAssembler where Self: DefaultAssembler {
    func resolveNavigator(viewController: UIViewController) -> InformationNavigatorType {
        return InformationNavigator(viewController: viewController, defaultAssembler: DefaultAssembler.shared)
    }

    func resolveInteractor() -> InformationInteractorType {
        return InformationInteractor(usecase: NetworkUseCase.make() as! NetworkUseCaseType)
    }
}
