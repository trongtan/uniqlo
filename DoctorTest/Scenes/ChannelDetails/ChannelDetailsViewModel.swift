//
//  ChannelDetailsViewModel.swift
//  DoctorTest
//
//  Created by tan vu on 7/23/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Then

class ChannelDetailsViewModel: ViewModelType {
    private let navigator: ChannelDetailsNavigatorType
    private let interactor: ChannelDetailsInteractorType

    init(navigator: ChannelDetailsNavigatorType, interactor: ChannelDetailsInteractorType) {
        self.navigator = navigator
        self.interactor = interactor
    }
  
    struct Input {
        let channel: Driver<Channel>
    }
    
    struct Output {
        let channelDetail: Driver<Channel>
    }
    
    func transform(_ input: ChannelDetailsViewModel.Input) -> ChannelDetailsViewModel.Output {
        
        let channelDetail = input.channel.flatMapLatest { channel in
            self.interactor
                .channelDetail(channel: channel)
                .asDriverOnErrorJustComplete()
        }
        
        return Output(channelDetail: channelDetail)
    }
}

extension ChannelDetailsViewModel {
    final class InputBuilder: Then {
        var channel: Driver<Channel> = Driver.empty()
    }
}

extension ChannelDetailsViewModel.Input {
    init(builder: ChannelDetailsViewModel.InputBuilder) {
        self.init(channel: builder.channel)
    }
}
