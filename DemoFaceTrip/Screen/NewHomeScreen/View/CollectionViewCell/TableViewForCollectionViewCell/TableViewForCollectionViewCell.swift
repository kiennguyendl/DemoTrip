//
//  TableViewForCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/20/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class TableViewForCollectionViewCell: UICollectionViewCell {

    var tableViewCarousels: UITableView = UITableView(frame: CGRect.zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initTableView()
    }
    
    func initTableView() {
        addContrailForTableView()
        //tableViewCarousels.delegate = self
        //tableViewCarousels.dataSource = self
        //tableViewCarousels.register(UINib.init(nibName: "NewHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "NewHomeCell")
        //tableViewCarousels.showsHorizontalScrollIndicator = false
        //tableViewCarousels.showsVerticalScrollIndicator = false
//        tableViewCarousels.isHidden = false
//        tableViewCarousels.tag = 2
    }
    
    func addContrailForTableView() {
        
        let frame = self.frame
        tableViewCarousels = UITableView(frame: frame, style: .grouped)
        
        self.addSubview(tableViewCarousels)
        //        let dict = ["view": tableViewCarousels]
        //        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: dict)
        //        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: dict)
        //
        //        self.view.addConstraints(horizontalConstraints)
        //        self.view.addConstraints(verticalConstraints)
        
        let topConstraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        
        let leadingContraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        
        let trailingConstraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([topConstraint, leadingContraint, trailingConstraint, bottomConstraint])
        
        
        
        tableViewCarousels.translatesAutoresizingMaskIntoConstraints = false
        tableViewCarousels.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

//extension TableViewForCollectionViewCell: UITableViewDelegate, UITableViewDataSource{
//    
//
//}

