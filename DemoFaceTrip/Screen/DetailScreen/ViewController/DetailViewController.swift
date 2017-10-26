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
    @IBOutlet weak var numReview: UILabel!
    @IBOutlet weak var bookingBtn: UIButton!
    
    @IBOutlet weak var img1: UIImageView!
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
        bookingBtn.layer.shadowOpacity = 0.3
        bookingBtn.layer.shadowRadius = 1.0
        bookingBtn.layer.masksToBounds = false
        bookingBtn.layer.cornerRadius = 4.0
        tabBarController?.tabBar.isHidden = true
        
        
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    func initCustomNavigationBar(){
        customNavigationBar = CustomNavigationbarForDetailViewController(frame: CGRect(x: 0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: (navigationController?.navigationBar.frame.height)!))
        navigationController?.navigationBar.addSubview(customNavigationBar)
        customNavigationBar.backBtn.addTarget(self, action: #selector(backButtonTarget(sender:)), for: .touchUpInside)
        customNavigationBar.shareBtn.addTarget(self, action: #selector(shareButtonTarget(sender:)), for: .touchUpInside)
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
        tableViewDetail.backgroundColor = UIColor.clear
        tableViewDetail.showsVerticalScrollIndicator = false
    }
    
    func addContrailForTableView() {
        
        let frame = self.view.frame
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
            img1.image = #imageLiteral(resourceName: "place")
            img2.image = #imageLiteral(resourceName: "numbooking")
            if let item = item as? Attraction{
                if let title = item.name{
                        setTitleForNavigationBar(title: title)
                    }
                
                    if let place = item.place{
                        price.text = ("\(place)")
                    }
                    
                    if let reviewCount = item.numReview{
                        numReview.text = ("\(reviewCount) review")
                    }
                }
        case .cityTourType:
            img1.image = #imageLiteral(resourceName: "money")
            img2.image = #imageLiteral(resourceName: "numbooking")
                if let item = item as? CityTour{
                    if let title = item.tour{
                        setTitleForNavigationBar(title: title)
                    }
                    
                    if let priceTour = item.price{
                        price.text = ("\(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numPersonReview{
                        numReview.text = ("\(reviewCount) review")
                    }
                }
        case .experienceType:
            img1.image = #imageLiteral(resourceName: "money")
            img2.image = #imageLiteral(resourceName: "numbooking")
                if let item = item as? Experience{
                    if let title = item.experience{
                        setTitleForNavigationBar(title: title)
                    }
                    
                    if let priceTour = item.price{
                        price.text = ("\(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numPersonReview{
                        numReview.text = ("\(reviewCount) review")
                    }
                }
        case .foodTourType:
            img1.image = #imageLiteral(resourceName: "money")
            img2.image = #imageLiteral(resourceName: "numbooking")
                if let item = item as? FoodTour{
                    if let title = item.name{
                        setTitleForNavigationBar(title: title)
                    }
                    
                    if let priceTour = item.price{
                        price.text = ("\(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numReview{
                        numReview.text = ("\(reviewCount) review")
                    }
                }
        case .hotelType:
            img1.image = #imageLiteral(resourceName: "money")
            img2.image = #imageLiteral(resourceName: "numbooking")
                if let item = item as? Hotel{
                    if let title = item.nameHotel{
                        setTitleForNavigationBar(title: title)
                    }
                    
                    if let priceTour = item.price{
                        price.text = ("\(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numPersonReview{
                        numReview.text = ("\(reviewCount) review")
                    }
                }
        case .localGuideType:
            img1.image = #imageLiteral(resourceName: "money")
            img2.image = #imageLiteral(resourceName: "numlike")
                if let item = item as? LocalGuide{
                    if let title = item.nameGuide{
                        setTitleForNavigationBar(title: title)
                    }
                    
                    if let priceTour = item.price{
                        price.text = ("\(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numLike{
                        numReview.text = ("\(reviewCount) like")
                    }
                }
        case .themParkType:
            img1.image = #imageLiteral(resourceName: "money")
            img2.image = #imageLiteral(resourceName: "numbooking")
                if let item = item as? ThemeParks{
                    if let title = item.name{
                        setTitleForNavigationBar(title: title)
                    }

                    if let priceTour = item.price{
                        price.text = ("\(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numReview{
                        numReview.text = ("\(reviewCount) review")
                    }
                }
        case .travelAgencyType:
            img1.image = #imageLiteral(resourceName: "place")
            img2.image = #imageLiteral(resourceName: "numbooking")
                if let item = item as? TravelAgency{
                    if let title = item.name{
                        setTitleForNavigationBar(title: title)
                    }
                    
                    if let priceTour = item.place{
                        price.text = ("\(priceTour)")
                    }
                    
                    if let reviewCount = item.numReview{
                        numReview.text = ("\(reviewCount) review")
                    }
                }
        default:
            print("")
        }
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = indexPath.section
        if currentSection != 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
        
        if currentSection == 2{
            cell.subView.isHidden = true
        }
        switch type {
        case .attractionType:
            if let item = item as? Attraction{
                if currentSection == 1{
                    cell.textView.text = item.highlight
                }else{
                    cell.textView.text = item.descriptionAttraction
                }
            }
            break
        case .themParkType:
            if let item = item as? ThemeParks{
                if currentSection == 1{
                    cell.textView.text = item.highlight
                }else{
                    cell.textView.text = item.descriptionThemePark
                }
                
            }
            break
        case .localGuideType:
            if let item = item as? LocalGuide{
                if currentSection == 1{
                    cell.textView.text = item.aboutTour
                    cell.textView.textColor = UIColor.black
                }else{
                    cell.textView.text = item.descriptionGuide
                }
            }
            break
        case .hotelType:
            if let item = item as? Hotel{
                if currentSection == 1{
                    cell.textView.text = item.highlight
                }else{
                    cell.textView.text = item.descriptionHotel
                }
            }
            break
        case .experienceType:
            if let item = item as? Experience{
                if currentSection == 1{
                    cell.textView.text = item.highlight
                }else{
                cell.textView.text = item.descriptionExp
                }
            }
            break
        case .foodTourType:
            if let item = item as? FoodTour{
                if currentSection == 1{
                    cell.textView.text = item.highlight
                }else{
                    cell.textView.text = item.descriptionTour
                }
            }
            break
        case .cityTourType:
            if let item = item as? CityTour{
                if currentSection == 1{
                    cell.textView.text = item.highlight
                }else{
                    cell.textView.text = item.descriptionTour
                }
            }
            break
        case .travelAgencyType:
            if let item = item as? TravelAgency{
                if currentSection == 1{
                    cell.textView.text = item.contact
                }else{
                    cell.textView.text = item.descriptionAgency
                }
            }
        default:
            print("")
        }
        //cell.textView.textColor = UIColor.black
        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        readMoreTextView.shouldTrim = !expandedCells.contains(indexPath.section)
        readMoreTextView.setNeedsUpdateTrim()
        readMoreTextView.layoutIfNeeded()
        return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "DetailCell")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        //let currentSection = indexPath.section

        readMoreTextView.onSizeChange = { [unowned tableView, unowned self] r in
            let point = tableView.convert(r.bounds.origin, from: r)
            guard let indexPath = tableView.indexPathForRow(at: point) else { return }
            if r.shouldTrim {
                self.expandedCells.remove(indexPath.section)
            } else {
                self.expandedCells.insert(indexPath.section)
            }
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let cell = tableView.cellForRow(at: indexPath)!
//        
//        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
//        readMoreTextView.shouldTrim = !readMoreTextView.shouldTrim
//       tableViewDetail.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //add custome view for header
        
        if section == 0{
            let view = HeaderZeroForDetail()
            switch type{
            case .attractionType:
                if let item = item as? Attraction{
                if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        view.imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        view.imageView.image?.af_imageAspectScaled(toFit: CGSize(width: view.imageView.frame.width, height: view.imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                }
                break
            case .localGuideType:
                if let item = item as? LocalGuide{
                    if let urlStr = item.avatar{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        view.imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        view.imageView.image?.af_imageAspectScaled(toFit: CGSize(width: view.imageView.frame.width, height: view.imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                }
                break
            case .themParkType:
                if let item = item as? ThemeParks{
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        view.imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        view.imageView.image?.af_imageAspectScaled(toFit: CGSize(width: view.imageView.frame.width, height: view.imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                }
                    break
            case .cityTourType:
                if let item = item as? CityTour{
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        view.imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        view.imageView.image?.af_imageAspectScaled(toFit: CGSize(width: view.imageView.frame.width, height: view.imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                }
                    break
            case .foodTourType:
                if let item = item as? FoodTour{
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        view.imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        view.imageView.image?.af_imageAspectScaled(toFit: CGSize(width: view.imageView.frame.width, height: view.imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                }
                    break
            case .experienceType:
                if let item = item as? Experience{
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        view.imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        view.imageView.image?.af_imageAspectScaled(toFit: CGSize(width: view.imageView.frame.width, height: view.imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                }
                    break
            case .hotelType:
                if let item = item as? Hotel{
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        view.imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        view.imageView.image?.af_imageAspectScaled(toFit: CGSize(width: view.imageView.frame.width, height: view.imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                }
                    break
            case .travelAgencyType:
                if let item = item as? TravelAgency{
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        view.imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        view.imageView.image?.af_imageAspectScaled(toFit: CGSize(width: view.imageView.frame.width, height: view.imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                }
                    break
            default:
                print("")
            }
            return view
        }else{
            let view = HeaderView()
            view.backgroundColor = UIColor.white
            view.targetView.layer.cornerRadius = view.targetView.frame.width / 6
            view.seeAllBtn.isHidden = true
            if section == 1{
            if type == .localGuideType{
                view.nameOfCarousel.text = "About Tour"
            }else if type == .travelAgencyType{
                view.nameOfCarousel.text = "Contact"
            }else{
                view.nameOfCarousel.text = "Hightlight"
            }
            }else if section == 2{
                view.nameOfCarousel.text = "Full Decriptions"
            }
            view.nameOfCarousel.font = UIFont.boldSystemFont(ofSize: 15)
            view.leadingViewOfHeaderView.constant = 20
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return self.tableViewDetail.frame.height / 2
        }
        return 40
    }
    
}
