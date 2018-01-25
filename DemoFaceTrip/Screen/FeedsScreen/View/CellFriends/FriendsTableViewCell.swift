//
//  FriendsTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/22/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendsCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        friendsCollectionView.delegate = self
        friendsCollectionView.dataSource = self
        friendsCollectionView.register(UINib.init(nibName: "FriendsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "friendsCollectionViewCell")
//        friendsCollectionView.register(UINib.init(nibName: "AddFeedsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "addFeedsCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FriendsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendsCollectionViewCell", for: indexPath) as! FriendsCollectionViewCell
        if indexPath.row == 0{
            cell.addBtn.isHidden = false
            setBorder(cell: cell, viewBorder: cell.viewBorder, isBorder: true)
        }else{
            cell.addBtn.isHidden = true
            setBorder(cell: cell, viewBorder: cell.viewBorder, isBorder: false)
            
        }
        return cell
    }
    func setBorder(cell: UICollectionViewCell, viewBorder: CAShapeLayer, isBorder: Bool) {
        if isBorder{
            viewBorder.path = UIBezierPath(roundedRect: cell.frame, cornerRadius: 10).cgPath
            viewBorder.strokeColor = UIColor.blue.cgColor
            viewBorder.lineDashPattern = [1, 1]
            viewBorder.frame = cell.frame
            viewBorder.fillColor = nil
            viewBorder.backgroundColor = nil
            cell.layer.addSublayer(viewBorder)
        }else{
            viewBorder.removeFromSuperlayer()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heigth = friendsCollectionView.frame.height
        let width = heigth - 10
        
        return CGSize(width: width, height: heigth)
    }
}
