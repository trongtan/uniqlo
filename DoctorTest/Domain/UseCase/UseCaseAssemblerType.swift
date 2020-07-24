//
//  UseCaseAssembler.swift
//  DemoCleanArchitecture-IOS
//
//  Created by Tan Vu on 6/18/19.
//  Copyright © 2019 eru. All rights reserved.
//

protocol UseCaseAssembler: class,
    NetworkUseCaseAssembler {
}

class DefaultUseCaseAssembler: UseCaseAssembler {
    static let shared = DefaultUseCaseAssembler()
}
