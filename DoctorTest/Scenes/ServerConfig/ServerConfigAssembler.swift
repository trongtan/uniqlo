//
//  ServerConfigAssembler.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// TODO: PLease copy "ServerConfigAssembler" to protocol Assembler 
// and remove me after done

protocol ServerConfigAssembler {
    func resolveViewController() -> ServerConfigViewController
    func resolveViewModel(navigator: ServerConfigNavigatorType, interactor: ServerConfigInteractorType) -> ServerConfigViewModel
    func resolveNavigator(viewController: UIViewController) -> ServerConfigNavigatorType
    func resolveInteractor() -> ServerConfigInteractorType
}

extension ServerConfigAssembler {
    func resolveViewController() -> ServerConfigViewController {
        let vc = ServerConfigViewController.instantiate()
        let navigator = resolveNavigator(viewController: vc)
        let interactor = resolveInteractor()
        let vm: ServerConfigViewModel = resolveViewModel(navigator: navigator, interactor: interactor)

        vc.bindViewModel(to: vm)
        return vc
    }

    func resolveViewModel(navigator: ServerConfigNavigatorType, interactor: ServerConfigInteractorType) -> ServerConfigViewModel {
        return ServerConfigViewModel(navigator: navigator, interactor: interactor)
    }
}

extension ServerConfigAssembler where Self: DefaultAssembler {
    func resolveNavigator(viewController: UIViewController) -> ServerConfigNavigatorType {
        return ServerConfigNavigator(viewController: viewController, defaultAssembler: DefaultAssembler.shared)
    }

    func resolveInteractor() -> ServerConfigInteractorType {
        return ServerConfigInteractor(/*usecase: DefaultUseCaseAssembler.shared.resolve()*/)
    }
}
