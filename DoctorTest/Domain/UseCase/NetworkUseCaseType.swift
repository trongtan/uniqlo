//
//  AuthenUseCase.swift
//  DemoCleanArchitecture-IOS
//
//  Created by Tan Vu on 6/18/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import RxSwift

//protocol NetworkUseCaseAssembler {
//    func resolve() -> NetworkUseCaseType
//}

protocol NetworkUseCaseType: UseCaseType {
    func login(email: String, password: String) ->  Observable<Login>
}
