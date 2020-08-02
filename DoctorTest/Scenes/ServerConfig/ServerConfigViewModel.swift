//
//  ServerConfigViewModel.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Then

class ServerConfigViewModel: ViewModelType {
    private let navigator: ServerConfigNavigatorType
    private let interactor: ServerConfigInteractorType
    
    init(navigator: ServerConfigNavigatorType, interactor: ServerConfigInteractorType) {
        self.navigator = navigator
        self.interactor = interactor
    }
    
    struct Input {
        let serverURLTrigger: Driver<String>
        let serverPortTrigger: Driver<String>
        let saveTrigger: Driver<Void>
    }
    
    struct Output {
        let save: Driver<Void>
        let error: Driver<Error>
    }
    
    func transform(_ input: ServerConfigViewModel.Input) -> ServerConfigViewModel.Output {
        let errorTracker = ErrorTracker()
        let info = Driver.combineLatest(input.serverURLTrigger, input.serverPortTrigger)
        let save = input.saveTrigger
            .withLatestFrom(info)
            .flatMapLatest {
                self.interactor.saveServerConfig(serverURL: $0.0, port: $0.1)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        .do(onNext: { _ in
            self.navigator.dismiss()
        })
        
        return Output(save: save, error: errorTracker.asDriver())
    }
}

extension ServerConfigViewModel {
    final class InputBuilder: Then {
        var serverURLTrigger: Driver<String> = Driver.empty()
        var serverPortTrigger: Driver<String> = Driver.empty()
        var saveTrigger: Driver<Void> = Driver.empty()
    }
}

extension ServerConfigViewModel.Input {
    init(builder: ServerConfigViewModel.InputBuilder) {
        self.init(serverURLTrigger: builder.serverURLTrigger,
                  serverPortTrigger: builder.serverPortTrigger,
                  saveTrigger: builder.saveTrigger)
    }
}
