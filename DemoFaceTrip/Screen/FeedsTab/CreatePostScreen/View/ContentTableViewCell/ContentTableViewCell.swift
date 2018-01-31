//
//  ContentTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/31/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

protocol HeightForTextView {
    func heightOfTextView(height: CGFloat)
    
}
class ContentTableViewCell: UITableViewCell, UITextViewDelegate {

    var delgate:HeightForTextView?
    
    @IBOutlet weak var contentTextPost: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextPost.delegate = self
    }

    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth: CGFloat = contentTextPost.frame.size.width
        let newSize: CGSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        if let iuDelegate = self.delgate {
            
            iuDelegate.heightOfTextView(height: newSize.height)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentTextPost.text == "What's on your mind?"{
            contentTextPost.text = ""
            contentTextPost.textColor = .black
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
