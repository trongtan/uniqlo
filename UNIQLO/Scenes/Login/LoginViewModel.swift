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
import RxSwiftUtilities

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
        let configButtonTrigger: Driver<Void>
        let verifyServerConfigTrigger: Driver<Void>
        let serverConfigPassword: Driver<String>
        let dismissVerifyTrigger: Driver<Void>
    }
    
    struct Output {
        let login: Driver<Void>
        let loginEnable: Driver<Bool>
        let error: Driver<Error>
        let errorEmailVerification: Driver<Error>
        let verifyServerConfig: Driver<Void>
        let activityIndicator: Driver<Bool>
    }
    
    func transform(_ input: LoginViewModel.Input) -> LoginViewModel.Output {
        let errorTracker = ErrorTracker()
        let errorEmailVerificationTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
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
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
        }.do(onNext: { _ in
            self.navigator.toBarCodeReader()
        })
        
        let verifyServerConfig = input.configButtonTrigger.do(onNext: { _ in
            self.navigator.toVerifyServerConfig()
        })
        
        return Output(login: login,
                      loginEnable: loginEnable,
                      error: errorTracker.asDriver(),
                      errorEmailVerification: errorEmailVerificationTracker.asDriver(),
                      verifyServerConfig: verifyServerConfig,
                      activityIndicator: activityIndicator.asDriver())
    }
}

extension LoginViewModel {
    final class InputBuilder: Then {
        var emailTrigger: Driver<String> = Driver.empty()
        var passwordTrigger: Driver<String> = Driver.empty()
        var loginButtonTrigger: Driver<Void> = Driver.empty()
        var configButtonTrigger: Driver<Void> = Driver.empty()
        var verifyServerConfigTrigger: Driver<Void> = Driver.empty()
        var serverConfigPassword: Driver<String> = Driver.empty()
        var dismissVerifyTrigger: Driver<Void> = Driver.empty()
        
    }
}

extension LoginViewModel.Input {
    init(builder: LoginViewModel.InputBuilder) {
        self.init(emailTrigger: builder.emailTrigger,
                  passwordTrigger: builder.passwordTrigger,
                  loginButtonTrigger: builder.loginButtonTrigger,
                  configButtonTrigger: builder.configButtonTrigger,
                  verifyServerConfigTrigger: builder.verifyServerConfigTrigger,
                  serverConfigPassword: builder.serverConfigPassword,
                  dismissVerifyTrigger: builder.dismissVerifyTrigger)
    }
}
