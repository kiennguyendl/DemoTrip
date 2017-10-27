//
//  HeaderView.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/5/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class HeaderView: BaseView{

    @IBOutlet weak var heightOfTargetView: NSLayoutConstraint!
    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var nameOfCarousel: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var leadingViewOfHeaderView: NSLayoutConstraint!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        //targetView.layer.cornerRadius = targetView.frame.width / 10
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
