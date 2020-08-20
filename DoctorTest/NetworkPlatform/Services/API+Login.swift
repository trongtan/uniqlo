//
//  API+Login.swift
//  Spinamic
//
//  Created by tan vu on 3/9/20.
//

import Foundation
import RxSwift
import ObjectMapper
import RxCocoa
import Alamofire

extension API {
    func login(_ input: LoginInput) -> Observable<LoginOutput> {
        return request(input)
    }
}
// MARK: - Login
extension API {
    final class LoginInput: APIInput {
        init(email: String, password: String) {
            let parameters: [String: Any] =
                ["username": email,
                 "password": password,
                 "clientId": Constants.Configs.clientID
                ]
            
            super.init(resource: .login,
                       parameters: parameters,
                       requireAccessToken: false)
            
        }
    }

    final class LoginOutput: APIOutput {
        private(set) var login: Login?

        override func mapping(map: Map) {
            super.mapping(map: map)
            login = Login(map: map)
        }
    }
}
