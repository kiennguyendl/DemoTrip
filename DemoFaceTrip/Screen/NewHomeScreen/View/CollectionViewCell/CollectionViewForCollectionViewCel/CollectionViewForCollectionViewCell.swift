//
//  CollectionViewForCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/20/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class CollectionViewForCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionViewContent: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initCollectionView() {
        collectionViewContent.delegate = self
        collectionViewContent.dataSource = self
        collectionViewContent.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
        collectionViewContent.showsHorizontalScrollIndicator = false
        collectionViewContent.showsVerticalScrollIndicator = false

    }

}

extension CollectionViewForCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
        return cell
    }
    
    
}
