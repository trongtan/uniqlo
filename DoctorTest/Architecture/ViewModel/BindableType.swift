//
//  BindableType.swift
//  DemoCleanArchitecture-IOS
//
//  Created by TanVu on 4/1/19.
//  Copyright © 2019 TanVu. All rights reserved.
//

import UIKit
import RxSwift

protocol BindableType: class {
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }

    func bindViewModel()
}

extension BindableType where Self: ViewController {
    func bindViewModel(to viewmodel: ViewModelType) {
        viewModel = viewmodel
        loadViewIfNeeded()
        bindViewModel()
    }
}
