//
//  HeaderItemView.swift
//  DoctorTest
//
//  Created by tan vu on 7/22/20.
//  Copyright © 2020 tan vu. All rights reserved.
//

import UIKit
import Nuke

class HeaderItemView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDateLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var itemCategoryLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    // MAKR: Common init
    private func commonInit() {
        Bundle.main.loadNibNamed("HeaderItemView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo:  topAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func displayChannel(channel: Channel) {
        itemCategoryLabel.text = channel.category
        likeLabel.text = channel.likeCnt
        commentLabel.text = channel.replyCnt
        itemNameLabel.text = channel.title
        itemDateLabel.text = channel.insDate
        
        if let url = URL(string: channel.imgPath) {
            let request = ImageRequest(
                url: url,
                processors: [ImageProcessors.Resize(size: itemImageView.bounds.size)],
                priority: .high
            )
            Nuke.loadImage(with: request, into: itemImageView)
        }
        
    }
}
