//
//  ChannelDetailsInteractor.swift
//  DoctorTest
//
//  Created by tan vu on 7/23/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ChannelDetailsInteractorType {
    func channelDetail(channel: Channel) -> Observable<Channel>
}

struct ChannelDetailsInteractor: ChannelDetailsInteractorType {
    let usecase: NetworkUseCaseType
    
    func channelDetail(channel: Channel) -> Observable<Channel> {
        if let memberIdx = UserDefaults.standard.value(forKey: "MemberIdx") as? String {
            return usecase.channelDetail(memberIdx: memberIdx, categoryIdx: channel.boardIdx)
        }
        return Observable.just(channel)
    }
    
}
