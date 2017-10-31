//
//  CalendarCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var monthCollectionView: UICollectionView!
    
    var selectedIndexPaths    = [IndexPath]()
    var monthInfo: (firstDay:Int, daysTotal:Int)!
    var index: Int!
    var todayIndex: IndexPath!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        monthCollectionView.register(UINib.init(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
        // Initialization code
    }

}

extension CalendarCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DateCollectionViewCell
        
        guard let (firstDayIndex, numberOfDaysTotal) = monthInfoForSection[self.index] else { return cell }
        
        
        let fromStartOfMonthIndexPath = IndexPath(item: indexPath.item - firstDayIndex, section: indexPath.section)
        let lastDayIndex = firstDayIndex + numberOfDaysTotal
        
        if (firstDayIndex..<lastDayIndex).contains(indexPath.item) {
            
            cell.dateLbl.text = String(fromStartOfMonthIndexPath.item + 1)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width / 7 - 1
        let height = self.frame.height / 6 - 1
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DateCollectionViewCell
        //selectedIndexPaths.append(indexPath)
        //cell.isSelected = selectedIndexPaths.contains(indexPath)
    }
}
