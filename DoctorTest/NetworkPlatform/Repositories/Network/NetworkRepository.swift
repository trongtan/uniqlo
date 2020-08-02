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
    func submitCustomerInfo(info: CustomerInfo) -> Observable<Void>
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
        Observable.just(Login(code: "1000", codeMsg: "", memberIdx: "", memberId: "", memberName: ""))
//
//        let input = API.LoginInput(email: email, password: password)
//        return api.login(input).map { output -> Login in
//            guard let login = output.login else {
//                throw API.APIError.invalidResponseData
//            }
//            return login
//        }
    }
    
    func receipt(barcode: String) -> Observable<Receipt> {
        Observable.just(Receipt.fakeReceipt)
        //        let input = API.ReceiptInput(barcode: barcode)
        //        return api.receipt(input).map { output -> Receipt in
        //            guard let receipt = output.receipt else {
        //                throw API.APIError.invalidResponseData
        //            }
        //            return receipt
        //        }
    }
    
    func submitCustomerInfo(info: CustomerInfo) -> Observable<Void> {
        return Observable.just(())
        
        //        let input = API.CustomerInfoInput(info: info)
        //        return api.submitCustomerInfo(input).map { output -> Void in
        //            guard let isSuccess = output.isSuccess, isSuccess else {
        //                throw API.APIError.invalidResponseData
        //            }
        //            return ()
        //        }
    }
    
    func verifyServerConfig(password: String) -> Observable<Void> {
        return Observable.just(())
        
//        let input = API.ServerConfigInput(password: password)
//        return api.verifyServerConfig(input).map { output -> Void in
//            guard let isSuccess = output.isSuccess, isSuccess else {
//                throw API.APIError.invalidResponseData
//            }
//            return ()
//        }
    }
}
