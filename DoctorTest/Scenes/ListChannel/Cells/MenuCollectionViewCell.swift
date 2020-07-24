//
//  MenuCollectionViewCell.swift
//  DoctorTest
//
//  Created by tan vu on 7/23/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.textColor = UIColor(hex: "#202020")
    }
    
    @IBOutlet weak var nameLabel: UILabel!
}
