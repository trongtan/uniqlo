//
//  LoginAssembler.swift
//  Spinamic
//
//  Created by tan vu on 3/9/20.
//  Copyright (c) 2020 . All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// TODO: PLease copy "LoginAssembler" to protocol Assembler 
// and remove me after done

protocol LoginAssembler {
    func resolveViewController() -> LoginViewController
    func resolveViewModel(navigator: LoginNavigatorType, interactor: LoginInteractorType) -> LoginViewModel
    func resolveNavigator(viewController: UIViewController) -> LoginNavigatorType
    func resolveInteractor() -> LoginInteractorType
}

extension LoginAssembler {
    func resolveViewController() -> LoginViewController {
        let vc = LoginViewController.instantiate()
//        let navigator = resolveNavigator(viewController: vc)
//        let interactor = resolveInteractor()
//        let vm: LoginViewModel = resolveViewModel(navigator: navigator, interactor: interactor)

//        vc.bindViewModel()
        return vc
    }

    func resolveViewModel(navigator: LoginNavigatorType, interactor: LoginInteractorType) -> LoginViewModel {
        return LoginViewModel(navigator: navigator, interactor: interactor)
    }
}

extension LoginAssembler where Self: DefaultAssembler {
    func resolveNavigator(viewController: UIViewController) -> LoginNavigatorType {
        return LoginNavigator(viewController: viewController, defaultAssembler: DefaultAssembler.shared)
    }

    func resolveInteractor() -> LoginInteractorType {
        return LoginInteractor(usecase: DefaultUseCaseAssembler.shared.resolve())
    }
}
