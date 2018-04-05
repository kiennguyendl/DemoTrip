//
//  ImageCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/23/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var gradient: CAGradientLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
