//
//  GradientCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 4/2/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class GradientCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewDisplayGradient: UIView!
//    var gradientsColor = [UIColor.cg](){
//        didSet{
//            DispatchQueue.main.async {
//                let gradientView = CAGradientLayer()
//                gradientView.frame = self.viewDisplayGradient.bounds
//                gradientView.colors = self.gradientsColor
//                self.viewDisplayGradient.layer.insertSublayer(gradientView, at: 0)
//            }
//            
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.viewDisplayGradient.layer.cornerRadius = self.viewDisplayGradient.frame.width / 2
            self.viewDisplayGradient.clipsToBounds = true
        }
        
    }

}
