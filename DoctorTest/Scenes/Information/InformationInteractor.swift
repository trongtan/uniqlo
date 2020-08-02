//
//  InformationInteractor.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol InformationInteractorType {
    func submitCustomerInfo(info: CustomerInfo) -> Observable<Void>
}

struct InformationInteractor: InformationInteractorType {
     let usecase: NetworkUseCaseType
    
    func submitCustomerInfo(info: CustomerInfo) -> Observable<Void> {
        return usecase.submitCustomerInfo(info: info)
    }
}