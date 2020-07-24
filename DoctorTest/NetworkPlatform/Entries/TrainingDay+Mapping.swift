//
//  TrainigDay+Mapping.swift
//  Spinamic
//
//  Created by tan vu on 3/9/20.
//

import Foundation
import ObjectMapper

extension TrainingDay: Mappable {
    init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        id <- map["_id"]
        day <- map["day"]
        assignments <- map["assignments"]
    }
}

