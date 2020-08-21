//
//  BarcodeReaderInteractor.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol BarcodeReaderInteractorType {
    func receipt(barcode: String) -> Observable<Receipt>
    func logout() -> Observable<Void>
    func validateReceiptCode(barcode: String) -> Observable<Bool>
    
}

struct BarcodeReaderInteractor: BarcodeReaderInteractorType {
    let usecase: NetworkUseCaseType
    
    func receipt(barcode: String) -> Observable<Receipt> {
        return usecase.receipt(barcode: barcode)
    }
    
    func logout() -> Observable<Void> {
        UserDefaults.standard.set(nil, forKey: Constants.Key.token)
        return Observable.just(())
    }
    
    func validateReceiptCode(barcode: String) -> Observable<Bool> {
        return Observable.create { observable -> Disposable in
            if barcode.count == Constants.Configs.receiptCodeLength {
                observable.onNext(true)
            } else {
                observable.onError(API.APIError.customError(localizeDescription: "Invalid receipt code."))
            }
            
            return Disposables.create()
        }
    }
}
