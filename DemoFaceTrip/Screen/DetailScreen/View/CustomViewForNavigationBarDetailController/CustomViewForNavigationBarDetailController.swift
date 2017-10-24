//
//  CustomViewForNavigationBarDetailController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/24/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

class CustomViewForNavigationBarDetailController: BaseView{
    
    @IBOutlet weak var titleLbl: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
