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
    
    var rateStar: RateStar?{
        didSet{
            var fiveStar = 0
            var fourStar = 0
            var threeStar = 0
            var twoStar = 0
            var oneStar = 0
            var totalStar = 0
            
            if let rateStar = rateStar{
                if let five = rateStar.fiveStar{
                   fiveStar  = five
                    numRatinfFiveStars.text = "\(fiveStar)"
                }
                
                if let four = rateStar.fourStar{
                    fourStar = four
                    numRatingFourStars.text = "\(fourStar)"
                }
                
                if let three = rateStar.threeStar{
                    threeStar = three
                    numRatingThreeStars.text = "\(threeStar)"
                }
                
                if let two = rateStar.twoStar{
                    twoStar = two
                    numRatingTwoStars.text = "\(twoStar)"
                }
                
                if let one = rateStar.oneStar{
                    oneStar = one
                    numRatingOneStars.text = "\(oneStar)"
                }
            }
            
            totalStar = fiveStar + fourStar + threeStar + twoStar + oneStar
            widthOfFiveStar.constant = (viewStatusRating.frame.width * CGFloat(fiveStar)) / CGFloat(totalStar)
            widthOfFourStar.constant = (viewStatusRating.frame.width * CGFloat(fourStar)) / CGFloat(totalStar)
            widthOfThreeStar.constant = (viewStatusRating.frame.width * CGFloat(threeStar)) / CGFloat(totalStar)
            widthOfTwoStar.constant = (viewStatusRating.frame.width * CGFloat(twoStar)) / CGFloat(totalStar)
            widthOfOneStar.constant = (viewStatusRating.frame.width * CGFloat(oneStar)) / CGFloat(totalStar)
            
            
        }
    }
    @IBOutlet weak var viewStatusRating: UIView!

    @IBOutlet weak var widthOfFiveStar: NSLayoutConstraint!
    
    @IBOutlet weak var widthOfFourStar: NSLayoutConstraint!
    
    @IBOutlet weak var widthOfThreeStar: NSLayoutConstraint!
    
    @IBOutlet weak var widthOfOneStar: NSLayoutConstraint!
    
    @IBOutlet weak var widthOfTwoStar: NSLayoutConstraint!
    
    
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
