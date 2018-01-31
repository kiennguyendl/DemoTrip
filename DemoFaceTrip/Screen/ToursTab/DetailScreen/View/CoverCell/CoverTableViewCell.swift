//
//  CoverTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 12/5/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class CoverTableViewCell: UITableViewCell {

    @IBOutlet weak var coverNameOfTour: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
