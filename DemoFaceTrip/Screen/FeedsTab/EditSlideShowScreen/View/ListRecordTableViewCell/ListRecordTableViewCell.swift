//
//  ListRecordTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 4/17/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class ListRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var fileNameRecordLbl: UILabel!
    
    
    @IBOutlet weak var imageChecked: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
