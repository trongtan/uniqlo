//
//  Assignment+Mapping.swift
//  Spinamic
//
//  Created by tan vu on 3/9/20.
//

import Foundation
import ObjectMapper

extension Assignment: Mappable {
    init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        id <- map["_id"]
        title <- map["title"]
        status <- map["status"]
        total_exercise <- map["total_exercise"]
    }
}
