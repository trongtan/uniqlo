//
//  ReponsiAssembler.swift
//  DemoCleanArchitecture-IOS
//
//  Created by TanVu on 4/2/19.
//  Copyright © 2019 TanVu. All rights reserved.
//

import Foundation

import UIKit

protocol RepositoriesAssembler: class,
    NetworkRepositoryAssembler
{
}

class DefaultRepositoriesAssembler: RepositoriesAssembler {
    static let shared = DefaultRepositoriesAssembler()
}

