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
        //TODO: Clear token
        
        return Observable.just(())
    }
    
    func validateReceiptCode(barcode: String) -> Observable<Bool> {
        return Observable.create { observable -> Disposable in
            if barcode.count == Constants.Configs.receiptCodeLength {
                observable.onNext(true)
            } else {
                observable.onError(NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid receipt code."]))
            }
            
            return Disposables.create()
        }
    }
}
