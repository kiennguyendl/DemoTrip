//
//  CalendarTableViewCell+Delegate+DataSource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/30/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

let NUMBER_OF_DAYS_IN_WEEK = 7
let MAXIMUM_NUMBER_OF_ROWS = 5

import UIKit

extension CalendarTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //guard let dataSource = self.dataSource else{return 0}
        
        self.startDateCache = startDate()
        self.endDateCache = endDate()
        
        guard self.startDateCache <= self.endDateCache else {
            fatalError("Start date cannot be later than end date.")
        }
        
        var firtDateOfStartMonth = self.calendar.dateComponents([.era, .year, .month], from: startDateCache)
        firtDateOfStartMonth.day = 1
        
        let dateFromDayOneComponents = self.calendar.date(from: firtDateOfStartMonth)!
        self.startDateCache = dateFromDayOneComponents
        
        let today = Date()
        
        if (self.startDateCache ... self.endDateCache).contains(today){
            
            let distanceFromTodayComponents = self.calendar.dateComponents([.month, .day], from: self.startOfMonthCache, to: today)
            
            self.todayIndexPath = IndexPath(item: distanceFromTodayComponents.day!, section: distanceFromTodayComponents.month!)
        }
        
        
        return self.calendar.dateComponents([.month], from: startDateCache, to: endDateCache).month! + 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerSection{
            return 1
        }else{
            var monthOffsetComponents = DateComponents()
            monthOffsetComponents.month = section;
            
            guard let correctMonthForSectionDate = self.calendar.date(byAdding: monthOffsetComponents, to: startOfMonthCache),
                let info = self.getMonthInfo(for: correctMonthForSectionDate) else { return 0 }
            
            monthInfoForSection[section] = info
            
                    return 1
//            return 42
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headerSection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderSection", for: indexPath) as! HeaderCollectionViewCell
            
            let today = Date()
            let month = self.calendar.component(.month, from: today)
            var year = self.calendar.component(.year, from: today)
            
            var currentMonth = month + indexPath.section - 1
            if currentMonth > 11{
                currentMonth -= 12
                year += 1
                let monthName = DateFormatter().monthSymbols[currentMonth]
                cell.monthLbl.text = monthName + " \(year)"
            }else{
                let monthName = DateFormatter().monthSymbols[currentMonth]
                cell.monthLbl.text = monthName
            }
            
            
            return cell
        }else{
            
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DateCollectionViewCell
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionCell", for: indexPath) as! CalendarCollectionViewCell

            cell.monthInfo = monthInfoForSection[indexPath.section]
            cell.index = indexPath.section

            let today = Date()
            let monthNow = self.calendar.component(.month, from: today)
            var year = self.calendar.component(.year, from: today)

            var month = monthNow + indexPath.section - 1
            if month > 11{
                month -= 12
                year += 1
            }
            cell.todayIndex = todayIndexPath
//            cell.dateLbl.text = "1"
            return cell
        }
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
        if collectionView == headerSection{
            return CGSize(width: headerSection.frame.width / 2, height: collectionView.frame.height)
        }else{
            return CGSize(width: collectionViewCalendar.frame.width / 2, height: collectionView.frame.height )
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.headerSection {
            let x: CGFloat = self.headerSection.contentOffset.x
            let y: CGFloat = 0
            let contentOfset: CGPoint = CGPoint(x: x, y: y)
            self.collectionViewCalendar.contentOffset = contentOfset
        }else if scrollView == self.collectionViewCalendar{
            let x: CGFloat = self.collectionViewCalendar.contentOffset.x
            let y: CGFloat = 0
            let contentOfset: CGPoint  = CGPoint(x: x, y: y)
            self.headerSection.contentOffset = contentOfset
        }
    }
    
}
