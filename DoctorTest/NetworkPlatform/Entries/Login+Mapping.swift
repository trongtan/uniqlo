//
//  Login+Mapping.swift
//  DoctorTest
//
//  Created by tan vu on 7/21/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation
import ObjectMapper

extension Login: Mappable {
    init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        memberId <- map["member_id"]
        memberIdx <- map["member_idx"]
        memberName <- map["member_name"]
        codeMsg <- map["code_msg"]
        code <- map["code"]
    }
}
