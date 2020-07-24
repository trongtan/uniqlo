//
//  TrainingDay.swift
//  Spinamic
//
//  Created by tan vu on 3/9/20.
//

import Foundation

struct TrainingDay: Codable {
    var day: Int = 0
    var id: String = ""
    var assignments: [Assignment] = []
    
    var dayString: String {
        switch day {
        case 0:
            return "SUN"
        case 1:
            return "MON"
        case 2:
            return "TUE"
        case 3:
            return "WED"
        case 4:
            return "THU"
        case 5:
            return "FIR"
        case 6:
            return "SAT"
        default:
            return ""
        }
    }
}
