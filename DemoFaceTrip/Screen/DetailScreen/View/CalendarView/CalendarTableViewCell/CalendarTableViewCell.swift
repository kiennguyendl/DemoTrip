//
//  CalendarTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

var monthInfoForSection = [Int:(firstDay:Int, daysTotal:Int)]()

class CalendarTableViewCell: UITableViewCell{
    
    @IBOutlet weak var collectionViewCalendar: UICollectionView!
    @IBOutlet weak var headerSection: UICollectionView!
    @IBOutlet weak var lineView: UIView!

//    var dataSource  : CalendarViewDataSource?
//    var delegate    : CalendarViewDelegate?
    
    lazy var calendar : Calendar = {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.timeZone = TimeZone(abbreviation: "UTC")!
        return gregorian
    }()
    
    internal var startDateCache     = Date()
    internal var endDateCache       = Date()
    internal var startOfMonthCache  = Date()
    
    internal var todayIndexPath: IndexPath?
    public var displayDate: Date?
    
    internal(set) var selectedIndexPaths    = [IndexPath]()
    internal(set) var selectedDates         = [Date]()
    
   

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewCalendar.delegate = self
        collectionViewCalendar.dataSource = self
        collectionViewCalendar.register(UINib.init(nibName: "CalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalendarCollectionCell")
//        collectionViewCalendar.register(UINib.init(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
        
        headerSection.delegate = self
        headerSection.dataSource = self
        headerSection.register(UINib.init(nibName: "HeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderSection")
        
//        self.dataSource = self
//        self.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reloadData() {
        collectionViewCalendar.reloadData()
    }
    
    func startDate() -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.month = 0
        
        let today = Date()
        
        let threeMonthsAgo = self.calendar.date(byAdding: dateComponents, to: today)!
        
        return threeMonthsAgo
    }
    
    
    //get 6 month future
    func endDate() -> Date {
        
        var dateComponents = DateComponents()
        
        dateComponents.month = 5;
        let today = Date()
        
        let sixMonthFromNow = self.calendar.date(byAdding: dateComponents, to: today)!
        
        return sixMonthFromNow
        
    }
}

//extension CalendarTableViewCell: CalendarViewDataSource, CalendarViewDelegate
//{
//    //get current month
//    func startDate() -> Date {
//        
//        var dateComponents = DateComponents()
//        dateComponents.month = 0
//        
//        let today = Date()
//        
//        let threeMonthsAgo = self.calendar.date(byAdding: dateComponents, to: today)!
//        
//        return threeMonthsAgo
//    }
//    
//    
//    //get 6 month future
//    func endDate() -> Date {
//        
//        var dateComponents = DateComponents()
//        
//        dateComponents.month = 5;
//        let today = Date()
//        
//        let sixMonthFromNow = self.calendar.date(byAdding: dateComponents, to: today)!
//        
//        return sixMonthFromNow
//        
//    }
//}

