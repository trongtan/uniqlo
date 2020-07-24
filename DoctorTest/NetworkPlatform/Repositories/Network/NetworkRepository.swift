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

protocol NetworkRepositoryType {
    func login(email: String, password: String) ->  Observable<Login?>
    func getChannelCategoryList() -> Observable<[ChannelCategory]>
    func channelList(memberIdx: String, cateogoryIdx: String, pageNum: String) -> Observable<[Channel]>
    func channelDetail(memberIdx: String, categoryIdx: String) -> Observable<Channel>
}

final class NetworkRepository: NetworkRepositoryType {
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
    
    func getChannelCategoryList() -> Observable<[ChannelCategory]> {
        let input = API.ChannelCategoryListInput()
        return api.channelCategoryList(input).map { output -> [ChannelCategory] in
            guard let channelCategoryList = output.channelCategoryList else {
                throw API.APIError.invalidResponseData
            }
            return channelCategoryList
        }
    }
    
    func channelList(memberIdx: String, cateogoryIdx: String, pageNum: String) -> Observable<[Channel]> {
        let input = API.ChannelListInput(memberId: memberIdx, categoryIdx: cateogoryIdx, pageNum: Int(pageNum) ?? 1)
        return api.channelList(input).map { output -> [Channel] in
            guard let channelList = output.channelList else {
                throw API.APIError.invalidResponseData
            }
            return channelList
        }
    }
    
    func channelDetail(memberIdx: String, categoryIdx: String) -> Observable<Channel> {
        let input = API.ChannelDetailInput(memberIdx: memberIdx, categoryIdx: categoryIdx)
        return api.channelDetail(input).map { output -> Channel in
            guard let channel = output.channel else {
                 throw API.APIError.invalidResponseData
             }
             return channel
         }
    }
}
