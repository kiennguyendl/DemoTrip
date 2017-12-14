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
        return 8
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSection = indexPath.section
        if let data = self.detailTour{
        switch currentSection {
        case 0:
            return UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoverCell", for: indexPath) as! CoverTableViewCell
            if let data = detailTour{
                if let name = data.nameTour{
                    cell.coverNameOfTour.text = name
                }
            }
            cell.selectionStyle = .none
            return cell
        case 2, 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
            
            if currentSection == 2{
                cell.textView.text = data.highlight
            }else{
                cell.textView.text = data.descriptionTour
            }
            
            let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
            readMoreTextView.shouldTrim = !expandedCells.contains(indexPath.section)
            readMoreTextView.setNeedsUpdateTrim()
            readMoreTextView.layoutIfNeeded()
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath) as! CalendarTableViewCell
            if let calendarBooking = data.calendarTour{
                cell.bookingDay = calendarBooking
            }
                //cell.delegate = self
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewMeetingPointCell", for: indexPath) as! NewMeetingPointTableViewCell
            //cell.selectionStyle = .none
            if let meetingPoint = data.meetingPoint, let coordination = data.coordination{
                cell.meetingPoint = meetingPoint
                cell.coordination = coordination
            }
            //cell.delegate = self
             return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! RatingTableViewCell
            if let rateStar = data.rateStar{
                cell.rateStar = rateStar
            }
            cell.selectionStyle = .none
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsCell", for: indexPath) as! ReviewsTableViewCell
            if let fistComment = data.comments?[0]{
                cell.contentReview.text = fistComment.contentComment
                if let name = fistComment.nameguest, let country = fistComment.country, let timeCm = fistComment.timeComment{
                    cell.authorLbl.text = name + " - " + country + " - " + timeCm
                }
                
            }
            
            if let rate = data.rating{
                cell.ratingStarsView.rating = Double(rate)
            }
            
            
            let readMoreTextView = cell.contentView.viewWithTag(2) as! ReadMoreTextView
            readMoreTextView.shouldTrim = !expandedCells.contains(indexPath.section)
            readMoreTextView.setNeedsUpdateTrim()
            readMoreTextView.layoutIfNeeded()
            cell.lineView.isHidden = true
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell(style: .default, reuseIdentifier: "")
        }
        }
        return UITableViewCell(style: .default, reuseIdentifier: "")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
 
        if let _ = self.detailTour{
        if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 7{
            let readMoreTextView: ReadMoreTextView!
            if indexPath.section == 7{
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
//                tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            }
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
        if indexPath.section == 5{
            let vc = NewMapViewViewController()
            if let data = self.detailTour{
                if let coordination = data.coordination, let meetingPoint = data.meetingPoint{
                    vc.coordination = coordination
                    vc.meetingPoint = meetingPoint
                }
            }
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //add custome view for header
        
        if section == 0{
            let view = HeaderZeroForDetail()
            if let detailTour = self.detailTour{
                if let images = detailTour.images{
                    view.listImage = images
                }
            }
            
            return view
        }else{
            let view = HeaderView()
            if let data = self.detailTour{
            view.backgroundColor = UIColor.white
            //view.targetView.layer.cornerRadius = view.targetView.frame.width / 6
            //view.heightOfTargetView.constant = 5
            view.seeAllBtn.isHidden = true
            
            switch section{
            case 2:
                    view.nameOfCarousel.text = "Hightlight"
            case 3:
                view.nameOfCarousel.text = "Full Decriptions"
            case 4:
                view.nameOfCarousel.text = "Availability"
            case 5:
                view.nameOfCarousel.text = "Meeting Points"
            case 6:
                if let rating = data.rating, let numReview = data.favorite{
                    
                    view.nameOfCarousel.text = "Reviews (\(numReview)): \(rating) out of 5 stars"
                }
                
            case 7:
                if let fistComment = data.comments?[0]{
                    view.nameOfCarousel.text = fistComment.title
//                    view.targetView.isHidden = true
                }
            default:
                print("")
            }
            view.nameOfCarousel.font = UIFont.boldSystemFont(ofSize: 16)
//            view.leadingViewOfHeaderView.constant = 0
            
            //view.backgroundColor = UIColor.gray
            }
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return self.tableViewDetail.frame.height * 2 / 5 + 10
        }else if section == 1{
            return 0
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 0
        case 1, 2, 3:
            return UITableViewAutomaticDimension
        case 4:
            return tableViewDetail.frame.height / 3.2
        case 5:
            return tableViewDetail.frame.height / 2.5
        case 6:
            return 130
        case 7:
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
                    self.currentStatusBarStyle = .lightContent
                    self.statusBar.backgroundColor = UIColor.clear
                    self.setNeedsStatusBarAppearanceUpdate()
                    self.setNonColorForStatusBar()
                }
            })
        }else{
            UIView.animate(withDuration: 0.7, animations: {
                DispatchQueue.main.async {
                    self.contraintBottomMenuView.constant = 90
                    self.currentStatusBarStyle = .default
                    self.statusBar.backgroundColor = UIColor.white
                    self.setNeedsStatusBarAppearanceUpdate()
                    self.setDefaultColorForStatusBar()
                }
            })
        }
        
    }
}
