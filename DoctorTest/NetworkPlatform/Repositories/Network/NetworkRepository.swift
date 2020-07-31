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
                throw API.APIError.invalidResponseData
            }
            return login
        }
    }
}
