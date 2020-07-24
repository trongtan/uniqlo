//
//  AuthenUseCase.swift
//  DemoCleanArchitecture-IOS
//
//  Created by Tan Vu on 6/18/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkUseCaseAssembler {
    func resolve() -> NetworkUseCaseType
}

protocol NetworkUseCaseType {
    func login(email: String, password: String) ->  Observable<Login>
    func getChannelCategoryList() -> Observable<[ChannelCategory]>
    func channelList(memberIdx: String, cateogoryIdx: String, pageNum: String) -> Observable<[Channel]>
    func channelDetail(memberIdx: String, categoryIdx: String) -> Observable<Channel>
}
