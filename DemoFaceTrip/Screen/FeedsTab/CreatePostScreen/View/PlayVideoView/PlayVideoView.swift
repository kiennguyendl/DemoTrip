//
//  PlayVideoView.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/1/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

class PlayVideoView: BaseView {
    @IBOutlet weak var pauseOrPlayBtn: UIButton!
    @IBOutlet weak var timeSlide: UISlider!
    @IBOutlet weak var displayTimeLbl: UILabel!
    @IBOutlet weak var speakerBtn: UIButton!
    @IBOutlet weak var expandBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
