//
//  NewBookingViewDelegate+DataSource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/8/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
extension NewBookingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthForCellCollection", for: indexPath) as! MonthCollectionViewCell
        //cell.delegate = self
        let today = Date()
        let monthNow = self.calendar.component(.month, from: today)
        var year = self.calendar.component(.year, from: today)
        
        var month = monthNow + indexPath.section
        if month > 12{
            month -= 12
            year += 1
        }
        
        var listBookingDayOfMonth: [TimeBooking] = []
        let index = bookingDay![indexPath.section]
        if let dayBookings = index.dayBookings{
            for day in dayBookings{
                let timeBooking = TimeBooking(day: day, month: index.month!, year: index.year!)
                listBookingDayOfMonth.append(timeBooking)
            }
        }
        
        cell.month = month
        cell.year = year
        cell.monthInfo = monthInfoForSection[indexPath.section]
        cell.index = indexPath.section
        cell.todayIndex = todayIndexPath
        cell.listBookingDayOfMonth = listBookingDayOfMonth
        return cell
    }
    
    
    //get month info
    internal func getMonthInfo(for date: Date) -> (firstDay: Int, daysTotal: Int)? {
        
        var firstWeekdayOfMonthIndex    = self.calendar.component(.weekday, from: date)
        firstWeekdayOfMonthIndex        = firstWeekdayOfMonthIndex - 1 // firstWeekdayOfMonthIndex should be 0-Indexed
        firstWeekdayOfMonthIndex        = (firstWeekdayOfMonthIndex + 6) % 7 // push it modularly to take it back one day where the first day is Monday instead of Sunday
        
        guard let rangeOfDaysInMonth:Range<Int> = self.calendar.range(of: .day, in: .month, for: date) else { return nil }
        
        // the format of the range returned is (1..<32) so subtract the lower to get the absolute
        let numberOfDaysInMonth         = rangeOfDaysInMonth.upperBound - rangeOfDaysInMonth.lowerBound
        
        return (firstDay: firstWeekdayOfMonthIndex, daysTotal: numberOfDaysInMonth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: monthCollectionView.frame.width, height: monthCollectionView.frame.width - (monthCollectionView.frame.width / 7))
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //collectionView.scrollToItem(at: selectedIndexPath!, at: .centeredHorizontally, animated: true)
        print(indexPath)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let selectedIndexPath = selectedIndexPath{
            let info:[String: IndexPath] = ["info": selectedIndexPath]
            notificationCenter.post(name: indexPathForCellSelected, object: nil, userInfo: info)
        }
        
        if isShowBottomView{
            DispatchQueue.main.async {
                self.presentBottomView()
            }
            
        }else{
            DispatchQueue.main.async {
                self.dismissBottomView()
            }
            
        }
        
    }
    
}
