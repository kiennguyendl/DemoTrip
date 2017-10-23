//
//  NewHomeTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/20/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class NewHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewForCell: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewForCell.dataSource = self
        collectionViewForCell.delegate = self
        collectionViewForCell.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
        collectionViewForCell.showsHorizontalScrollIndicator = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension NewHomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
        return cell
    }
    
    
}
