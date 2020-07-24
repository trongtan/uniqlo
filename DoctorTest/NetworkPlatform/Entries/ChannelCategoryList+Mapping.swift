//
//  ChannelCategoryList+Mapping.swift
//  DoctorTest
//
//  Created by tan vu on 7/23/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation
import ObjectMapper

extension ChannelCategory: Mappable {
    init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        categoryIdx <- map["category_idx"]
        categoryName <- map["category_name"]
        insDate <- map["ins_date"]
    }
}
