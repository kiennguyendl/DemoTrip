//
//  BookingTourViewControllerDelegate+DataSource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/3/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension BookingTourViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.startDateCache = startDate()
        self.endDateCache = endDate()
        
        guard self.startDateCache <= self.endDateCache else {
            fatalError("Start date cannot be later than end date.")
        }
        
        var firtDateOfStartMonth = self.calendar.dateComponents([.era, .year, .month], from: startDateCache)
        firtDateOfStartMonth.day = 1
        
        let dateFromDayOneComponents = self.calendar.date(from: firtDateOfStartMonth)!
        
        self.startOfMonthCache = dateFromDayOneComponents
        
        let today = Date()
        
        if (self.startDateCache ... self.endDateCache).contains(today){
            
            let distanceFromTodayComponents = self.calendar.dateComponents([.month, .day], from: self.startOfMonthCache, to: today)
            
            self.todayIndexPath = IndexPath(item: distanceFromTodayComponents.day!, section: distanceFromTodayComponents.month!)
            print("today: \(today) + today index: \(todayIndexPath!) + distanceFromTodayComponents.day: \(distanceFromTodayComponents.day!)")
        }
        
        
        return self.calendar.dateComponents([.month], from: startDateCache, to: endDateCache).month! + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var monthOffsetComponents = DateComponents()
        monthOffsetComponents.month = section;
        
        guard let correctMonthForSectionDate = self.calendar.date(byAdding: monthOffsetComponents, to: startOfMonthCache),
            let info = self.getMonthInfo(for: correctMonthForSectionDate) else { return 0 }
        
        monthInfoForSection[section] = info
        return 42
    }
    
    internal func getMonthInfo(for date: Date) -> (firstDay: Int, daysTotal: Int)? {
        
        var firstWeekdayOfMonthIndex    = self.calendar.component(.weekday, from: date)
        firstWeekdayOfMonthIndex        = firstWeekdayOfMonthIndex - 1 // firstWeekdayOfMonthIndex should be 0-Indexed
        firstWeekdayOfMonthIndex        = (firstWeekdayOfMonthIndex + 6) % 7 // push it modularly to take it back one day where the first day is Monday instead of Sunday
        
        guard let rangeOfDaysInMonth:Range<Int> = self.calendar.range(of: .day, in: .month, for: date) else { return nil }
        
        // the format of the range returned is (1..<32) so subtract the lower to get the absolute
        let numberOfDaysInMonth         = rangeOfDaysInMonth.upperBound - rangeOfDaysInMonth.lowerBound
        
        return (firstDay: firstWeekdayOfMonthIndex, daysTotal: numberOfDaysInMonth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingTourCell", for: indexPath) as! BookingCollectionViewCell
        
         guard let (firstDayIndex, numberOfDaysTotal) = monthInfoForSection[indexPath.section] else { return cell }
        
        
        let fromStartOfMonthIndexPath = IndexPath(item: indexPath.item - firstDayIndex, section: indexPath.section)
        let lastDayIndex = firstDayIndex + numberOfDaysTotal
        
        let today = Date()
        let month = self.calendar.component(.month, from: today)
        var year = self.calendar.component(.year, from: today)
        
        var monthForSection = month + indexPath.section - 1
        var yearForSection = year
        if monthForSection > 11{
            monthForSection -= 12
            yearForSection += 1
        }
        
        
        print("scroliingadsfdsafasdfasdfasdfadsfasfasfsd")
        
        if (firstDayIndex..<lastDayIndex).contains(indexPath.item) {
            
            cell.dateLbl.text = String(fromStartOfMonthIndexPath.item + 1)
            
            /*set color for day
             if day <= current day -> gray color
             else -> black color
             */
            let idx = todayIndexPath!
            if (indexPath.item <= idx.item + firstDayIndex) && ((month - 1) == monthForSection){
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
                            
                        }
                        
                    }else{
//                        if let indexPathSelected = self.indexPathSeclected{
//                            if indexPathSelected == indexPath{
//                                DispatchQueue.main.async {
//                                    cell.borderView.layer.cornerRadius = cell.borderView.frame.width / 2
//                                    cell.borderView.layer.borderWidth = 1
//                                    cell.borderView.layer.borderColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1).cgColor
//                                    cell.dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
//                                    cell.borderView.layer.masksToBounds = true
//                                    cell.slashImg.isHidden = true
//                                    cell.canSelect = true
//                                }
//                                cell.borderView.backgroundColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
//                                cell.dateLbl.textColor = UIColor.white
//                            }
//                        }else{
                            cell.dateLbl.textColor = UIColor.gray
                            cell.borderView.backgroundColor = UIColor.white
                            cell.slashImg.isHidden = false
                            cell.canSelect = false
                        }
//                    }
                }
                
            }
            
            
        }else{
            cell.dateLbl.text = ""
            cell.slashImg.isHidden = true
            cell.canSelect = false
            cell.borderView.backgroundColor = UIColor.white
        }
        
        
        
        cell.dateLbl.font = UIFont.boldSystemFont(ofSize: 15)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MonthHeader", for: indexPath) as! HeaderMonthCollectionReusableView
            
            //reusableview.frame = CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 50)
            //do other header related calls or settups
            let today = Date()
            let month = self.calendar.component(.month, from: today)
            var year = self.calendar.component(.year, from: today)
            
            var currentMonth = month + indexPath.section - 1
            if currentMonth > 11{
                currentMonth -= 12
                year += 1
                let monthName = DateFormatter().monthSymbols[currentMonth]
                reusableview.monthForSection.text = monthName + " \(year)"
            }else{
                let monthName = DateFormatter().monthSymbols[currentMonth]
                reusableview.monthForSection.text = monthName
            }
            return reusableview
            
            
        default:  fatalError("Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7 - 10
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BookingCollectionViewCell
        if cell.canSelect == true{
            
            if cell.isSelected == true {
                if cell.isChangedColor == false{
                    //self.indexPathSeclected = nil
                    cell.indexPathSelected = nil
                    collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
                    self.isShowing = true
                    //self.indexPathSeclected = indexPath
                    cell.indexPathSelected = indexPath
                }else{
                    self.isShowing = false
                    //self.indexPathSeclected = nil
                    cell.indexPathSelected = nil
                }
            }else{
                self.isShowing = false
                //self.indexPathSeclected = nil
                cell.indexPathSelected = nil
            }
        }else{
            self.isShowing = false
            //self.indexPathSeclected = nil
            cell.indexPathSelected = nil
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("check scroll")
        if self.isShowing{
                DispatchQueue.main.async {
                    self.presentView.frame.origin.y = self.view.frame.height - self.presentView.frame.height
                    self.bottomPresentView.constant = self.view.frame.height
                }
        }else{
                DispatchQueue.main.async {
                    self.presentView.frame.origin.y = self.view.frame.height
                    self.bottomPresentView.constant = self.view.frame.height + self.presentView.frame.height
                }
        }
    }

}
