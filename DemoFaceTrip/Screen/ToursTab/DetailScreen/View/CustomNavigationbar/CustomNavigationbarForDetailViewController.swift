//
//  CustomNavigationbarForDetailViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/25/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

class CustomNavigationbarForDetailViewController: BaseView {
    
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var centerView: UIView!
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var leadingContraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        title.text = "systemgroup.com.apple"
//        title.sizeToFit()
//
//        if self.title.frame.width >= self.centerView.frame.width{
//            
//            self.leadingContraint.constant = -self.title.frame.width
//            UIView.animate(withDuration: 8, delay: 0.5, options: .repeat, animations: {
//                self.title.frame.origin.x = self.frame.width
//                self.leadingContraint.constant = self.frame.width
//            }, completion: nil)
//        }else{
//            self.title.frame.origin.x = (self.centerView.frame.width / 2) - (self.title.frame.width / 2)
//            self.leadingContraint.constant = (self.centerView.frame.width / 2) - (self.title.frame.width / 2)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
    }
}
