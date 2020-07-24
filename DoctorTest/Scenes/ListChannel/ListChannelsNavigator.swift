//
//  ListChannelsNavigator.swift
//  DoctorTest
//
//  Created by tan vu on 7/22/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ListChannelsNavigatorType: NavigatorType {
    func toChannelDetail(channel: Channel)
}

struct ListChannelsNavigator: ListChannelsNavigatorType {
    unowned let viewController: UIViewController
    unowned let defaultAssembler: Assembler

    var navigator: UINavigationController? {
        return viewController.navigationController
    }
    
    func toChannelDetail(channel: Channel) {
        let vc: ChannelDetailsViewController = defaultAssembler.resolveViewController()
        vc.channel = channel
        navigator?.pushViewController(vc, animated: true)
    }
}
