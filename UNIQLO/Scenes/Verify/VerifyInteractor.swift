//
//  VerifyInteractor.swift
//  DoctorTest
//
//  Created by tan vu on 8/2/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol VerifyInteractorType {
    func verifyServerConfig(password: String) -> Observable<Void>
}

struct VerifyInteractor: VerifyInteractorType {
    let usecase: NetworkUseCaseType
    
    func verifyServerConfig(password: String) -> Observable<Void> {
        return usecase.verifyServerConfig(password: password)
    }
}
