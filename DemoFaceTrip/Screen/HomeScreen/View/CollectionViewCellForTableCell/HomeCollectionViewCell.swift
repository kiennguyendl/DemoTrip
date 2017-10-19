//
//  HomeCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/5/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var imageViewYellow: UIImageView!
    @IBOutlet weak var persenLbl: UILabel!
    @IBOutlet weak var todayLbl: UILabel!
    @IBOutlet weak var decriptionLbl: UILabel!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    var isViewHiden = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.contentView.translatesAutoresizingMaskIntoConstraints = false
        lbl1.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        name.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lbl2.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lbl3.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        imageViewYellow.image = UIImage(named: "yellow")?.af_imageAspectScaled(toFit: CGSize(width: imageViewYellow.frame.width + 10, height: imageViewYellow.frame.height + 10)).withRenderingMode(.alwaysOriginal)
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
