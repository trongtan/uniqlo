//
//  API+ChannelList.swift
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
    func channelList(_ input: ChannelListInput) -> Observable<ChannelListOutput> {
        return request(input)
    }
}
// MARK: - Login
extension API {
    final class ChannelListInput: APIInput {
        init(memberId: String, categoryIdx: String = "", pageNum: Int = 1) {
            let parameters: [String: Any] =
                         ["member_idx": memberId,
                          "page_num": pageNum,
                          "category_idx": categoryIdx,
                     ]
            
            super.init(resource: .channelList,
                       parameters: parameters,
                       requireAccessToken: false)
            
        }
    }

    final class ChannelListOutput: APIOutput {
        private(set) var channelList: [Channel]?

        override func mapping(map: Map) {
            super.mapping(map: map)
            channelList <- map["data_array"]
        }
    }
}


