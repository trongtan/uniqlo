//
//  ChannelDetailsAssembler.swift
//  DoctorTest
//
//  Created by tan vu on 7/23/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// TODO: PLease copy "ChannelDetailsAssembler" to protocol Assembler 
// and remove me after done

protocol ChannelDetailsAssembler {
    func resolveViewController() -> ChannelDetailsViewController
    func resolveViewModel(navigator: ChannelDetailsNavigatorType, interactor: ChannelDetailsInteractorType) -> ChannelDetailsViewModel
    func resolveNavigator(viewController: UIViewController) -> ChannelDetailsNavigatorType
    func resolveInteractor() -> ChannelDetailsInteractorType
}

extension ChannelDetailsAssembler {
    func resolveViewController() -> ChannelDetailsViewController {
        let vc = ChannelDetailsViewController.instantiate()
//        let navigator = resolveNavigator(viewController: vc)
//        let interactor = resolveInteractor()
//        let vm: ChannelDetailsViewModel = resolveViewModel(navigator: navigator, interactor: interactor)
//
//        vc.bindViewModel(to: vm)
        return vc
    }

    func resolveViewModel(navigator: ChannelDetailsNavigatorType, interactor: ChannelDetailsInteractorType) -> ChannelDetailsViewModel {
        return ChannelDetailsViewModel(navigator: navigator, interactor: interactor)
    }
}

extension ChannelDetailsAssembler where Self: DefaultAssembler {
    func resolveNavigator(viewController: UIViewController) -> ChannelDetailsNavigatorType {
        return ChannelDetailsNavigator(viewController: viewController, defaultAssembler: DefaultAssembler.shared)
    }

    func resolveInteractor() -> ChannelDetailsInteractorType {
        return ChannelDetailsInteractor(usecase: DefaultUseCaseAssembler.shared.resolve())
    }
}
