//
//  InformationViewModel.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Then
import RxSwiftUtilities

class InformationViewModel: ViewModelType {
    private let navigator: InformationNavigatorType
    private let interactor: InformationInteractorType
    
    init(navigator: InformationNavigatorType, interactor: InformationInteractorType) {
        self.navigator = navigator
        self.interactor = interactor
    }
    
    struct Input {
        let receiptTrigger: Driver<Receipt>
        let nameTrigger: Driver<String>
        let companyNameTrigger: Driver<String>
        let taxTrigger: Driver<String>
        let addressTrigger: Driver<String>
        let stateTrigger: Driver<String>
        let cityTrigger: Driver<String>
        let phoneTrigger: Driver<String>
        let faxTrigger: Driver<String>
        let emailTrigger: Driver<String>
        let bankNameTrigger: Driver<String>
        let bankAccountTrigger: Driver<String>
        let noteTrigger: Driver<String>
        
        let backTrigger: Driver<Void>
        let submitTrigger: Driver<Void>
        let nextTrigger: Driver<Void>
        let backToFillTrigger: Driver<Void>
        let personalButtonTrigger: Driver<Void>
        let businessButtonTrigger: Driver<Void>
    }
    
    struct Output {
        let receipt: Driver<Receipt>
        let back: Driver<Void>
        let submit: Driver<Void>
        let preview: Driver<Bool>
        let previewEnable: Driver<Bool>
        let error: Driver<Error>
        let activityIndicator: Driver<Bool>
        let isBusiness: Driver<Bool>
        let validateErrorMessage: Driver<String>
        let personalButton: Driver<Bool>
        let companyButton: Driver<Bool>
    }
    
    func transform(_ input: InformationViewModel.Input) -> InformationViewModel.Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let receipt: Driver<Receipt> = input.receiptTrigger
        
        let back: Driver<Void> = input.backTrigger.do(onNext: { _ in
            self.navigator.backToBarCodeReader()
        })
        
        let infoFirst = Driver.combineLatest(
            input.nameTrigger,
            input.companyNameTrigger,
            input.taxTrigger,
            input.addressTrigger,
            input.stateTrigger,
            input.cityTrigger,
            input.phoneTrigger,
            input.faxTrigger
        )
        
        let infoSecond = Driver.combineLatest(
            input.emailTrigger,
            input.bankNameTrigger,
            input.bankAccountTrigger,
            input.noteTrigger
        )

        let personalButton = input.personalButtonTrigger.map { false }.asDriver()
        let companyButton = input.businessButtonTrigger.map { true }.asDriver()

        let isBusiness = Driver.merge(input.receiptTrigger.map { $0.isBusiness },
                                      personalButton,
                                      companyButton)
        
        let info = Driver.combineLatest(receipt, infoFirst, infoSecond, isBusiness).map { tuble -> Receipt in
            var receipt = tuble.0
            receipt.isBusiness = tuble.3
            receipt.name = tuble.1.0
            receipt.legalName = tuble.1.1
            receipt.taxCode = tuble.1.2
            receipt.address = tuble.1.3
            receipt.district = tuble.1.4
            receipt.city = tuble.1.5
            receipt.phone = tuble.1.6
            receipt.fax = tuble.1.7
            receipt.email = tuble.2.0
            receipt.bankName = tuble.2.1
            receipt.bankAccount = tuble.2.2
            receipt.notes = tuble.2.3

            return receipt
        }

        let previewEnable = Driver.merge( info.map { $0.validate.isValid },
                                          input.backToFillTrigger.map { true })
        
        let preview: Driver<Bool> = Driver.merge(Driver.just(false), input.nextTrigger.map { true }, input.backToFillTrigger.map { false })
        
        let submit: Driver<Void> = input.submitTrigger
            .withLatestFrom(info)
            .flatMapLatest {
                self.interactor.submitCustomerInfo(info: $0)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
        }.do(onNext: { _ in
            self.navigator.backToBarCodeReader()
        })

        let validateErrorMessage = info.map { $0.validate.message }
        
        return Output(receipt: receipt,
                      back: back,
                      submit: submit,
                      preview: preview,
                      previewEnable: previewEnable,
                      error: errorTracker.asDriver(),
                      activityIndicator: activityIndicator.asDriver(),
                      isBusiness: isBusiness,
                      validateErrorMessage: validateErrorMessage,
                      personalButton: personalButton,
                      companyButton: companyButton)
    }
}

extension InformationViewModel {
    final class InputBuilder: Then {
        var receiptTrigger: Driver<Receipt> = Driver.empty()
        var nameTrigger: Driver<String> = Driver.empty()
        var companyNameTrigger: Driver<String> = Driver.empty()
        var taxTrigger: Driver<String> = Driver.empty()
        var addressTrigger: Driver<String> = Driver.empty()
        var stateTrigger: Driver<String> = Driver.empty()
        var cityTrigger: Driver<String> = Driver.empty()
        var phoneTrigger: Driver<String> = Driver.empty()
        var faxTrigger: Driver<String> = Driver.empty()
        var emailTrigger: Driver<String> = Driver.empty()
        var bankNameTrigger: Driver<String> = Driver.empty()
        var bankAccountTrigger: Driver<String> = Driver.empty()
        var noteTrigger: Driver<String> = Driver.empty()
        var backTrigger: Driver<Void> = Driver.empty()
        var nextTrigger: Driver<Void> = Driver.empty()
        var submitTrigger: Driver<Void> = Driver.empty()
        var backToFillTrigger: Driver<Void> = Driver.empty()
        var personalButtonTrigger: Driver<Void> = Driver.empty()
        var businessButtonTrigger: Driver<Void> = Driver.empty()
    }
}

extension InformationViewModel.Input {
    init(builder: InformationViewModel.InputBuilder) {
        self.init(receiptTrigger: builder.receiptTrigger,
                  nameTrigger: builder.nameTrigger,
                  companyNameTrigger: builder.companyNameTrigger,
                  taxTrigger: builder.taxTrigger,
                  addressTrigger: builder.addressTrigger,
                  stateTrigger: builder.stateTrigger,
                  cityTrigger: builder.cityTrigger,
                  phoneTrigger: builder.phoneTrigger,
                  faxTrigger: builder.faxTrigger,
                  emailTrigger: builder.emailTrigger,
                  bankNameTrigger: builder.bankNameTrigger,
                  bankAccountTrigger: builder.bankAccountTrigger,
                  noteTrigger: builder.noteTrigger,
                  backTrigger: builder.backTrigger,
                  submitTrigger: builder.submitTrigger,
                  nextTrigger: builder.nextTrigger,
                  backToFillTrigger: builder.backToFillTrigger,
                  personalButtonTrigger: builder.personalButtonTrigger,
                  businessButtonTrigger: builder.businessButtonTrigger)
    }
}
