//
//  DetailTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/12/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import ReadMoreTextView

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: ReadMoreTextView!
    
    @IBOutlet weak var subView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let readMoreTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: UIColor(red: 13.0/255.0, green: 69.0/255.0, blue: 173.0/255.0, alpha: 1.0),
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        let readLessTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(red: 13.0/255.0, green: 69.0/255.0, blue: 173.0/255.0, alpha: 1.0),
            NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 14)
        ]
        //let readMore = "... Read more"
        
        textView.attributedReadMoreText = NSAttributedString(string: "... Show more", attributes: readMoreTextAttributes)
        textView.attributedReadLessText = NSAttributedString(string: "... Show less", attributes: readLessTextAttributes)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = ""
        textView.onSizeChange = { _ in }
        textView.shouldTrim = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.sizeToFit()
    }
    
}
