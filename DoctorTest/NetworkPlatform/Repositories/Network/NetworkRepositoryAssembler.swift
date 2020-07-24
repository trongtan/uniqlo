//
//  AuthenRepositoryAssembler.swift
//  DemoCleanArchitecture-IOS
//
//  Created by Tan Vu on 6/18/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation

protocol NetworkRepositoryAssembler {
    func resolve() -> NetworkRepositoryType
}

extension NetworkRepositoryAssembler where Self: DefaultRepositoriesAssembler {
    func resolve() -> NetworkRepositoryType {
        return NetworkRepository(api: API.shared)
    }
}
