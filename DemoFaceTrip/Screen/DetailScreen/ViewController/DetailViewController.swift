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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableViewDetail: UITableView!{
        didSet {
            tableViewDetail.estimatedRowHeight = 50
            tableViewDetail.rowHeight = UITableViewAutomaticDimension
        }
    }
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var numReview: UILabel!
    @IBOutlet weak var bookingBtn: UIButton!
    
    var currentSection = -1
    
    var expandedCells = Set<Int>()
    var type: catagoryType = .None
    var item: AnyObject?
    var isCoslap = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDetail.delegate = self
        tableViewDetail.dataSource = self
        tableViewDetail.register(UINib.init(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        setImageForView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initBackButton()
        bookingBtn.layer.cornerRadius = bookingBtn.frame.width / 12
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        //tableViewDetail.reloadData()
    }
    func setImageForView() {
        switch type {
        case .attractionType:
            //if let imageView = imageView{
                if let item = item as? Attraction{
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        imageView.image?.af_imageAspectScaled(toFit: CGSize(width: imageView.frame.width, height: imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let place = item.place{
                        price.text = ("Place: \(place)")
                    }
                    
                    if let reviewCount = item.numReview{
                        numReview.text = ("Review: \(reviewCount)")
                    }
                }
            //}
        case .cityTourType:
            //if let imageView = imageView{
                if let item = item as? CityTour{
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        imageView.image?.af_imageAspectScaled(toFit: CGSize(width: imageView.frame.width, height: imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let priceTour = item.price{
                        price.text = ("Price: \(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numPersonReview{
                        numReview.text = ("Review: \(reviewCount)")
                    }
                }
            //}
        case .experienceType:
            //if let imageView = imageView{
                if let item = item as? Experience{
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        imageView.image?.af_imageAspectScaled(toFit: CGSize(width: imageView.frame.width, height: imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let priceTour = item.price{
                        price.text = ("Price: \(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numPersonReview{
                        numReview.text = ("Review: \(reviewCount)")
                    }
                }
            //}
        case .foodTourType:
            //if let imageView = imageView{
                if let item = item as? FoodTour{
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        imageView.image?.af_imageAspectScaled(toFit: CGSize(width: imageView.frame.width, height: imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let priceTour = item.price{
                        price.text = ("Price: \(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numReview{
                        numReview.text = ("Review: \(reviewCount)")
                    }
                }
            //}
        case .hotelType:
            //if let imageView = imageView{
                if let item = item as? Hotel{
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        imageView.image?.af_imageAspectScaled(toFit: CGSize(width: imageView.frame.width, height: imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let priceTour = item.price{
                        price.text = ("Price: \(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numPersonReview{
                        numReview.text = ("Review: \(reviewCount)")
                    }
                }
            //}
        case .localGuideType:
            //if let imageView = imageView{
                if let item = item as? LocalGuide{
                    if let urlStr = item.avatar{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        imageView.image?.af_imageAspectScaled(toFit: CGSize(width: imageView.frame.width, height: imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let priceTour = item.price{
                        price.text = ("Price: \(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numLike{
                        numReview.text = ("Review: \(reviewCount)")
                    }
                }
            //}
        case .themParkType:
            //if let imageView = imageView{
                if let item = item as? ThemeParks{
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        imageView.image?.af_imageAspectScaled(toFit: CGSize(width: imageView.frame.width, height: imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let priceTour = item.price{
                        price.text = ("Price: \(priceTour)$/person")
                    }
                    
                    if let reviewCount = item.numReview{
                        numReview.text = ("Review: \(reviewCount)")
                    }
                }
            //}
        case .travelAgencyType:
            //if let imageView = imageView{
                if let item = item as? TravelAgency{
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        imageView.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        imageView.image?.af_imageAspectScaled(toFit: CGSize(width: imageView.frame.width, height: imageView.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let priceTour = item.place{
                        price.text = ("Place: \(priceTour)")
                    }
                    
                    if let reviewCount = item.numReview{
                        numReview.text = ("Review: \(reviewCount)")
                    }
                }
            //}
        default:
            print("")
        }
        //tableViewDetail.reloadData()
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell

        let currentSection = indexPath.section
        
        switch type {
        case .attractionType:
            if let item = item as? Attraction{
                if currentSection == 0{
                    cell.textView.text = item.highlight
                }else{
                    cell.textView.text = item.descriptionAttraction
                }
            }
            break
        case .themParkType:
            if let item = item as? ThemeParks{
                if currentSection == 0{
                    cell.textView.text = item.highlight
                }else{
                    cell.textView.text = item.descriptionThemePark
                }
                
            }
            break
        case .localGuideType:
            if let item = item as? LocalGuide{
                if currentSection == 0{
                    cell.textView.text = item.aboutTour
                }else{
                    cell.textView.text = item.descriptionGuide
                }
            }
            break
        case .hotelType:
            if let item = item as? Hotel{
                if currentSection == 0{
                    cell.textView.text = item.highlight
                }else{
                    cell.textView.text = item.descriptionHotel
                }
            }
            break
        case .experienceType:
            if let item = item as? Experience{
                if currentSection == 0{
                    cell.textView.text = item.highlight
                }else{
                cell.textView.text = item.descriptionExp
                }
            }
            break
        case .foodTourType:
            if let item = item as? FoodTour{
                if currentSection == 0{
                    cell.textView.text = item.highlight
                }else{
                    cell.textView.text = item.descriptionTour
                }
            }
            break
        case .cityTourType:
            if let item = item as? CityTour{
                if currentSection == 0{
                    cell.textView.text = item.highlight
                }else{
                    cell.textView.text = item.descriptionTour
                }
            }
            break
        case .travelAgencyType:
            if let item = item as? TravelAgency{
                if currentSection == 0{
                    cell.textView.text = item.contact
                }else{
                    cell.textView.text = item.descriptionAgency
                }
            }
        default:
            print("")
        }
        
        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        readMoreTextView.shouldTrim = !expandedCells.contains(indexPath.section)
        readMoreTextView.setNeedsUpdateTrim()
        readMoreTextView.layoutIfNeeded()
        return cell
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
        
        let cell = tableView.cellForRow(at: indexPath)!
        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        readMoreTextView.shouldTrim = !readMoreTextView.shouldTrim
       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //add custome view for header
        let view = HeaderView()
        view.backgroundColor = UIColor.white
        view.targetView.layer.cornerRadius = view.targetView.frame.width / 6
        view.seeAllBtn.isHidden = true
        if section == 0{
            if type == .localGuideType{
                view.nameOfCarousel.text = "About Tour"
            }else if type == .travelAgencyType{
                view.nameOfCarousel.text = "Contact"
            }else{
                view.nameOfCarousel.text = "Hightlight"
            }
        }else{
            view.nameOfCarousel.text = "Full Decription"
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

}
