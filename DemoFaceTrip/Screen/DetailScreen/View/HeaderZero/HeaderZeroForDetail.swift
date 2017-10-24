//
//  HeaderZeroForDetail.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/24/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

class HeaderZeroForDetail: BaseView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    
    
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
