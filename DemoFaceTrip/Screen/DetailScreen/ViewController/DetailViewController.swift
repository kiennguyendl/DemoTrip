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
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initBackButton()
        
    }
    
    override func viewDidLayoutSubviews() {
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

        

        switch type {
        case .attractionType:
            if let item = item as? Attraction{
                cell.textView.text = item.descriptionAttraction
                
            }
            break
        case .themParkType:
            if let item = item as? ThemeParks{
                cell.textView.text = item.descriptionThemePark
            }
            break
        case .localGuideType:
            if let item = item as? LocalGuide{
                cell.textView.text = item.descriptionGuide
            }
            break
        case .hotelType:
            if let item = item as? Hotel{
                cell.textView.text = item.descriptionHotel
            }
            break
        case .experienceType:
            if let item = item as? Experience{
                cell.textView.text = item.descriptionExp
            }
            break
        case .foodTourType:
            if let item = item as? FoodTour{
                cell.textView.text = item.descriptionTour
            }
            break
        case .cityTourType:
            if let item = item as? CityTour{
                cell.textView.text = item.descriptionTour
            }
            break
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
        //view.nameOfCarousel.text = catagory[section].type
        view.targetView.layer.cornerRadius = view.targetView.frame.width / 6
        view.seeAllBtn.isHidden = true
        if section == 0{
            view.nameOfCarousel.text = "Hightlight"
        }else{
            view.nameOfCarousel.text = "Full Decription"
        }
        return view
    }

}
