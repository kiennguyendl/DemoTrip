//
//  NewHomeCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/23/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import Cosmos
class NewHomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContents: UIView!
    //@IBOutlet weak var SuperView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var typeOfTour: UILabel!
    @IBOutlet weak var nameOfTour: UILabel!
    @IBOutlet weak var priceOfTour: UILabel!
    @IBOutlet weak var pointRating: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    
    @IBOutlet weak var imageViewYellow: UIImageView!
    @IBOutlet weak var persenLbl: UILabel!
    @IBOutlet weak var todayLbl: UILabel!
    @IBOutlet weak var decriptionLbl: UILabel!
    
    
    var isViewHiden = false
    override func awakeFromNib() {
        super.awakeFromNib()
        hidingView()
        
        image.layer.cornerRadius = image.frame.width / 80
        image.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //name.sizeToFit()
    }
    
    func hidingView() {
        imageViewYellow.isHidden = true
        persenLbl.isHidden = true
        todayLbl.isHidden = true
        decriptionLbl.isHidden = true
    }
    
    func displayView() {
        imageViewYellow.isHidden = false
        persenLbl.isHidden = false
        todayLbl.isHidden = false
        decriptionLbl.isHidden = false
    }

}
