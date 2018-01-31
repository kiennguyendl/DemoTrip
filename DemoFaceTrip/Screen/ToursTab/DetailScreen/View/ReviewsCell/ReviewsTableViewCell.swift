//
//  ReviewsTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/9/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import  ReadMoreTextView
import  Cosmos

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingStarsView: CosmosView!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var contentReview: ReadMoreTextView!
    
    @IBOutlet weak var authorLbl: UILabel!
    
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
        
        contentReview.attributedReadMoreText = NSAttributedString(string: "... Show more", attributes: readMoreTextAttributes)
        contentReview.attributedReadLessText = NSAttributedString(string: "... Show less", attributes: readLessTextAttributes)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentReview.text = ""
        contentReview.onSizeChange = { _ in }
        contentReview.shouldTrim = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentReview.sizeToFit()
    }
}
