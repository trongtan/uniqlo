//
//  API+ChannelDetail.swift
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
    func channelDetail(_ input: ChannelDetailInput) -> Observable<ChannelDetailOutput> {
        return request(input)
    }
}
// MARK: - Login
extension API {
    final class ChannelDetailInput: APIInput {
        init(memberIdx: String, categoryIdx: String = "") {
            let parameters: [String: Any] =
                         ["member_idx": memberIdx,
                          "board_idx": categoryIdx,
                     ]
            
            super.init(resource: .channelDetail,
                       parameters: parameters,
                       requireAccessToken: false)
            
        }
    }

    final class ChannelDetailOutput: APIOutput {
        private(set) var channel: Channel?

        override func mapping(map: Map) {
            super.mapping(map: map)
            channel = Channel(map: map)
        }
    }
}


