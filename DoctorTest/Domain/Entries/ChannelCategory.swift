//
//  ChannelCategoryList.swift
//  DoctorTest
//
//  Created by tan vu on 7/23/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation

struct ChannelCategory: Codable {
    var categoryIdx: String = ""
    var categoryName: String = ""
    var insDate: Date?
    
    static let allChannelType: ChannelCategory = ChannelCategory(categoryIdx: "", categoryName: "전체")
}
