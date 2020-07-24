//
//  Channel+Mapping.swift
//  DoctorTest
//
//  Created by tan vu on 7/23/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation
import ObjectMapper

extension Channel: Mappable {
    init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    mutating func mapping(map: Map) {
        boardIdx <- map["board_idx"]
        boardType <- map["board_type"]
        insDate <- map["ins_date"]
        title <- map["title"]
        imgPath <- map["img_path"]
        replyCnt <- map["reply_cnt"]
        likeCnt <- map["like_cnt"]
        myLikeYN <- map["my_like_yn"]
        category <- map["category"]
        contentsYN <- map["contents_yn"]
        contents <- map["contents"]
    }
}

