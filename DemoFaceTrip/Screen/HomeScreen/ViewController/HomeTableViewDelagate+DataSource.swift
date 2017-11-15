//
//  HomeTableViewDelagate+DataSource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

//// TableView
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return catagory.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section != 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableViewCell
            
            cell.delegate = self
            let currentSection = indexPath.section - 1
            cell.collectionViewForCell.tag = currentSection
            cell.currentSection = currentSection
            cell.catagoryItems = catagory[currentSection].catagoryItems
            switch catagory[currentSection].typeCatagory {
            case .hotelType:
                cell.type = .hotelType
            case .experienceType:
                cell.type = .experienceType
            case .localGuideType:
                cell.type = .localGuideType
            case .attractionType:
                cell.type = .attractionType
            case .themParkType:
                cell.type = .themParkType
            case .cityTourType:
                cell.type = .cityTourType
            case .foodTourType:
                cell.type = .foodTourType
            case .travelAgencyType:
                cell.type = .travelAgencyType
            default:
                cell.type = .None
            }
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "HomeTableCell")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let height = self.view.frame.height / 2.7
        if indexPath.section == 0{
            return 0
        }
                if Settings.isScaleMenuView!{
                    return ((tableViewCarousels.frame.size.height * 4) / 9 + 10)
                }else{
                    return (tableViewCarousels.frame.size.height * 4) / 8 + 20
                }
        
//        if Settings.isScaleMenuView!{
//            return ((tableViewCarousels.frame.size.height * 4) / 9) - 20
//        }else{
//            return (tableViewCarousels.frame.size.height * 4) / 8 - 20
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 140
        }else{
            return 50
        }
    }
    @objc func showAllItem(sender: UIButton) {
        let section = sender.tag
        switch catagory[section].typeCatagory {
            
        case .localGuideType, .travelAgencyType, .hotelType, .experienceType:
            
            let typeMenu1 = catagory[section].typeCatagory
            
            for index in 0..<dataForMenu1.count{
                if typeMenu1 == dataForMenu1[index].typeCatagory{
                    
                    self.collectionViewCarousels.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                    self.collectionView(collectionViewCarousels, didSelectItemAt: IndexPath(row: index + 1, section: 0))
                    self.collectionViewDetail.isHidden = false
                    self.collectionViewDetail.reloadData()
                }
            }
            
        case .attractionType, .themParkType, .cityTourType, .foodTourType:
            
            let vc = ListDetailCatagoryViewController()
            let dataMenu2 = catagory[section]
            vc.typeCatagory = dataMenu2.typeCatagory
            if let item = dataMenu2.catagoryItems{
                vc.listDetail = item
            }
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            print("")
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //add custome view for header
        if section == 0{
            let view = HeaderZeroView()
            view.dataForMenu2 = dataForMenu2
            view.delegate = self
            return view
        }else{
            let view = HeaderView()
            view.backgroundColor = UIColor.clear
            view.nameOfCarousel.text = catagory[section - 1].type
            view.targetView.layer.cornerRadius = view.targetView.frame.width / 6
            view.seeAllBtn.tag = section
            view.seeAllBtn.addTarget(self, action: #selector(showAllItem(sender:)), for: .touchUpInside)
            return view
        }
    }
    
    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        if Settings.isScaleMenuView!{
            //print("test>>>>>>>>>>>>>>>>>>>>>> :) scaled")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.0, animations: {
                    if self.view.frame.origin.y >= 0{
                        self.setWhiteColorForStatusBar()
                        //move origin coordinates of main view to 0
                        self.view.frame = CGRect(x: self.view.frame.origin.x, y: -self.newPos, width: self.view.frame.size.width, height: self.view.frame.size.height + self.newPos)
                        Settings.isScaleMenuView = true
                        //print("Settings.isScaleMenuView: \(Settings.isScaleMenuView)")
                        if self.tableViewCarousels.isHidden == false{
                            if let contentOffset = HomeViewController.verticalContentOffset{
                                self.tableViewCarousels.setContentOffset(CGPoint(x: 0,y:  contentOffset), animated: false)
                            }
                        }else if self.collectionViewDetail.isHidden == false{
                            if let contentOffset = HomeViewController.verticalContentOffset{
                                self.collectionViewDetail.setContentOffset(CGPoint(x: 0,y:  contentOffset), animated: false)
                            }
                        }
                    }
                })
            }
        }else{
            //print("test>>>>>>>>>>>>>>>>>>>>>> :) not scale")
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // cần fix animation. tách thread
        
        
        if scrollView.tag == 1 || scrollView.tag == 2{
        
        
        //handle when scroll up
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0{
            //print("move down")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.view.frame.origin.y < 0{
                        //move origin coordinates of main view to up
                        self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - self.newPos)
                        Settings.isScaleMenuView = false
                    }
                    
                })
                self.setColorForMenuView()
                self.collectionViewCarousels.reloadData()
                
                self.setRedColorForStatusBar()
                self.showSubMenu()
                //change color when scroll up
                self.viewMenu.backgroundColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
                self.collectionViewCarousels.backgroundColor = color3
                
                
            }
            
        }else if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y < 0{
            //handle when scroll down
            //print("move up")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.view.frame.origin.y >= 0{
                        self.setWhiteColorForStatusBar()
                        //move origin coordinates of main view to 0
                        self.view.frame = CGRect(x: self.view.frame.origin.x, y: -self.newPos, width: self.view.frame.size.width, height: self.view.frame.size.height + self.newPos)
                        Settings.isScaleMenuView = true
                    }
                })
                self.collectionViewCarousels.reloadData()
                
                self.hidenSubMenu()
                //change color when scroll down
                self.viewMenu.backgroundColor = UIColor.white
                self.collectionViewCarousels.backgroundColor = UIColor.white
                
                if let view = self.viewMenu{
                    for layer in view.layer.sublayers!{
                        if layer == self.gradientLayer{
                            layer.removeFromSuperlayer()
                        }
                    }
                }
                
            }
            
        }
        }
    }
    
}

