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
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = indexPath.section
        switch currentSection {
        case 0:
            return UITableViewCell()
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
                //cell.delegate = self
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewMeetingPointCell", for: indexPath) as! NewMeetingPointTableViewCell
            cell.selectionStyle = .none
            //cell.delegate = self
             return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! RatingTableViewCell
            
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsCell", for: indexPath) as! ReviewsTableViewCell
            cell.contentReview.text = "This place is amazing. Me, my husband and our 3 year old spent the October half term here this year. We arrived at the airport and were personally greeted by our driver who whisked us to the hotel in the air conditioned Mercedes. Check in isn't really check in. Your sat down with a glass of sparkling wine or juice. The service is incredibly personal. No long forms, no fuss. We had booked a panoramic junior suite but they upgraded us to a one-bed bungalow with private garden. Off we went in our golf buggy to our room, which was amazing! Huge bed, separate lounge with double sofa bed for our little girl. You have a mini bar which is included in the all inclusive and restocked daily. Worth noting it's also big enough if you want to buy you own drinks/milk for babies etc. \nThe choice of food/restaurants is fantastic. We ate breakfast in the buffer, Flavors - this isn't like any other all inclusive buffet you would have seen! Lunches were on the sun soaked terrace of Ouzo, the Greek restaurant overlooking the beach. We had dinner in the Italian, French & Greek. All fantastic. You do need to book as seating is limited but well worth it. We also used the dine-out option to go to a local taverna for dinner. \nI feel I can't really put into words just how good this place is. I won't do it justice. All the staff that we met were exceptional. Everything is slick and clean and just done. You don't need to ask for anything. \nThe hotel pools are fab, children's pools are heated to keep their little toes warm! There is sunbed service for food & drinks at all the pools and the beach. \nWe didn't use the creche as this was a family holiday which we wanted to enjoy with our little one but the option is there, as well as baby sitting and a playground that you can use without booking. There is also a lunch club if the children want to go to that.\nThere are so many fantastic places to holiday that sometimes its hard to imagine going back again and again to the same place. Ikos Olivia is that place that I can imagine returning to very soon. We've looked at prices for next June!\nIt's at the top end of our holiday budget but I truly believe it's priced fairly for whats on offer/included and the level of service you get."
            let readMoreTextView = cell.contentView.viewWithTag(2) as! ReadMoreTextView
            readMoreTextView.shouldTrim = !expandedCells.contains(indexPath.section)
            readMoreTextView.setNeedsUpdateTrim()
            readMoreTextView.layoutIfNeeded()
            cell.lineView.isHidden = true
            return cell
        default:
            return UITableViewCell(style: .default, reuseIdentifier: "")
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
 
        if indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 6{
            let readMoreTextView: ReadMoreTextView!
            if indexPath.section == 6{
                readMoreTextView = cell.contentView.viewWithTag(2) as! ReadMoreTextView
            }else{
                readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
            }
            
            
            readMoreTextView.onSizeChange = { [unowned tableView, unowned self] r in
                let point = tableView.convert(r.bounds.origin, from: r)
                guard let indexPath = tableView.indexPathForRow(at: point) else { return }
                if r.shouldTrim {
                    self.expandedCells.remove(indexPath.section)
                } else {
                    self.expandedCells.insert(indexPath.section)
                }
                tableView.reloadData()
                //tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            }
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
                //let cell = tableView.cellForRow(at: indexPath)!
        
        //
        //        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        //        readMoreTextView.shouldTrim = !readMoreTextView.shouldTrim
        //       tableViewDetail.scrollToRow(at: indexPath, at: .top, animated: true)
        if indexPath.section == 4{
            let vc = NewMapViewViewController()
            self.present(vc, animated: true, completion: nil)
        }
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
            case 4:
                view.nameOfCarousel.text = "Meeting Points"
            case 5:
                view.nameOfCarousel.text = "Reviews (28): 4.88 out of 5 stars"
            case 6:
                view.nameOfCarousel.text = "Great experience i had have"
                view.targetView.isHidden = true
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
        case 0,1, 2:
            return UITableViewAutomaticDimension
        case 3:
            return tableViewDetail.frame.height / 3.2
        case 4:
            return tableViewDetail.frame.height / 2.5
        case 5:
            return 130
        case 6:
            return UITableViewAutomaticDimension
        default:
            return 0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableViewDetail.cellForRow(at: IndexPath(row: 0, section: 0)) != nil{
            UIView.animate(withDuration: 0.7, animations: {
                DispatchQueue.main.async {
    
                    self.contraintBottomMenuView.constant = -130
                    self.viewMenu.isHidden = false
                    self.view.bringSubview(toFront: self.viewMenu)
                }
            })
        }else{
            UIView.animate(withDuration: 0.7, animations: {
                DispatchQueue.main.async {
                    self.contraintBottomMenuView.constant = 90
                }
            })
        }
        
    }
}
