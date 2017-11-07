//
//  BookingTourViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/2/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class BookingTourViewController: BaseViewController {
    
    @IBOutlet weak var bookingCollectionView: UICollectionView!
    
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet weak var bottomPresentView: NSLayoutConstraint!
    @IBOutlet weak var presentView: UIView!
    
    @IBOutlet weak var monthView: UIView!
    
    @IBOutlet weak var bottomContraintOfMonthView: NSLayoutConstraint!
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
    
    var monthInfoForSection = [Int:(firstDay:Int, daysTotal:Int)]()
    
    var isShowing = false
    var indexPathSeclected: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
 
        DispatchQueue.main.async {
            self.initCustomNavigationBar()
            self.setTitleForNavigationBar(title: "When do you want to go?")
        }
        
        chooseBtn.layer.cornerRadius = chooseBtn.frame.width / 15
        bookingCollectionView.delegate = self
        bookingCollectionView.dataSource = self
        bookingCollectionView.register(UINib.init(nibName: "BookingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookingTourCell")
        
        bookingCollectionView.register(UINib.init(nibName: "HeaderMonthCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MonthHeader")
        
        self.presentView.frame.origin.y = self.view.frame.height
        self.bottomPresentView.constant = self.view.frame.height - self.presentView.frame.height
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.initCustomNavigationBar()
            self.setTitleForNavigationBar(title: "When do you want to go?")
            self.customNavigationBar.rightView.isHidden = true
        }
        //self.presentView.frame = CGRect(x: 0, y: self.view.frame.maxX, width: self.view.frame.width, height: self.presentView.frame.height)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeCustomBar()
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
        
        dateComponents.month = 6
        let today = Date()
        
        let sixMonthFromNow = self.calendar.date(byAdding: dateComponents, to: today)!
        
        return sixMonthFromNow
        
    }
}


extension BookingTourViewController: DateCollectionViewCellProtocol{
    func presentBottomView() {
        UIView.animate(withDuration: 0.2, animations: {
            DispatchQueue.main.async {
                self.presentView.frame.origin.y = self.view.frame.height - self.presentView.frame.height
                self.bottomPresentView.constant = self.view.frame.height
            }
            
        })
    }
    
    func dismissBottomView() {
        
        UIView.animate(withDuration: 1, animations: {
            DispatchQueue.main.async {
                self.presentView.frame.origin.y = self.view.frame.height
                self.bottomPresentView.constant = self.view.frame.height + self.presentView.frame.height
            }
        })
        
    }
    
    
}

