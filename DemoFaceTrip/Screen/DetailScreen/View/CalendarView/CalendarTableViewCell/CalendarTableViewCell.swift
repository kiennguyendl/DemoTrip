//
//  CalendarTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

//var monthInfoForSection = [Int:(firstDay:Int, daysTotal:Int)]()


//var listBookingDay: [TimeBooking] = [TimeBooking(day: 5, month: 11, year: 2017),
//                                     TimeBooking(day: 7, month: 11, year: 2017),
//                                     TimeBooking(day: 11, month: 11, year: 2017),
//                                     TimeBooking(day: 16, month: 11, year: 2017),
//                                     TimeBooking(day: 17, month: 11, year: 2017),
//                                     TimeBooking(day: 23, month: 11, year: 2017),
//                                     TimeBooking(day: 24, month: 11, year: 2017),
//                                     TimeBooking(day: 25, month: 11, year: 2017),
//                                     TimeBooking(day: 29, month: 11, year: 2017),
//
//                                     TimeBooking(day: 5, month: 12, year: 2017),
//                                     TimeBooking(day: 7, month: 12, year: 2017),
//                                     TimeBooking(day: 11, month: 12, year: 2017),
//                                     TimeBooking(day: 16, month: 12, year: 2017),
//                                     TimeBooking(day: 17, month: 12, year: 2017),
//                                     TimeBooking(day: 23, month: 12, year: 2017),
//                                     TimeBooking(day: 24, month: 12, year: 2017),
//                                     TimeBooking(day: 25, month: 12, year: 2017),
//                                     TimeBooking(day: 29, month: 12, year: 2017),
//
//                                     TimeBooking(day: 5, month: 1, year: 2018),
//                                     TimeBooking(day: 7, month: 1, year: 2018),
//                                     TimeBooking(day: 11, month: 1, year: 2018),
//                                     TimeBooking(day: 16, month: 1, year: 2018),
//                                     TimeBooking(day: 17, month: 1, year: 2018),
//                                     TimeBooking(day: 23, month: 1, year: 2018),
//                                     TimeBooking(day: 24, month: 1, year: 2018),
//                                     TimeBooking(day: 25, month: 1, year: 2018),
//                                     TimeBooking(day: 29, month: 1, year: 2018),
//
//                                     TimeBooking(day: 5, month: 2, year: 2018),
//                                     TimeBooking(day: 7, month: 2, year: 2018),
//                                     TimeBooking(day: 11, month: 2, year: 2018),
//                                     TimeBooking(day: 16, month: 2, year: 2018),
//                                     TimeBooking(day: 17, month: 2, year: 2018),
//                                     TimeBooking(day: 23, month: 2, year: 2018),
//                                     TimeBooking(day: 24, month: 2, year: 2018),
//                                     TimeBooking(day: 25, month: 2, year: 2018),
//                                     TimeBooking(day: 28, month: 2, year: 2018),
//
//                                     TimeBooking(day: 5, month: 3, year: 2018),
//                                     TimeBooking(day: 7, month: 3, year: 2018),
//                                     TimeBooking(day: 11, month: 3, year: 2018),
//                                     TimeBooking(day: 16, month: 3, year: 2018),
//                                     TimeBooking(day: 17, month: 3, year: 2018),
//                                     TimeBooking(day: 23, month: 3, year: 2018),
//                                     TimeBooking(day: 24, month: 3, year: 2018),
//                                     TimeBooking(day: 25, month: 3, year: 2018),
//                                     TimeBooking(day: 29, month: 3, year: 2018),
//
//                                     TimeBooking(day: 5, month: 4, year: 2018),
//                                     TimeBooking(day: 7, month: 4, year: 2018),
//                                     TimeBooking(day: 11, month: 4, year: 2018),
//                                     TimeBooking(day: 16, month: 4, year: 2018),
//                                     TimeBooking(day: 17, month: 4, year: 2018),
//                                     TimeBooking(day: 23, month: 4, year: 2018),
//                                     TimeBooking(day: 24, month: 4, year: 2018),
//                                     TimeBooking(day: 25, month: 4, year: 2018),
//                                     TimeBooking(day: 29, month: 4, year: 2018),
//
//                                     TimeBooking(day: 5, month: 5, year: 2018),
//                                     TimeBooking(day: 7, month: 5, year: 2018),
//                                     TimeBooking(day: 11, month: 5, year: 2018),
//                                     TimeBooking(day: 16, month: 5, year: 2018),
//                                     TimeBooking(day: 17, month: 5, year: 2018),
//                                     TimeBooking(day: 23, month: 5, year: 2018),
//                                     TimeBooking(day: 24, month: 5, year: 2018),
//                                     TimeBooking(day: 25, month: 5, year: 2018),
//                                     TimeBooking(day: 29, month: 5, year: 2018)
//                                    ]


//protocol calendarProtocol {
//    func pushToBookingView(vc: UIViewController)
//}

class CalendarTableViewCell: UITableViewCell{
    
    @IBOutlet weak var collectionViewCalendar: UICollectionView!
    @IBOutlet weak var headerSection: UICollectionView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var calendarView: UIView!
    
    //var delegate: calendarProtocol?
    
    lazy var calendar : Calendar = {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.timeZone = TimeZone(abbreviation: "UTC")!
        return gregorian
    }()
//    var listBookingDay: [TimeBooking] = []
    //var bookingDay: [CalendarBooking] = []
    var monthInfoForSection = [Int:(firstDay:Int, daysTotal:Int)]()
    var bookingDay: [CalendarBooking]?{
        didSet{
            let today = Date()
            let month = self.calendar.component(.month, from: today)
            let year = self.calendar.component(.year, from: today)
            
            if var bookingDays = bookingDay{
                var listBooking:[CalendarBooking] = []
                for i in 0..<bookingDays.count{
                    if bookingDays[i].month! < month && bookingDays[i].year! == year{
                        
                    }else{
                        listBooking.append(bookingDays[i])
                    }
                }
                bookingDay = listBooking
            }
        }
        
    }
    
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
        
        headerSection.delegate = self
        headerSection.dataSource = self
        headerSection.register(UINib.init(nibName: "HeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderSection")
        
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
        
        let numMonthsAgo = self.calendar.date(byAdding: dateComponents, to: today)!
        
        return numMonthsAgo
    }
    
    
    //get 6 month future
    func endDate() -> Date {
        
        var dateComponents = DateComponents()
        if let bookingDay = bookingDay{
            dateComponents.month = bookingDay.count - 1
        }else{
            dateComponents.month = 0
        }
        
        let today = Date()
        
        let numMonthFromNow = self.calendar.date(byAdding: dateComponents, to: today)!
        
        return numMonthFromNow
        
    }
}


