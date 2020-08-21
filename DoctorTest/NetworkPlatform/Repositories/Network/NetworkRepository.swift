//
//  AuthenRepository.swift
//  DemoCleanArchitecture-IOS
//
//  Created by Tan Vu on 6/18/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import RxSwift
import SwiftDate

protocol RepositoryType {
    static func make() -> RepositoryType
}

protocol NetworkRepositoryType: RepositoryType {
    func login(email: String, password: String) ->  Observable<Login?>
    func receipt(barcode: String) -> Observable<Receipt>
    func submitCustomerInfo(info: Receipt) -> Observable<Void>
    func verifyServerConfig(password: String) -> Observable<Void>
}

final class NetworkRepository: NetworkRepositoryType {
    static func make() -> RepositoryType {
        return NetworkRepository(api: API.shared)
    }
    
    private let api: API
    
    init(api: API) {
        self.api = api
    }
    
    func login(email: String, password: String) ->  Observable<Login?> {
        let input = API.LoginInput(email: email, password: password)
        return api.login(input).map { output -> Login in
            guard let login = output.login else {
                throw API.APIError.customError(localizeDescription: output.message)
            }
            return login
        }
    }
    
    func receipt(barcode: String) -> Observable<Receipt> {
        let input = API.ReceiptInput(barcode: barcode)
        return api.receipt(input).map { output -> Receipt in
            guard let receipt = output.receipt else {
                throw API.APIError.customError(localizeDescription: output.message)
            }
            return receipt
        }
    }
    
    func submitCustomerInfo(info: Receipt) -> Observable<Void> {
        let input = API.CustomerInfoInput(info: info)
        return api.submitCustomerInfo(input).map { output -> Void in
            guard let _ = output.isSuccess  else {
                throw API.APIError.invalidResponseData
            }
            return ()
        }
    }
    
    func verifyServerConfig(password: String) -> Observable<Void> {
        return Observable.create { observable in
            if password == Constants.Configs.defaultPassword {
                observable.onNext(())
            } else {
                observable.onError(API.APIError.customError(localizeDescription: "Vui lòng kiểm tra lại mật khẩu."))
            }

            return Disposables.create()
        }
    }
}
