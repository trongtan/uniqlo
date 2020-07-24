//
//  Channel.swift
//  DoctorTest
//
//  Created by tan vu on 7/23/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation

struct Channel: Codable {
    var boardIdx: String = ""
    var boardType: String  = ""
    var insDate: String = ""
    var title: String = ""
    var imgPath: String = ""
    var replyCnt: String = ""
    var likeCnt: String = ""
    var myLikeYN: String = ""
    var category: String = ""
    var contentsYN: String = ""
    var contents: String?
}
