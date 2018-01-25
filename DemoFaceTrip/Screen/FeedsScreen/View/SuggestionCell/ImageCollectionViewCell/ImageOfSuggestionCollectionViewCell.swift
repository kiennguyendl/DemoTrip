//
//  ImageOfSuggestionCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/25/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class ImageOfSuggestionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewAllImgBtn: UIButton!
    @IBOutlet weak var buttonView: UIView!
    var blurEffectView: UIVisualEffectView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.alpha = 0.85
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
        
        let image = UIImage(named:"forwardBtn")
        
        viewAllImgBtn.setImage(image, for: .normal)
        viewAllImgBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: viewAllImgBtn.frame.width / 2, bottom: 0, right: 0)
        viewAllImgBtn.titleEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 15)
        viewAllImgBtn.setTitle("0", for: .normal)
        
        viewAllImgBtn.tintColor = .white
    }

}
