//
//  AuthenUseCase.swift
//  DemoCleanArchitecture-IOS
//
//  Created by Tan Vu on 6/18/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation
import RxSwift

class NetworkUseCase: NetworkUseCaseType {
    
    private let networkRepository: NetworkRepositoryType
    
    init(authenRepository: NetworkRepositoryType) {
        self.networkRepository = authenRepository
    }
    
    func login(email: String, password: String) -> Observable<Login> {
        return self.networkRepository.login(email: email, password: password).map { login -> Login in
            if let login = login, !login.isSuccess {
                throw NetworkError.loginFail(localizeDescription: login.codeMsg)
            }
            return login!
        }
    }
    
    func getChannelCategoryList() -> Observable<[ChannelCategory]> {
        return self.networkRepository.getChannelCategoryList()
    }
    
    func channelList(memberIdx: String, cateogoryIdx: String, pageNum: String) -> Observable<[Channel]> {
        return self.networkRepository.channelList(memberIdx: memberIdx, cateogoryIdx: cateogoryIdx, pageNum: pageNum)
    }
    
    func channelDetail(memberIdx: String, categoryIdx: String) -> Observable<Channel> {
        return self.networkRepository.channelDetail(memberIdx: memberIdx, categoryIdx: categoryIdx)
    }
}


extension NetworkUseCase {
    enum NetworkError: Error, CustomStringConvertible {
        case loginFail(localizeDescription: String)
        
        var description: String {
            switch self {
            case let .loginFail(localizeDescription):
                return localizeDescription
            }
        }
    }
}
