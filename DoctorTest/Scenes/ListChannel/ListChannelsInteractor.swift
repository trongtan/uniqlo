//
//  ListChannelsInteractor.swift
//  DoctorTest
//
//  Created by tan vu on 7/22/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ListChannelsInteractorType: InteractorType {
    func getChannelCategoryList() -> Observable<[ChannelCategory]>
    func channelList(cateogoryIdx: String, pageNum: String) -> Observable<[Channel]>
}

struct ListChannelsInteractor: ListChannelsInteractorType {
     let usecase: NetworkUseCaseType
    
    func getChannelCategoryList() -> Observable<[ChannelCategory]> {
        return usecase.getChannelCategoryList()
    }
    
    func channelList(cateogoryIdx: String, pageNum: String) -> Observable<[Channel]> {
        if let memberIdx = UserDefaults.standard.value(forKey: "MemberIdx") as? String {
            return usecase.channelList(memberIdx: memberIdx, cateogoryIdx: cateogoryIdx, pageNum: pageNum)
        }
        return Observable.just([])
    }
}
