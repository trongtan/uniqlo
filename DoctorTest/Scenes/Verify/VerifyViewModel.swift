//
//  VerifyViewModel.swift
//  DoctorTest
//
//  Created by tan vu on 8/2/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Then

class VerifyViewModel: ViewModelType {
    private let navigator: VerifyNavigatorType
    private let interactor: VerifyInteractorType

    init(navigator: VerifyNavigatorType, interactor: VerifyInteractorType) {
        self.navigator = navigator
        self.interactor = interactor
    }
    
    struct Input {
        let verifyTrigger: Driver<Void>
        let password: Driver<String>
        let dismissTrigger: Driver<Void>
    }
    
    struct Output {
        let verify: Driver<Void>
        let dismiss: Driver<Void>
        let error: Driver<Error>
    }
    
    func transform(_ input: VerifyViewModel.Input) -> VerifyViewModel.Output {
        let errorTracker = ErrorTracker()
        
        let verify = input.verifyTrigger
                 .withLatestFrom(input.password)
                 .flatMapLatest {
                     self.interactor.verifyServerConfig(password: $0)
                         .trackError(errorTracker)
                         .asDriverOnErrorJustComplete()
             }.do(onNext: { _ in
                 self.navigator.toServerConfig()
             })
        
        let dismiss: Driver<Void> = input.dismissTrigger.do(onNext: { _ in
            self.navigator.dismiss()
        })
        
        return Output(verify: verify,
                      dismiss: dismiss,
                      error: errorTracker.asDriver())
    }
}

extension VerifyViewModel {
    final class InputBuilder: Then {
        var verifyTrigger: Driver<Void> = Driver.empty()
        var password: Driver<String> = Driver.empty()
        var dismissTrigger: Driver<Void> = Driver.empty()
    }
}

extension VerifyViewModel.Input {
    init(builder: VerifyViewModel.InputBuilder) {
        self.init(verifyTrigger: builder.verifyTrigger,
                  password: builder.password,
                  dismissTrigger: builder.dismissTrigger)
    }
}
