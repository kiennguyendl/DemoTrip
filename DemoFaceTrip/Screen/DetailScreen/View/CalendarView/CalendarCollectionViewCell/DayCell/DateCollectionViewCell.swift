//
//  DateCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/30/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var isToday : Bool = false {
        didSet {
            switch isToday {
            case true:
                self.borderView.backgroundColor =  UIColor.red
            case false:
                self.borderView.backgroundColor = UIColor.white
            }
        }
    }
    
    override var isSelected: Bool{
        didSet{
            switch isSelected {
            case true:
                //borderView.layer.borderWidth = 1
                //borderView.layer.borderColor = UIColor.blue
                borderView.backgroundColor = UIColor.blue
            case false:
                borderView.backgroundColor = UIColor.white
            }
        }
    }
}
