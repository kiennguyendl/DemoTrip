//
//  HeaderIndicatorCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 12/14/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class HeaderIndicatorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var smallView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bigView.layer.cornerRadius = bigView.frame.size.width / 2
        bigView.layer.masksToBounds = false
//        bigView.backgroundColor = .red
        
        smallView.layer.cornerRadius = smallView.frame.size.width / 2
        smallView.layer.masksToBounds = false
//        smallView.backgroundColor = .blue
        self.layoutIfNeeded()
    }

}
