//
//  HeaderMonthCollectionReusableView.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/2/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class HeaderMonthCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var monthForSection: UILabel!
    @IBOutlet weak var collectionviewDayOfWeek: UICollectionView!
    
    let dayOfWeek = ["Sun", "Mon", "Tu", "We", "Th", "Fr", "Sa"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionviewDayOfWeek.delegate = self
        collectionviewDayOfWeek.dataSource = self
        collectionviewDayOfWeek.register(UINib.init(nibName: "DayOfWeekCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DayOfWeekCell")
    }
    
}


extension HeaderMonthCollectionReusableView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 7
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayOfWeekCell", for: indexPath) as! DayOfWeekCollectionViewCell
        cell.dayWeek.text = dayOfWeek[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 7 - 10, height: collectionviewDayOfWeek.frame.height)
    }
}
