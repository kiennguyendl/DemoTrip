//
//  RatingTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/9/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var FiveStarsView: UIView!
    @IBOutlet weak var FiveStarsSubView: UIView!
    @IBOutlet weak var numRatinfFiveStars: UILabel!
    
    @IBOutlet weak var FourStarsView: UIView!
    @IBOutlet weak var FourStarsSubView: UIView!
    @IBOutlet weak var numRatingFourStars: UILabel!
    
    @IBOutlet weak var ThreeStarsView: UIView!
    @IBOutlet weak var ThreeStarsSubView: UIView!
    @IBOutlet weak var numRatingThreeStars: UILabel!
    
    @IBOutlet weak var TwoStarsView: UIView!
    @IBOutlet weak var TwoStarsSubView: UIView!
    @IBOutlet weak var numRatingTwoStars: UILabel!
    
    @IBOutlet weak var OneStarsView: UIView!
    @IBOutlet weak var OneStarsSubView: UIView!
    
    @IBOutlet weak var numRatingOneStars: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Initialization code
        FiveStarsView.layer.cornerRadius = FiveStarsView.frame.width / 30
        FiveStarsView.layer.masksToBounds = true
        FiveStarsSubView.layer.cornerRadius = FiveStarsSubView.frame.width / 15
        
        FourStarsView.layer.cornerRadius = FourStarsView.frame.width / 30
        FourStarsView.layer.masksToBounds = true
        FourStarsSubView.layer.cornerRadius = FourStarsSubView.frame.width / 15
        
        ThreeStarsView.layer.cornerRadius = ThreeStarsView.frame.width / 30
        ThreeStarsView.layer.masksToBounds = true
        ThreeStarsSubView.layer.cornerRadius = ThreeStarsSubView.frame.width / 15
        
        TwoStarsView.layer.cornerRadius = TwoStarsView.frame.width / 30
        TwoStarsView.layer.masksToBounds = true
        TwoStarsSubView.layer.cornerRadius = TwoStarsSubView.frame.width / 15
        
        OneStarsView.layer.cornerRadius = OneStarsView.frame.width / 30
        OneStarsView.layer.masksToBounds = true
        OneStarsSubView.layer.cornerRadius = OneStarsSubView.frame.width / 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
