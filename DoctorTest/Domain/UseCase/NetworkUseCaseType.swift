//
//  AuthenUseCase.swift
//  DemoCleanArchitecture-IOS
//
//  Created by Tan Vu on 6/18/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkUseCaseType: UseCaseType {
    func login(email: String, password: String) ->  Observable<Bool>
    func receipt(barcode: String) -> Observable<Receipt>
    func submitCustomerInfo(info: Receipt) -> Observable<Void>
    func verifyServerConfig(password: String) -> Observable<Void>
}
