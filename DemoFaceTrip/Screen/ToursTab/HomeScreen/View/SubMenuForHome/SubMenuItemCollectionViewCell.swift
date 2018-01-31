//
//  SubMenuItemCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/22/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class SubMenuItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet weak var nameSubMenu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewContents.backgroundColor = UIColor.clear
        self.viewContents.layer.borderWidth = 0.20
        self.viewContents.layer.borderColor = UIColor.lightGray.cgColor
        self.viewContents.layer.cornerRadius = self.frame.width / 60
        
        //self.viewContents.layer.shadowColor = UIColor.black.cgColor
        //self.viewContents.layer.shadowOffset = CGSize(width: 0,height: -0.5)
        //self.viewContents.layer.shadowOpacity = 0.5
        //self.viewContents.layer.shadowRadius = 1.0
        
        self.viewContents.layer.masksToBounds = true
        
    }

}
