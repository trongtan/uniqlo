//
//  FinishViewModel.swift
//  DoctorTest
//
//  Created by tan vu on 7/31/20.
//  Copyright (c) 2020 tan vu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Then

class FinishViewModel: ViewModelType {
    private let navigator: FinishNavigatorType
    private let interactor: FinishInteractorType

    init(navigator: FinishNavigatorType, interactor: FinishInteractorType) {
        self.navigator = navigator
        self.interactor = interactor
    }
  
    struct Input {
        let backTrigger: Driver<Void>
    }
    
    struct Output {
        let back: Driver<Void>
    }
    
    func transform(_ input: FinishViewModel.Input) -> FinishViewModel.Output {
        let back = input.backTrigger
            .do(onNext: { _ in
                self.navigator.backToBarCodeReader()
            })
        return Output(back: back)
    }
}

extension FinishViewModel {
    final class InputBuilder: Then {
        var backTrigger: Driver<Void> = Driver.empty()
    }
}

extension FinishViewModel.Input {
    init(builder: FinishViewModel.InputBuilder) {
        self.init(backTrigger: builder.backTrigger)
    }
}
