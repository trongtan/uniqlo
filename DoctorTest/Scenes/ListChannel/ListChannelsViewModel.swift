//
//  ListChannelsViewModel.swift
//  DoctorTest
//
//  Created by tan vu on 7/22/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Then

class ListChannelsViewModel: ViewModelType {
    private let navigator: ListChannelsNavigatorType
    private let interactor: ListChannelsInteractorType
    
    init(navigator: ListChannelsNavigatorType, interactor: ListChannelsInteractorType) {
        self.navigator = navigator
        self.interactor = interactor
    }
    
    struct Input {
        let changeCategoryTrigger: Driver<ChannelCategory>
        let toChannelDetailTrigger: Driver<Channel>
        
    }
    
    struct Output {
        let channelCategories: Driver<[ChannelCategory]>
        let channels: Driver<[Channel]>
        let toChannelDetail: Driver<Void>
    }
    
    func transform(_ input: ListChannelsViewModel.Input) -> ListChannelsViewModel.Output {
        let channelCategories = Driver.just(())
            .flatMapLatest {
                self.interactor.getChannelCategoryList()
                    .asDriverOnErrorJustComplete()
        }
        
        let channels = Driver.merge(Driver.just(ChannelCategory.allChannelType), input.changeCategoryTrigger).flatMapLatest { channelCategory in
            self.interactor.channelList(cateogoryIdx: channelCategory.categoryIdx, pageNum: "1")
                .asDriverOnErrorJustComplete()
        }
        
        let toChannelDetail = input.toChannelDetailTrigger
            .do(onNext: { channel in
                self.navigator.toChannelDetail(channel: channel)
            })
            .mapToVoid()
        
        return Output(channelCategories: channelCategories,
                      channels: channels,
                      toChannelDetail: toChannelDetail)
    }
}

extension ListChannelsViewModel {
    final class InputBuilder: Then {
        var changeCategoryTrigger: Driver<ChannelCategory> = Driver.empty()
        var toChannelDetail: Driver<Channel> = Driver.empty()
    }
}

extension ListChannelsViewModel.Input {
    init(builder: ListChannelsViewModel.InputBuilder) {
        self.init(changeCategoryTrigger: builder.changeCategoryTrigger,
                  toChannelDetailTrigger: builder.toChannelDetail)
    }
}
