//
//  ListChannelsAssembler.swift
//  DoctorTest
//
//  Created by tan vu on 7/22/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// TODO: PLease copy "ListChannelsAssembler" to protocol Assembler 
// and remove me after done

protocol ListChannelsAssembler {
    func resolveViewController() -> ListChannelsViewController
    func resolveViewModel(navigator: ListChannelsNavigatorType, interactor: ListChannelsInteractorType) -> ListChannelsViewModel
    func resolveNavigator(viewController: UIViewController) -> ListChannelsNavigatorType
    func resolveInteractor() -> ListChannelsInteractorType
}

extension ListChannelsAssembler {
    func resolveViewController() -> ListChannelsViewController {
        let vc = ListChannelsViewController.instantiate()
//        let navigator = resolveNavigator(viewController: vc)
//        let interactor = resolveInteractor()
//        let vm: ListChannelsViewModel = resolveViewModel(navigator: navigator, interactor: interactor)
//
//        vc.bindViewModel(to: vm)
        return vc
    }

    func resolveViewModel(navigator: ListChannelsNavigatorType, interactor: ListChannelsInteractorType) -> ListChannelsViewModel {
        return ListChannelsViewModel(navigator: navigator, interactor: interactor)
    }
}

extension ListChannelsAssembler where Self: DefaultAssembler {
    func resolveNavigator(viewController: UIViewController) -> ListChannelsNavigatorType {
        return ListChannelsNavigator(viewController: viewController, defaultAssembler: DefaultAssembler.shared)
    }

    func resolveInteractor() -> ListChannelsInteractorType {
        return ListChannelsInteractor(usecase: DefaultUseCaseAssembler.shared.resolve())
    }
}
