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

protocol changeColorOfMenuViewHome {
    func changeColor()
}

class DetailViewController: BaseViewController {
    
    var tableIndexPathDetailView: IndexPath?
    var cellIndexPathPathDetailView: IndexPath?
    
    var delegate: changeColorOfMenuViewHome?
    var tableViewDetail: UITableView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var numReview: UILabel!
    @IBOutlet weak var bookingBtn: UIButton!
    
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var viewTabbar: UIView!
    @IBOutlet weak var contraintBottomMenuView: NSLayoutConstraint!
    @IBOutlet weak var buttonMenu: UIButton!
    
    @IBOutlet weak var imageBackgroud: UIImageView!
    var imageUrl: String!
    var currentSection = -1
    var expandedCells = Set<Int>()
    var type: catagoryType = .None
    var item: AnyObject?
    var isCoslap = false
    
    @IBOutlet weak var hiddenView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    
    var detailTour: DetailTour!
    var typeOfMenu: typeOfCategoryMenu = .None
    var typeMenu: String = ""
    var typeSubMenu: String = ""
    var idItem: Int = 0
    var idSubItem: Int = 0
    var cityName: String!
    
    var currentStatusBarStyle = UIStatusBarStyle.lightContent
    
    var grayView: MenuView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBackButton()
        addShareButton()
//        setColorForStatusBarWhenScrollUp()
        //init table view
        self.automaticallyAdjustsScrollViewInsets = false
        initTableView()
        
        // init custom navigation bar
//        initCustomNavigationBar()
        setWhiteColorForStatusBar()
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
        self.view.bringSubview(toFront: viewTabbar)
//        let url =  URL(string: imageUrl)
//        imageBackgroud.af_setImage(withURL: url!)
//        view.bringSubview(toFront: imageBackgroud)
        restDetailTour()
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setWhiteColorForStatusBar()
        setNonColorForStatusBar()
        //hiddenView.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        //            self.initCustomNavigationBar()
       
        DispatchQueue.main.async {
            
            self.setContentForBootView()
        }
        
        bookingBtn.layer.cornerRadius = bookingBtn.frame.width / 30
        bookingBtn.layer.shadowColor = UIColor.gray.cgColor
        bookingBtn.layer.shadowOffset = CGSize(width: 0.0,height: 5.0)
        bookingBtn.layer.shadowOpacity = 0.3
        bookingBtn.layer.shadowRadius = 1.0
        bookingBtn.layer.masksToBounds = false
        bookingBtn.layer.cornerRadius = 4.0
        tabBarController?.tabBar.isHidden = true
        

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return currentStatusBarStyle
        return UIStatusBarStyle.lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setRedColorForStatusBar()
//        removeCustomBar()
        setDefaultColorForStatusBar()
    }
    
    
    func restDetailTour() {
        RestDataManager.shareInstance.restDetailTour(urlForHome, action: "getdetail", idCity: 01, typeMenu: typeMenu, typeSubMenu: typeSubMenu, idItem: idItem, idSubItem: idSubItem, completionHanler: { [weak self](response: DetailTour?, error: NSError?) in
            
            guard let strongSelf = self else{return}
            if let data = response{
                strongSelf.detailTour = data
                if let price = strongSelf.detailTour.price{
                    strongSelf.price1.text = ("$\(price)")
                    strongSelf.price.text = "per person"
                    //strongSelf.imageBackgroud.isHidden = true
                    strongSelf.tableViewDetail.reloadData()
                    
                }
            }
        })
    }
   
    @IBAction func backBtn(_ sender: Any) {
//        delegate?.changeColor()
//        dismiss(animated: true, completion: nil)
        setRedColorForStatusBar()
        navigationController?.popViewController(animated: true)
    }
    
    func initTableView() {
        addContrailForTableView()
        tableViewDetail.delegate = self
        tableViewDetail.dataSource = self
        
        tableViewDetail.register(UINib.init(nibName: "CoverTableViewCell", bundle: nil), forCellReuseIdentifier: "CoverCell")
        
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
        
        let topConstraint = NSLayoutConstraint(item: self.tableViewDetail, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: -65)
        
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
        let vc = NewBookingViewController()
        if let data = detailTour{
            if let calendarBooking = data.calendarTour{
                vc.bookingDay = calendarBooking
            }
            if let nameCity = cityName{
                vc.nameCity = nameCity
            }
            if let nameTour = data.nameTour{
                vc.nameTour = nameTour
            }
            vc.statusTour = "Private tour, English"

        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showMenuDetail(_ sender: Any) {
        
//        let vc = MenuDetailViewController()
//        vc.modalPresentationStyle = .overFullScreen
//        vc.delegate = self
//        setDefaultColorForStatusBar()
//        self.present(vc, animated: true, completion: nil)
        
        
//        if let applicationDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate? {
//            if let window:UIWindow = applicationDelegate.window {
//        if let window = UIApplication.shared.keyWindow {
//            window.windowLevel = UIWindowLevelStatusBar + 1
//        }
        if grayView == nil{
            grayView = MenuView()
        }
//        statusBar.backgroundColor = .black
        
//        statusBar.alpha = 0.1
        grayView.delegate = self
        grayView.frame = UIScreen.main.bounds
//        grayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        navigationController?.view.addSubview(grayView)
        
//        let blueView:UIView = UIView(frame: UIScreen.main.bounds)
//        blueView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//
//        statusBar.addSubview(blueView)
        
        
//        let blueView = MenuView()
//        blueView.frame = UIScreen.main.bounds
//        blueView.backgroundColor?.withAlphaComponent(0.5)
//        blueView.backgroundColor = UIColor(white: 1, alpha: 0.5)
//        navigationController?.view.addSubview(blueView)
//        statusBar.addSubview(blueView)
        
//        let vc = MenuDetailViewController()
//        vc.modalPresentationStyle = .overFullScreen
//        vc.delegate = self
//        setDefaultColorForStatusBar()
//        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func hidenViewMenu(_ sender: Any) {
//        hiddenView.isHidden = true
    }
    
    func setNonColorForStatusBar(){
        statusBar.backgroundColor = .clear
        
        let backImg = UIImage(named: "back")
        let tintBackImg = backImg?.af_imageAspectScaled(toFit: CGSize(width: 20, height: 25)).withRenderingMode(.alwaysTemplate)
        self.backBtn.setImage(tintBackImg, for: .normal)
        self.backBtn.tintColor = UIColor.white

        let shareImg = UIImage(named: "share")
        let tintedShareBtnImage = shareImg?.af_imageAspectScaled(toFit: CGSize(width: 20, height: 20)).withRenderingMode(.alwaysTemplate)
        self.sharingBtn.setImage(tintedShareBtnImage, for: .normal)
        self.sharingBtn.tintColor = UIColor.white
//
//        viewTabbar.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        //        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
        
//        self.backBtn.tintColor = UIColor.white
//        self.sharingBtn.tintColor = UIColor.white
    }
    
    func setDefaultColorForStatusBar() {
        statusBar.backgroundColor = .white
        let backImg = UIImage(named: "back")
        let tintBackImg = backImg?.af_imageAspectScaled(toFit: CGSize(width: 20, height: 20)).withRenderingMode(.alwaysTemplate)
        self.backBtn.setImage(tintBackImg, for: .normal)
        self.backBtn.tintColor = UIColor.darkGray

        let shareImg = UIImage(named: "share")
        let tintedShareBtnImage = shareImg?.af_imageAspectScaled(toFit: CGSize(width: 20, height: 20)).withRenderingMode(.alwaysTemplate)
        self.sharingBtn.setImage(tintedShareBtnImage, for: .normal)
        self.sharingBtn.tintColor = UIColor.darkGray
//
//        viewTabbar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = UIColor.black
//        self.backBtn.tintColor = .black
//        self.sharingBtn.tintColor = .black
    }
    
    func addNotificationForDetail() {
        notificationCenter.addObserver(self, selector: #selector(pushToBookingDay), name: calendarPushtoBookingNotification, object: nil)
    }
    
    @objc func pushToBookingDay(notification: Notification) {
        let vc = NewBookingViewController()
        if let data = detailTour{
            if let calendarBooking = data.calendarTour{
                vc.bookingDay = calendarBooking
            }
            if let nameCity = cityName{
                vc.nameCity = nameCity
            }
            if let nameTour = data.nameTour{
                vc.nameTour = nameTour
            }
            vc.statusTour = "Private tour, English"
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        notificationCenter.removeObserver(self, name: calendarPushtoBookingNotification, object: nil)
    }
    
}


//extension DetailViewController: MeetingPointTableViewCellProtocol{
//    func presentMapView() {
//        let vc = MapViewViewController()
//        self.present(vc, animated: true, completion: nil)
//    }
//}
//
extension DetailViewController: MenuDetailProtocol{
    func scrollToItemAtIndexPath(indexPath: IndexPath) {
        hiddenView.isHidden = true
        tableViewDetail.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    func dismissMenuView() {
        statusBar.backgroundColor = .white
        statusBar.alpha = 1
        grayView.removeFromSuperview()
        grayView = nil
        hiddenView.isHidden = true
    }
}

extension DetailViewController: ImageExpandAnimationControllerProtocol {
    func getImageDestinationFrame() -> CGRect {
        view.layoutIfNeeded()
        let viewZero = HeaderZeroForDetail()
        return viewZero.imageBackgroud.frame
    }
}

extension DetailViewController: ImageShrinkAnimationControllerProtocol {
    func getInitialImageFrame() -> CGRect {
        let viewZero = HeaderZeroForDetail()
        return viewZero.imageBackgroud.frame
    }
}

