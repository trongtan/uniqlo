//
//  BarcodeReaderViewModel.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Then

class BarcodeReaderViewModel: ViewModelType {
    private let navigator: BarcodeReaderNavigatorType
    private let interactor: BarcodeReaderInteractorType
    
    init(navigator: BarcodeReaderNavigatorType, interactor: BarcodeReaderInteractorType) {
        self.navigator = navigator
        self.interactor = interactor
    }
    
    struct Input {
        let barcodeTrigger: Driver<String>
        let nextButtonTrigger: Driver<Void>
        let logoutButtonTrigger: Driver<Void>
    }
    
    struct Output {
        let next: Driver<Receipt>
        let logout: Driver<Void>
        let nextButtonEnable: Driver<Bool>
        let error: Driver<Error>
    }
    
    func transform(_ input: BarcodeReaderViewModel.Input) -> BarcodeReaderViewModel.Output {
        let errorTracker = ErrorTracker()
        
        let next = input.nextButtonTrigger
            .withLatestFrom(input.barcodeTrigger)
            .flatMapLatest {
                self.interactor
                    .validateReceiptCode(barcode: $0)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        .withLatestFrom(input.barcodeTrigger)
        .flatMapLatest {
            self.interactor
                .receipt(barcode: $0)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        .do(onNext: { receipt in
            self.navigator.toFillInformationPage(with: receipt)
        })
        
        let nextButtonEnable = input.barcodeTrigger
            .map { !$0.isEmpty }
        
        let logout = input.logoutButtonTrigger.flatMapLatest {
            self.interactor
                .logout()
                .asDriverOnErrorJustComplete()
        }.do(onNext: { _ in
            self.navigator.backToLogin()
        })
        
        return Output(next: next,
                      logout: logout,
                      nextButtonEnable: nextButtonEnable,
                      error: errorTracker.asDriver())
    }
}

extension BarcodeReaderViewModel {
    final class InputBuilder: Then {
        var barcodeTrigger: Driver<String> = Driver.empty()
        var nextButtonTrigger: Driver<Void> = Driver.empty()
        var logoutButtonTrigger: Driver<Void> = Driver.empty()
    }
}

extension BarcodeReaderViewModel.Input {
    init(builder: BarcodeReaderViewModel.InputBuilder) {
        self.init(barcodeTrigger: builder.barcodeTrigger,
                  nextButtonTrigger: builder.nextButtonTrigger,
                  logoutButtonTrigger: builder.logoutButtonTrigger)
    }
}
