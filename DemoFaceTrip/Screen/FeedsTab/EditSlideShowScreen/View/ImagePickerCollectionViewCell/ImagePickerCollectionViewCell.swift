//
//  ImagePickerCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 2/6/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class ImagePickerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerBtn: UIButton!
    @IBOutlet weak var checkedImage: UIImageView!
    var isPicked = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override var isSelected: Bool{
        didSet{
            
        }
    }
}
