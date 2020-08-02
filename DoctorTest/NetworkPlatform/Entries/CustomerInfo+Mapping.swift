//
//  CustomerInfo+Mapping.swift
//  BaseProject
//
//  Created by tan vu on 8/1/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation
import ObjectMapper

extension CustomerInfo: Mappable {
    init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
    }
}


