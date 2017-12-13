//
//  NewBookingViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

//let notificationCenter = NotificationCenter.default



class NewBookingViewController: BaseViewController {

    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    @IBOutlet weak var viewBottomBooking: UIView!
    @IBOutlet weak var bottomContraintView: NSLayoutConstraint!
    
    @IBOutlet weak var daySelectedInfo: UILabel!
    var nameCity: String!
    var nameTour: String!
    var statusTour: String!
    
    lazy var calendar : Calendar = {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.timeZone = TimeZone(abbreviation: "UTC")!
        return gregorian
    }()
    
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
    var section: Int = 0
    
    internal var startDateCache     = Date()
    internal var endDateCache       = Date()
    internal var startOfMonthCache  = Date()
    
    internal var todayIndexPath: IndexPath?
    public var displayDate: Date?
    
    internal(set) var selectedIndexPath: IndexPath?
    internal(set) var daySelected: String!
    var oldSelectedIndexPath: IndexPath?
    internal(set) var selectedDates         = [Date]()
    
    var monthInfoForSection = [Int:(firstDay:Int, daysTotal:Int)]()
    
    var isShowBottomView = false
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackButton()
//        self.title = "When do you want to go?"
        chooseBtn.layer.cornerRadius = chooseBtn.frame.width / 30
        chooseBtn.layer.shadowColor = UIColor.gray.cgColor
        chooseBtn.layer.shadowOffset = CGSize(width: 0.0,height: 5.0)
        chooseBtn.layer.shadowOpacity = 0.3
        chooseBtn.layer.shadowRadius = 1.0
        chooseBtn.layer.masksToBounds = false
        chooseBtn.layer.cornerRadius = 4.0
        tabBarController?.tabBar.isHidden = true
        
//        DispatchQueue.main.async {
//            self.initCustomNavigationBar()
//            self.setTitleForNavigationBar(title: "When do you want to go?")
//            self.customNavigationBar.rightView.isHidden = true
//        }
        // Do any additional setup after loading the view.
        notificationCenter.addObserver(self, selector: #selector(getIndexPathSelected(notification:)), name: indexPathNotification, object: nil)
        
        self.viewBottomBooking.frame.origin.y = self.view.frame.height
        self.bottomContraintView.constant = self.view.frame.height + self.viewBottomBooking.frame.height
    }
    
    @objc func getIndexPathSelected(notification: NSNotification) {
        let indexPath = notification.userInfo!["indexPath"] as! IndexPath
        let canSelect = notification.userInfo!["canSelect"] as! Bool
        
        isShowBottomView = notification.userInfo!["isSHow"] as! Bool
        if let selectedIndexPath = selectedIndexPath{
            oldSelectedIndexPath = selectedIndexPath
            let info:[String: IndexPath] = ["indexPath": oldSelectedIndexPath!]
            notificationCenter.post(name: oldIndexPathForCellSelected, object: nil, userInfo: info)
        }
        
        self.selectedIndexPath = indexPath
        
        if canSelect{
            let daySelected = notification.userInfo!["daySelected"] as! String
            self.daySelected = daySelected
            if selectedIndexPath == oldSelectedIndexPath{
                if isShowBottomView{
                    
                    DispatchQueue.main.async {
                        self.presentBottomView()
                        self.isShowBottomView = true
                    }
                    self.presentBottomView()
                }else{
                    
                    dismissBottomView()
                    isShowBottomView = false
                }
                
            }else{
                DispatchQueue.main.async {
                    self.presentBottomView()
                }
                monthCollectionView.scrollToItem(at: IndexPath(item: 0, section: (selectedIndexPath?.section)!), at: .centeredVertically, animated: true)
                presentBottomView()
            }
        }else{
            dismissBottomView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "When do you want to go?"
        setWhiteColorForStatusBar()
//        DispatchQueue.main.async {
//            self.initCustomNavigationBar()
//            self.setTitleForNavigationBar(title: "When do you want to go?")
//            self.customNavigationBar.rightView.isHidden = true
//        }
        
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        monthCollectionView.register(UINib.init(nibName: "MonthCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MonthForCellCollection")
        
        monthCollectionView.register(UINib.init(nibName: "HeaderMonthCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MonthHeader")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        removeCustomBar()
        self.title = ""
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
    
    func presentBottomView() {
        UIView.animate(withDuration: 1, animations: {
            DispatchQueue.main.async {
                self.viewBottomBooking.frame.origin.y = self.view.frame.height - self.viewBottomBooking.frame.height
                self.bottomContraintView.constant = self.view.frame.height
                
                
                
                let today = Date()
                let month = self.calendar.component(.month, from: today)
                var year = self.calendar.component(.year, from: today)
                
                if let indexPath = self.selectedIndexPath{
                    var currentMonth = month + indexPath.section - 1
                    if currentMonth > 11{
                        currentMonth -= 12
                        year += 1
                        let monthName = DateFormatter().monthSymbols[currentMonth]
                        if let day = self.daySelected{
                            self.daySelectedInfo.text = "\(monthName) \(day) \(year)"
                        }
                        
                    }else{
                        let monthName = DateFormatter().monthSymbols[currentMonth]
                        if let day = self.daySelected{
                            self.daySelectedInfo.text = "\(monthName) \(day) \(year)"
                        }
                    }
                }
                
                
            }
            
        })
    }
    
    func dismissBottomView() {
        
        UIView.animate(withDuration: 1, animations: {
            DispatchQueue.main.async {
                self.viewBottomBooking.frame.origin.y = self.view.frame.height
                self.bottomContraintView.constant = self.view.frame.height + self.viewBottomBooking.frame.height
            }
        })
        
    }
    
    @IBAction func chooseBookingTourBtn(_ sender: Any) {
        let vc = BookingOptionsViewController()
        vc.nameCity = nameCity
        vc.nameTour = nameTour
        vc.statusTour = statusTour
        vc.daySelectedInfo = daySelectedInfo.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



