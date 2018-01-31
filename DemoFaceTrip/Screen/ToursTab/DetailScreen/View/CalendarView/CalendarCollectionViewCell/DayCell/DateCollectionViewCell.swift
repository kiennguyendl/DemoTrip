//
//  DateCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/30/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

protocol DateCollectionViewCellProtocol {
    func presentBottomView()
    func dismissBottomView()
}

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var slashImg: UIImageView!
    
    var delegate: DateCollectionViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLbl.text = ""
        borderView.layer.borderColor = UIColor.clear.cgColor
        //dateLbl.textColor = UIColor.black
    }
}
