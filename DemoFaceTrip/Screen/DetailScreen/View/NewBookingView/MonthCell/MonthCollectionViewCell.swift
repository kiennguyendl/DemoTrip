//
//  MonthCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit



class MonthCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var monthCollectionView: UICollectionView!
    
    var selectedIndexPaths: IndexPath?
    var monthInfo: (firstDay:Int, daysTotal:Int)!
    var index: Int!
    var todayIndex: IndexPath!
    var month: Int!
    var year: Int!
    var isShow = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        monthCollectionView.register(UINib.init(nibName: "BookingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookingTourCell")

        notificationCenter.addObserver(self, selector: #selector(changeColorCell(notification:)), name: indexPathForCellSelected, object: nil)
        notificationCenter.addObserver(self, selector: #selector(changeColorOfOldIndex(notification:)), name: oldIndexPathForCellSelected, object: nil)
    }

    @objc func changeColorOfOldIndex(notification: NSNotification) {
        let oldIndexPath = notification.userInfo!["indexPath"] as! IndexPath
        if self.index == oldIndexPath.section{
            let cell = monthCollectionView.cellForItem(at: IndexPath(item: oldIndexPath.item, section: 0)) as! BookingCollectionViewCell
            cell.borderView.backgroundColor = UIColor.white
            cell.dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
        }
        
    }
    @objc func changeColorCell(notification: NSNotification) {
        let indexPath = notification.userInfo!["info"] as! IndexPath
        selectedIndexPaths = indexPath
    }

}

extension MonthCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingTourCell", for: indexPath) as! BookingCollectionViewCell


        guard let (firstDayIndex, numberOfDaysTotal) = monthInfoForSection[self.index] else { return cell }
        
        
        let fromStartOfMonthIndexPath = IndexPath(item: indexPath.item - firstDayIndex, section: indexPath.section)
        let lastDayIndex = firstDayIndex + numberOfDaysTotal
        
        let today = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: today)
        let year = calendar.component(.year, from: today)
        
        var monthForSection = month + self.index
        var yearForSection = year
        if monthForSection > 11{
            monthForSection -= 12
            yearForSection += 1
        }
        
        if (firstDayIndex..<lastDayIndex).contains(indexPath.item) {
            
            cell.dateLbl.text = String(fromStartOfMonthIndexPath.item + 1)
            
            /*set color for day
             if day <= current day -> gray color
             else -> black color
             */
            let idx = self.todayIndex
            if (indexPath.item <= (idx?.item)! + firstDayIndex) && ((month - 1) == monthForSection){
                cell.dateLbl.textColor = UIColor.gray
                cell.borderView.backgroundColor = UIColor.white
                cell.canSelect = false
            }else{
                /*
                 render day booking
                 */
                
                for daybooking in listBookingDay{
                    let dayBook = daybooking.day
                    let monthBook = daybooking.month
                    let yearBook = daybooking.year
                    
                    if dayBook! == (fromStartOfMonthIndexPath.item + 1) && (monthBook! - 1) == monthForSection && yearBook == yearForSection{
                        
                        DispatchQueue.main.async {
                            cell.borderView.layer.cornerRadius = cell.borderView.frame.width / 2
                            cell.borderView.layer.borderWidth = 1
                            cell.borderView.layer.borderColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1).cgColor
                            cell.dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
                            cell.borderView.layer.masksToBounds = true
                            cell.slashImg.isHidden = true
                            cell.canSelect = true
                            
                            if self.selectedIndexPaths?.item == indexPath.item && self.selectedIndexPaths?.section == self.index{

                                self.monthCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
                                cell.isChangedColor = false
                                cell.isSelected = true
                            }else{
                                
                            }
                            
                        }
                        
                    }else{
                        cell.dateLbl.textColor = UIColor.gray
                        cell.borderView.backgroundColor = UIColor.white
                        cell.slashImg.isHidden = false
                        cell.canSelect = false
                    }
                }
                
            }
            
            
        }else{
            cell.dateLbl.text = ""
            cell.slashImg.isHidden = true
            cell.canSelect = false
            cell.borderView.backgroundColor = UIColor.white
        }
        
        cell.dateLbl.font = UIFont.boldSystemFont(ofSize: 15)
        //cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7 - 10
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselected")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! BookingCollectionViewCell
        var indexPathSelected: IndexPath?
        
        if cell.canSelect == true{
            
            if cell.isSelected == true {
                if cell.isChangedColor == false{
                
                    self.isShow = true
                }else{
                    self.isShow = false
                }
            }else{
                self.isShow = false
            }
            
            
            indexPathSelected = IndexPath(item: indexPath.item, section: self.index)
            cell.indexPathSelected = indexPathSelected
            let info:[String: Any] = ["indexPath": indexPathSelected!, "canSelect": cell.canSelect, "isSHow": isShow]
            notificationCenter.post(name: indexPathNotification, object: nil, userInfo: info)
            
        }else{
            self.isShow = false
            indexPathSelected = IndexPath(item: indexPath.item, section: self.index)
            cell.indexPathSelected = indexPathSelected
            let info:[String: Any] = ["indexPath": indexPathSelected!, "canSelect": cell.canSelect, "isSHow": isShow]
            notificationCenter.post(name: indexPathNotification, object: nil, userInfo: info)
            
        }
    }
}
