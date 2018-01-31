//
//  CityTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/10/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
