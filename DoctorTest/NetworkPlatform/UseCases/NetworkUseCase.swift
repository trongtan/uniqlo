//
//  AuthenUseCase.swift
//  DemoCleanArchitecture-IOS
//
//  Created by Tan Vu on 6/18/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import RxSwift

class NetworkUseCase: NetworkUseCaseType {
    static func make() -> UseCaseType {
        return NetworkUseCase(networkRepository: NetworkRepository.make() as! NetworkRepositoryType)
    }
    
    
    private let networkRepository: NetworkRepositoryType
    private let disposeBag = DisposeBag()
    
    init(networkRepository: NetworkRepositoryType) {
        self.networkRepository = networkRepository
    }
    
    func login(email: String, password: String) -> Observable<Login> {
        return self.networkRepository.login(email: email, password: password).map { login -> Login in
            if let login = login, !login.isSuccess {
                throw NetworkError.loginFail(localizeDescription: login.codeMsg)
            }
            return login!
        }
    }
    
    func receipt(barcode: String) -> Observable<Receipt> {
        return self.networkRepository.receipt(barcode: barcode)
    }
    
    func submitCustomerInfo(info: CustomerInfo) -> Observable<Void> {
        return self.networkRepository.submitCustomerInfo(info: info)
    }
    
    func verifyServerConfig(password: String) -> Observable<Void> {
        return self.networkRepository.verifyServerConfig(password: password)
    }
}


extension NetworkUseCase {
    enum NetworkError: Error, CustomStringConvertible {
        case loginFail(localizeDescription: String)
        
        var description: String {
            switch self {
            case let .loginFail(localizeDescription):
                return localizeDescription
            }
        }
    }
}
