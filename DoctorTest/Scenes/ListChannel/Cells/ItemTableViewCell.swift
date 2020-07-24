//
//  ItemTableViewCell.swift
//  DoctorTest
//
//  Created by tan vu on 7/22/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import UIKit
import SnapKit

class ItemTableViewCell: UITableViewCell {
    var headerView: HeaderItemView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerView = HeaderItemView()
        self.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func setup(for channel: Channel) -> Void {
        headerView.displayChannel(channel: channel)
    }
}
