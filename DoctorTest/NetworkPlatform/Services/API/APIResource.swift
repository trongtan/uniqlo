//
//  APIResource.swift
//  DemoCleanArchitecture-IOS
//
//  Created by Tan Vu on 6/18/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import Alamofire

extension API {
    enum ServerURL: String {
        case dev = "http://dev-api.martjangbogo.com/"
    }
    
    enum APIResource {
        case login
        case receipt
        case information
        case networkConfig
        case verifyNetworkConfig

        
        var resource: (method: HTTPMethod, route: String) {
            switch self {
            case .login:
                return (.post, "login_v_1_0_0/member_login")
            case .receipt:
                return (.post, "login_v_1_0_0/member_login")
            case .information:
                return (.post, "login_v_1_0_0/member_login")
            case .networkConfig:
                return (.post, "login_v_1_0_0/member_login")
            case .verifyNetworkConfig:
                return (.post, "login_v_1_0_0/member_login")
            }
        }
    }
}
