//
//  DetailViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/11/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import ReadMoreTextView
import MapKit
import CoreLocation

class DetailViewController: BaseViewController {
    
    var tableViewDetail: UITableView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var numReview: UILabel!
    @IBOutlet weak var bookingBtn: UIButton!
    
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var contraintBottomMenuView: NSLayoutConstraint!
    @IBOutlet weak var buttonMenu: UIButton!
    
    var currentSection = -1
    var expandedCells = Set<Int>()
    var type: catagoryType = .None
    var item: AnyObject?
    var isCoslap = false
    
    @IBOutlet weak var hiddenView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //setColorForStatusBarWhenScrollUp()
        //init table view
        self.automaticallyAdjustsScrollViewInsets = false
        initTableView()
        
        // init custom navigation bar
        initCustomNavigationBar()
        
        //set content for bottom view
        setContentForBootView()
        
        addNotificationForDetail()
        
//        self.view.bringSubview(toFront: viewMenu)
        viewMenu.layer.cornerRadius = viewMenu.frame.width / 2
        viewMenu.layer.shadowColor = UIColor.gray.cgColor
        viewMenu.layer.shadowOpacity = 1
        viewMenu.layer.shadowOffset = CGSize.zero
        viewMenu.layer.shadowRadius = 1
        viewMenu.isHidden = true
//        viewMenu.frame.origin.y = self.view.frame.height
//        contraintBottomMenuView.constant = self.view.frame.height + viewMenu.frame.height
        hiddenView.isHidden = true
    }
    
    
    deinit {
        notificationCenter.removeObserver(self, name: calendarPushtoBookingNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setWhiteColorForStatusBar()
        //set shadow for booking button
        // init custom navigation bar
        DispatchQueue.main.async {
            self.initCustomNavigationBar()
            self.setContentForBootView()
        }
        
        bookingBtn.layer.cornerRadius = bookingBtn.frame.width / 30
        bookingBtn.layer.shadowColor = UIColor.gray.cgColor
        bookingBtn.layer.shadowOffset = CGSize(width: 0.0,height: 5.0)
        bookingBtn.layer.shadowOpacity = 0.7
        bookingBtn.layer.shadowRadius = 1.0
        bookingBtn.layer.masksToBounds = false
        bookingBtn.layer.cornerRadius = 4.0
        tabBarController?.tabBar.isHidden = true

    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        removeCustomBar()
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeCustomBar()
    }
    
    
   
    
    func initTableView() {
        addContrailForTableView()
        tableViewDetail.delegate = self
        tableViewDetail.dataSource = self
        
        tableViewDetail.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        
        tableViewDetail.register(UINib.init(nibName: "CalendarTableViewCell", bundle: nil), forCellReuseIdentifier: "CalendarCell")
        
        tableViewDetail.register(UINib.init(nibName: "NewMeetingPointTableViewCell", bundle: nil), forCellReuseIdentifier: "NewMeetingPointCell")
        
        tableViewDetail.register(UINib.init(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingCell")
        
        tableViewDetail.register(UINib.init(nibName: "ReviewsTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewsCell")
        tableViewDetail.backgroundColor = UIColor.clear
        tableViewDetail.showsVerticalScrollIndicator = false
        
//        tableViewDetail.contentInset = UIEdgeInsets.zero
//
//        tableViewDetail.scrollIndicatorInsets = UIEdgeInsets.zero
//
//        tableViewDetail.contentOffset = CGPoint(x: 0.0, y: 0.0)

    }
    
    func addContrailForTableView() {
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - self.bottomView.frame.height - self.lineView.frame.height)
        tableViewDetail = UITableView(frame: frame, style: .grouped)
        
        self.view.addSubview(tableViewDetail)
        
        let topConstraint = NSLayoutConstraint(item: self.tableViewDetail, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
        
        let leadingContraint = NSLayoutConstraint(item: self.tableViewDetail, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 1)
        
        let trailingConstraint = NSLayoutConstraint(item: self.tableViewDetail, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: self.tableViewDetail, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.lineView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([topConstraint, leadingContraint, trailingConstraint, bottomConstraint])
        
        
        
        tableViewDetail.translatesAutoresizingMaskIntoConstraints = false
        tableViewDetail.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableViewDetail.separatorStyle = .none
        tableViewDetail.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    
    func setContentForBootView() {
        switch type {
        case .attractionType:
            price.isHidden = true
            price1.isHidden = true
            if let item = item as? Attraction{
                if let title = item.name{
                        setTitleForNavigationBar(title: title)
                    }
                }
        case .cityTourType:
            price.isHidden = false
            price1.isHidden = false
                if let item = item as? CityTour{
                    if let title = item.tour{
                        setTitleForNavigationBar(title: title)
                    }
                    
                    if let priceTour = item.price{
                        price1.text = ("$\(priceTour)")
                        price.text = "per person"
                    }
                }
        case .experienceType:
            price.isHidden = false
            price1.isHidden = false
                if let item = item as? Experience{
                    if let title = item.experience{
                        setTitleForNavigationBar(title: title)
                    }
                    
                    if let priceTour = item.price{
                        price1.text = ("$\(priceTour)")
                        price.text = "per person"
                    }
                }
        case .foodTourType:
            price.isHidden = false
            price1.isHidden = false
                if let item = item as? FoodTour{
                    if let title = item.name{
                        setTitleForNavigationBar(title: title)
                    }
                    
                    if let priceTour = item.price{
                        price1.text = ("$\(priceTour)")
                        price.text = "per person"
                    }
                }
        case .hotelType:
            price.isHidden = false
            price1.isHidden = false
                if let item = item as? Hotel{
                    if let title = item.nameHotel{
                        setTitleForNavigationBar(title: title)
                    }
                    
                    if let priceTour = item.price{
                        price1.text = ("$\(priceTour)")
                        price.text = "per person"
                    }
                }
        case .localGuideType:
            price.isHidden = false
            price1.isHidden = false
                if let item = item as? LocalGuide{
                    if let title = item.nameGuide{
                        setTitleForNavigationBar(title: title)
                    }
                    
                    if let priceTour = item.price{
                        price1.text = ("$\(priceTour)")
                        price.text = "per person"
                    }
                }
        case .themParkType:
            price.isHidden = false
            price1.isHidden = false
                if let item = item as? ThemeParks{
                    if let title = item.name{
                        setTitleForNavigationBar(title: title)
                    }

                    if let priceTour = item.price{
                        price1.text = ("$\(priceTour)")
                        price.text = "per person"
                    }
                    
                }
        case .travelAgencyType:
            price.isHidden = true
            price1.isHidden = true
                if let item = item as? TravelAgency{
                    if let title = item.name{
                        setTitleForNavigationBar(title: title)
                    }

                }
        default:
            print("")
        }
    }
    
    @IBAction func bookingBtn(_ sender: Any) {
    }
    
    @IBAction func showMenuDetail(_ sender: Any) {
        
        let vc = MenuDetailViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func hidenViewMenu(_ sender: Any) {
        hiddenView.isHidden = true
    }
    
}


extension DetailViewController: MeetingPointTableViewCellProtocol{
    func presentMapView() {
        let vc = MapViewViewController()
        self.present(vc, animated: true, completion: nil)
    }
}

extension DetailViewController: MenuDetailProtocol{
    func scrollToItemAtIndexPath(indexPath: IndexPath) {
        tableViewDetail.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}

