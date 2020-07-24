//
//  String+Extension.swift
//  Spinamic
//
//  Created by tan vu on 11/1/19.
//  Copyright © 2019 eru. All rights reserved.
//

import Foundation

extension String {
    func take(_ n: Int) -> String {
        guard n >= 0 else {
            fatalError("n should never negative")
        }
        let index = self.index(self.startIndex, offsetBy: min(n, self.count))
        return String(self[..<index])
    }
}
