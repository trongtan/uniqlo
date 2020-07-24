//
//  API+ChannelCategoryList.swift
//  DoctorTest
//
//  Created by tan vu on 7/23/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import RxCocoa
import Alamofire

extension API {
    func channelCategoryList(_ input: ChannelCategoryListInput) -> Observable<ChannelCategoryListOutput> {
        return request(input)
    }
}
// MARK: - Login
extension API {
    final class ChannelCategoryListInput: APIInput {
        init() {
            super.init(resource: .channelCategoryList,
                       parameters: nil,
                       requireAccessToken: false)
            
        }
    }

    final class ChannelCategoryListOutput: APIOutput {
        private(set) var channelCategoryList: [ChannelCategory]?

        override func mapping(map: Map) {
            super.mapping(map: map)
            channelCategoryList <- map["data_array"]
        }
    }
}

