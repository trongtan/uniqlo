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
        case dev = "http://192.168.1.225:8080"
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
                return (.post, "/api/login")
            case .receipt:
                return (.get, "/api/customer")
            case .information:
                return (.post, "/api/customer")
            case .networkConfig:
                return (.post, "login_v_1_0_0/member_login")
            case .verifyNetworkConfig:
                return (.post, "login_v_1_0_0/member_login")
            }
        }
    }
}
