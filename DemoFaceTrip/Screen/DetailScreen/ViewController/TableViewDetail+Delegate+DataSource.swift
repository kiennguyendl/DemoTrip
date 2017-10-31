//
//  TableViewDetail+Delegate+DataSource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import ReadMoreTextView

extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = indexPath.section
        switch currentSection {
        case 0:
            return UITableViewCell(style: .default, reuseIdentifier: "DetailCell")
        case 1, 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
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
            let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
            readMoreTextView.shouldTrim = !expandedCells.contains(indexPath.section)
            readMoreTextView.setNeedsUpdateTrim()
            readMoreTextView.layoutIfNeeded()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath) as! CalendarTableViewCell
            return cell
//        case 4:
//             return UITableViewCell(style: .default, reuseIdentifier: "DetailCell")
        default:
            return UITableViewCell(style: .default, reuseIdentifier: "DetailCell")
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 || indexPath.section == 2{
        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        
        readMoreTextView.onSizeChange = { [unowned tableView, unowned self] r in
            let point = tableView.convert(r.bounds.origin, from: r)
            guard let indexPath = tableView.indexPathForRow(at: point) else { return }
            if r.shouldTrim {
                self.expandedCells.remove(indexPath.section)
            } else {
                self.expandedCells.insert(indexPath.section)
            }
            tableView.reloadData()
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
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
            view.heightOfTargetView.constant = 5
            view.seeAllBtn.isHidden = true
            
            switch section{
            case 1:
                if type == .localGuideType{
                    view.nameOfCarousel.text = "About Tour"
                }else if type == .travelAgencyType{
                    view.nameOfCarousel.text = "Contact"
                }else{
                    view.nameOfCarousel.text = "Hightlight"
                }
            case 2:
                view.nameOfCarousel.text = "Full Decriptions"
            case 3:
                view.nameOfCarousel.text = "Availability"
//            case 4:
//                view.nameOfCarousel.text = "Meeting oints"
            default:
                print("")
            }
            view.nameOfCarousel.font = UIFont.boldSystemFont(ofSize: 16)
            view.leadingViewOfHeaderView.constant = 20
            
            //view.backgroundColor = UIColor.gray
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return self.tableViewDetail.frame.height * 2 / 5 + 10
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1, 2:
            return UITableViewAutomaticDimension
        case 3:
            return tableViewDetail.frame.height / 3.2
        default:
            return 0
        }
    }
}
