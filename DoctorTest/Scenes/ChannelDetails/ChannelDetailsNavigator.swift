//
//  ChannelDetailsNavigator.swift
//  DoctorTest
//
//  Created by tan vu on 7/23/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ChannelDetailsNavigatorType {
    
}

struct ChannelDetailsNavigator: ChannelDetailsNavigatorType {
    unowned let viewController: UIViewController
    unowned let defaultAssembler: Assembler

    var navigator: UINavigationController? {
        return viewController.navigationController
    }
}
