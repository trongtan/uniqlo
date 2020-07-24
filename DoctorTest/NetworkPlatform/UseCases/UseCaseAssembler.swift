//
//  UseCaseProvider.swift
//  DemoCleanArchitecture-IOS
//
//  Created by Tan Vu on 6/18/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation

extension NetworkUseCaseAssembler {
    func resolve() -> NetworkUseCaseType {
        return NetworkUseCase(authenRepository: DefaultRepositoriesAssembler.shared.resolve())
    }
}

