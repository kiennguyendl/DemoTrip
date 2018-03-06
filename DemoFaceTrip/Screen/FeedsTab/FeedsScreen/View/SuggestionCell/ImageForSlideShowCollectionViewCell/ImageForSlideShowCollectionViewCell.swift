//
//  ImageForSlideShowCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/29/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class ImageForSlideShowCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageBlurView: UIImageView!
    
    @IBOutlet weak var widthOfShowImageView: NSLayoutConstraint!
    @IBOutlet weak var showImageView: UIImageView!
    
    var scrollingTimer: Timer? = nil
    var blurEffectView: UIVisualEffectView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageBlurView.bounds
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageBlurView.addSubview(blurEffectView)
        
    }

}
