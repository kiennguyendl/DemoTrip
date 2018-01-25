//
//  FriendsCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/22/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    var viewBorder: CAShapeLayer!
    @IBOutlet weak var addBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        addBtn.layer.cornerRadius = 4
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        viewBorder = CAShapeLayer()
    }

    
}
