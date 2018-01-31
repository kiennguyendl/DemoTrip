//
//  FriendCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/31/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
//    @IBOutlet weak var heightOfAvatar: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        heightOfAvatar.constant = self.frame.width
        
        //avatar.layer.cornerRadius = avatar.frame.width / 2
    }

}
