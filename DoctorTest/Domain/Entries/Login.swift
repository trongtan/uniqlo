//
//  Login.swift
//  DoctorTest
//
//  Created by tan vu on 7/21/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation

struct Login: Codable {
    var code: String = ""
    var codeMsg: String = ""
    var memberIdx: String?
    var memberId: String?
    var memberName: String?
    
//    private enum CodingKeys : String, CodingKey {
//        case code, codeMsg = "code_msg", memberIdx = "member_idx" , memberId = "member_id", memberName = "member_name"
//    }
    
    var isSuccess: Bool {
        code == "1000"
    }
}
