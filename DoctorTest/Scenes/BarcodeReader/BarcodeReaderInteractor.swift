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
}
