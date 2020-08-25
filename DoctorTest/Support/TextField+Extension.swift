//
//  TextField+Extension.swift
//  UNIQLO
//
//  Created by Tan Vu on 8/25/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func rxSetText(text: String) {
        self.text = text
        self.sendActions(for: .valueChanged)
    }
}
