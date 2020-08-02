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
        let personalCusTrigger: Driver<String>
        let companyCusTrigger: Driver<String>
        
        let backTrigger: Driver<Void>
        let submitTrigger: Driver<Void>
        let nextTrigger: Driver<Void>
        let backToFillTrigger: Driver<Void>
    }
    
    struct Output {
        let receipt: Driver<Receipt>
        let back: Driver<Void>
        let submit: Driver<Void>
        let preview: Driver<Bool>
        let previewEnable: Driver<Bool>
        let error: Driver<Error>
    }
    
    func transform(_ input: InformationViewModel.Input) -> InformationViewModel.Output {
        let errorTracker = ErrorTracker()
        
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
            input.noteTrigger,
            input.personalCusTrigger,
            input.companyCusTrigger
        )
        
        let info = Driver.combineLatest(infoFirst, infoSecond).map { tuble -> CustomerInfo in
            var type = tuble.1.4
            if type.isEmpty {
                type = tuble.1.5
            }
            
            return CustomerInfo(type: type, name: tuble.0.0, company: tuble.0.1, tax: tuble.0.2, address: tuble.0.3, state: tuble.0.4, city: tuble.0.5, phone: tuble.0.6, fax: tuble.0.7, email: tuble.1.0, bankName: tuble.1.1, bankAccount: tuble.1.2, note: tuble.1.3)
        }
        
        let previewEnable = Driver.merge( info.map { $0.isValid }, input.backToFillTrigger.map { false })
        
        let preview: Driver<Bool> = Driver.merge(Driver.just(false), input.nextTrigger.map { true }, input.backToFillTrigger.map { false })
        
        let submit: Driver<Void> = input.submitTrigger
            .withLatestFrom(info)
            .flatMapLatest {
                self.interactor.submitCustomerInfo(info: $0)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }.do(onNext: { _ in
            self.navigator.toFinishView()
        })
        
        return Output(receipt: receipt,
                      back: back,
                      submit: submit,
                      preview: preview,
                      previewEnable: previewEnable,
                      error: errorTracker.asDriver())
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
        var personalCusTrigger: Driver<String> = Driver.empty()
        var companyCusTrigger: Driver<String> = Driver.empty()
        var backTrigger: Driver<Void> = Driver.empty()
        var nextTrigger: Driver<Void> = Driver.empty()
        var submitTrigger: Driver<Void> = Driver.empty()
        var backToFillTrigger: Driver<Void> = Driver.empty()
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
                  personalCusTrigger: builder.personalCusTrigger,
                  companyCusTrigger: builder.companyCusTrigger,
                  backTrigger: builder.backTrigger,
                  submitTrigger: builder.submitTrigger,
                  nextTrigger: builder.nextTrigger,
                  backToFillTrigger: builder.backToFillTrigger)
    }
}
