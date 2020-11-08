//
//  BarcodeReaderViewModel.swift
//  Uniqlo
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Then
import RxSwiftUtilities

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
        let finishScanTrigger: Driver<Void>
    }
    
    struct Output {
        let next: Driver<Receipt>
        let logout: Driver<Void>
        let nextButtonEnable: Driver<Bool>
        let error: Driver<Error>
        let activityIndicator: Driver<Bool>
    }
    
    func transform(_ input: BarcodeReaderViewModel.Input) -> BarcodeReaderViewModel.Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let next = Driver.merge(input.nextButtonTrigger, input.finishScanTrigger)
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
                .trackActivity(activityIndicator)
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
                      error: errorTracker.asDriver(),
                      activityIndicator: activityIndicator.asDriver())
    }
}

extension BarcodeReaderViewModel {
    final class InputBuilder: Then {
        var barcodeTrigger: Driver<String> = Driver.empty()
        var nextButtonTrigger: Driver<Void> = Driver.empty()
        var logoutButtonTrigger: Driver<Void> = Driver.empty()
        var finishScanTrigger: Driver<Void> = Driver.empty()
    }
}

extension BarcodeReaderViewModel.Input {
    init(builder: BarcodeReaderViewModel.InputBuilder) {
        self.init(barcodeTrigger: builder.barcodeTrigger,
                  nextButtonTrigger: builder.nextButtonTrigger,
                  logoutButtonTrigger: builder.logoutButtonTrigger,
                  finishScanTrigger: builder.finishScanTrigger)
    }
}
