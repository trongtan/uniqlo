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
        case channelCategoryList
        case channelList
        case channelDetail

        
        var resource: (method: HTTPMethod, route: String) {
            switch self {
            case .login:
                return (.post, "login_v_1_0_0/member_login")
            case .channelCategoryList:
                return (.get, "board_v_1_0_0/channel_category_list")
            case .channelList:
                return (.post, "board_v_1_0_0/channel_list")
            case .channelDetail:
                return (.post, "board_v_1_0_0/channel_detail")
            }
        }
    }
}
