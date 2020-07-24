//
//  LoginViewModel.swift
//  Spinamic
//
//  Created by tan vu on 3/9/20.
//  Copyright (c) 2020 . All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Then

class LoginViewModel: ViewModelType {
    private let navigator: LoginNavigatorType
    private let interactor: LoginInteractorType

    init(navigator: LoginNavigatorType, interactor: LoginInteractorType) {
        self.navigator = navigator
        self.interactor = interactor
    }
    
    struct Input {
        let emailTrigger: Driver<String>
        let passwordTrigger: Driver<String>
        let loginButtonTrigger: Driver<Void>
    }
    
    struct Output {
        let login: Driver<Login>
        let loginEnable: Driver<Bool>
        let error: Driver<Error>
        let errorEmailVerification: Driver<Error>
    }
    
    func transform(_ input: LoginViewModel.Input) -> LoginViewModel.Output {
        let errorTracker = ErrorTracker()
        let errorEmailVerificationTracker = ErrorTracker()
        
        let emailPhoneValidation = input.emailTrigger
            .map {
                self.interactor.validateEmail(email: $0)
            }

        let passwordValidation = input.passwordTrigger
            .map {
                self.interactor.validatePassword(pass: $0)
            }
        
        let loginEnable = Driver
                .combineLatest(emailPhoneValidation, passwordValidation) {
                    $0.isValid && $1.isValid
                }
        
        let loginInfo = Driver.combineLatest(input.emailTrigger, input.passwordTrigger)
        
        let login = input.loginButtonTrigger
            .withLatestFrom(loginInfo)
            .flatMapLatest { email, password in
                self.interactor.login(email: email, password: password)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }.do(onNext: { _ in
            self.navigator.toListChannel()
        })
        
        return Output(login: login,
                      loginEnable: loginEnable,
                      error: errorTracker.asDriver(),
                      errorEmailVerification: errorEmailVerificationTracker.asDriver())
    }
}

extension LoginViewModel {
    final class InputBuilder: Then {
        var emailTrigger: Driver<String> = Driver.empty()
        var passwordTrigger: Driver<String> = Driver.empty()
        var loginButtonTrigger: Driver<Void> = Driver.empty()
    }
}

extension LoginViewModel.Input {
    init(builder: LoginViewModel.InputBuilder) {
        self.init(emailTrigger: builder.emailTrigger, passwordTrigger: builder.passwordTrigger, loginButtonTrigger: builder.loginButtonTrigger)
    }
}
