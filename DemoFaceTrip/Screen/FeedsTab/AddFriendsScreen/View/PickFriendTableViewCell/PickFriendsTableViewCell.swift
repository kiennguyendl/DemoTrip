//
//  PickFriendsTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 4/11/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class PickFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var nameFriendLbl: UILabel!
    @IBOutlet weak var pickedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
