//
//  DetailViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/11/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import ReadMoreTextView

class DetailViewController: BaseViewController {
    
    var tableViewDetail: UITableView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var numReview: UILabel!
    @IBOutlet weak var bookingBtn: UIButton!
    
    //@IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    
    var currentSection = -1
    var expandedCells = Set<Int>()
    var type: catagoryType = .None
    var item: AnyObject?
    var isCoslap = false
    
    var customNavigationBar: CustomNavigationbarForDetailViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        //setColorForStatusBarWhenScrollUp()
        //init table view
        initTableView()
        
        // init custom navigation bar
        initCustomNavigationBar()
        
        //set content for bottom view
        setContentForBootView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setWhiteColorForStatusBar()
        //initBackButton()
        //addShareButton()

        //set shadow for booking button
        bookingBtn.layer.cornerRadius = bookingBtn.frame.width / 30
        bookingBtn.layer.shadowColor = UIColor.gray.cgColor
        bookingBtn.layer.shadowOffset = CGSize(width: 0.0,height: 5.0)
        bookingBtn.layer.shadowOpacity = 0.7
        bookingBtn.layer.shadowRadius = 1.0
        bookingBtn.layer.masksToBounds = false
        bookingBtn.layer.cornerRadius = 4.0
        tabBarController?.tabBar.isHidden = true
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        customNavigationBar.removeFromSuperview()
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    func initCustomNavigationBar(){
        customNavigationBar = CustomNavigationbarForDetailViewController(frame: CGRect(x: 0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: (navigationController?.navigationBar.frame.height)!))
        navigationController?.navigationBar.addSubview(customNavigationBar)
        customNavigationBar.backBtn.addTarget(self, action: #selector(backButtonTarget(sender:)), for: .touchUpInside)
        customNavigationBar.shareBtn.addTarget(customNavigationBar.leftView, action: #selector(shareButtonTarget(sender:)), for: .touchUpInside)
        
    }
    
    @objc func backButtonTarget(sender: UIButton) {
        setRedColorForStatusBar()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func shareButtonTarget(sender: UIButton) {
        print("sharing")
    }
    
    func initTableView() {
        addContrailForTableView()
        tableViewDetail.delegate = self
        tableViewDetail.dataSource = self
        
        tableViewDetail.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        
        tableViewDetail.register(UINib.init(nibName: "CalendarTableViewCell", bundle: nil), forCellReuseIdentifier: "CalendarCell")
        
        tableViewDetail.backgroundColor = UIColor.clear
        tableViewDetail.showsVerticalScrollIndicator = false
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
    
    func setTitleForNavigationBar(title: String) {
        customNavigationBar.title.text = title
        customNavigationBar.title.sizeToFit()
        if customNavigationBar.title.frame.width >= customNavigationBar.centerView.frame.width{
            
            customNavigationBar.leadingContraint.constant = -customNavigationBar.title.frame.width
            UIView.animate(withDuration: 8, delay: 0.5, options: .repeat, animations: {
                self.customNavigationBar.title.frame.origin.x = self.customNavigationBar.frame.width
                self.customNavigationBar.leadingContraint.constant = self.customNavigationBar.frame.width
            }, completion: nil)
        }else{
            customNavigationBar.title.frame.origin.x = (customNavigationBar.centerView.frame.width / 2) - (customNavigationBar.title.frame.width / 2)
            customNavigationBar.leadingContraint.constant = (customNavigationBar.centerView.frame.width / 2) - (customNavigationBar.title.frame.width / 2)
        }
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

}
