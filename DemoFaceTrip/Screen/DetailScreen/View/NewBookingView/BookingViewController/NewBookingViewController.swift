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
    
    internal(set) var selectedIndexPath: IndexPath?
    var oldSelectedIndexPath: IndexPath?
    internal(set) var selectedDates         = [Date]()
    
    var monthInfoForSection = [Int:(firstDay:Int, daysTotal:Int)]()
    var isShowBottomView = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseBtn.layer.cornerRadius = chooseBtn.frame.width / 15
        
        DispatchQueue.main.async {
            self.initCustomNavigationBar()
            self.setTitleForNavigationBar(title: "When do you want to go?")
            self.customNavigationBar.rightView.isHidden = true
        }
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
        
        selectedIndexPath = indexPath
        
        if canSelect{
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
        DispatchQueue.main.async {
            self.initCustomNavigationBar()
            self.setTitleForNavigationBar(title: "When do you want to go?")
            self.customNavigationBar.rightView.isHidden = true
        }
        
        monthCollectionView.delegate = self
        monthCollectionView.dataSource = self
        monthCollectionView.register(UINib.init(nibName: "MonthCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MonthForCellCollection")
        
        monthCollectionView.register(UINib.init(nibName: "HeaderMonthCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MonthHeader")
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
    
    func presentBottomView() {
        UIView.animate(withDuration: 1, animations: {
            DispatchQueue.main.async {
                self.viewBottomBooking.frame.origin.y = self.view.frame.height - self.viewBottomBooking.frame.height
                self.bottomContraintView.constant = self.view.frame.height
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
}



