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
        if tableView == tableViewCarousels{
            if listID.count > 0{
                return listID.count + 1
            }
            return 0
        }else if tableView == tableViewSubMenu{
            return listNumSubMenu
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewCarousels{
            if section == 0{
                return 0
            }
            return 1
        }else if tableView == tableViewSubMenu{
            return 1
        }
        
        return 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewCarousels{
            if indexPath.section != 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableViewCell
                let currentSection = indexPath.section - 1
                
                if let typeMenu = listID[currentSection].type{
                    switch typeMenu{
                    case "Recentlies":
                        RestDataManager.shareInstance.restDataFollowTypeOfMenu(urlForHome, menu: "menu", action: "getlist", id: city.id!, idMenu: listID[currentSection].id!, type: "\(listID[currentSection].type!)", complertionHandler: {(category: RecentlyMenu?, error: Error?) in
                            if let category = category{
                                cell.typeOfMenu = category.typeCategory
                                cell.category = category
                            }
                        })
                        return cell
                    case "WishList":
                        RestDataManager.shareInstance.restDataFollowTypeOfMenu(urlForHome, menu: "menu", action: "getlist", id: city.id!, idMenu: listID[currentSection].id!, type: "\(listID[currentSection].type!)", complertionHandler: {(category: WishListMenu?, error: Error?) in
                            if let category = category{
                                cell.typeOfMenu = category.typeCategory
                                cell.category = category
                            }
                        })
                        return cell
                    case "BestSeller":
                        RestDataManager.shareInstance.restDataFollowTypeOfMenu(urlForHome, menu: "menu", action: "getlist", id: city.id!, idMenu: listID[currentSection].id!, type: "\(listID[currentSection].type!)", complertionHandler: {(category: BestSellerMenu?, error: Error?) in
                            if let category = category{
                                cell.typeOfMenu = category.typeCategory
                                cell.category = category
                            }
                        })
                        return cell
                    case "FTPickes":
                        RestDataManager.shareInstance.restDataFollowTypeOfMenu(urlForHome, menu: "menu", action: "getlist", id: city.id!, idMenu: listID[currentSection].id!, type: "\(listID[currentSection].type!)", complertionHandler: {(category: FTPickesMenu?, error: Error?) in
                            if let category = category{
                                cell.typeOfMenu = category.typeCategory
                                cell.category = category
                            }
                        })
                        return cell
                    case "Attractions":
                        RestDataManager.shareInstance.restDataFollowTypeOfMenu(urlForHome, menu: "menu", action: "getlist", id: city.id!, idMenu: listID[currentSection].id!, type: "\(listID[currentSection].type!)", complertionHandler: {(category: ShowAndAttrachtions?, error: Error?) in
                            if let category = category{
                                cell.typeOfMenu = category.typeCategory
                                cell.category = category
                            }
                        })
                        return cell
                    case "Day trip":
                        RestDataManager.shareInstance.restDataFollowTypeOfMenu(urlForHome, menu: "menu", action: "getlist", id: city.id!, idMenu: listID[currentSection].id!, type: "\(listID[currentSection].type!)", complertionHandler: {(category: DayTripAndExcursionsTourMenu?, error: Error?) in
                            if let category = category{
                                cell.typeOfMenu = category.typeCategory
                                cell.category = category
                            }
                        })
                        return cell
                    case "Multi Day Trip":
                        RestDataManager.shareInstance.restDataFollowTypeOfMenu(urlForHome, menu: "menu", action: "getlist", id: city.id!, idMenu: listID[currentSection].id!, type: "\(listID[currentSection].type!)", complertionHandler: {(category: MultiDayTripAndExcursionsTourMenu?, error: Error?) in
                            if let category = category{
                                cell.typeOfMenu = category.typeCategory
                                cell.category = category
                            }
                        })
                        return cell
                    case "Activities":
                        RestDataManager.shareInstance.restDataFollowTypeOfMenu(urlForHome, menu: "menu", action: "getlist", id: city.id!, idMenu: listID[currentSection].id!, type: "\(listID[currentSection].type!)", complertionHandler: {(category: OutDoorActivities?, error: Error?) in
                            if let category = category{
                                cell.typeOfMenu = category.typeCategory
                                cell.category = category
                            }
                        })
                        return cell
                    case "Experiences":
                        RestDataManager.shareInstance.restDataFollowTypeOfMenu(urlForHome, menu: "menu", action: "getlist", id: city.id!, idMenu: listID[currentSection].id!, type: "\(listID[currentSection].type!)", complertionHandler: {(category: CustomExperiences?, error: Error?) in
                            if let category = category{
                                cell.typeOfMenu = category.typeCategory
                                cell.category = category
                            }
                        })
                        return cell
                    default:
                        print("")
                    }
                }
                
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubMenuCell", for: indexPath) as! SubMenuTableViewCell
            //let currentSection = indexPath.section
            switch typeOfMenu{
            case .Activities:
                let data = listItemOfEachTypeMenu as! OutDoorActivities
                print(data)
            case .Attractions:
                let data = listItemOfEachTypeMenu as! ShowAndAttrachtions
                print(data)
            case .BestSeller:
                print("")
            case .Daytrip:
                print("")
            case .MultiDayTrip:
                print("")
            case .Experiences:
                let data = listItemOfEachTypeMenu as! CustomExperiences
                print(data)
            case .FTPickes:
                print("")
            case .WishList:
                print("")
            case .Recentlies:
                print("")
            case .None:
                print("")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let height = self.view.frame.height / 2.7
        if indexPath.section == 0{
            return 0
        }else{
            let currentSection = indexPath.section - 1
            if let typeMenu = listID[currentSection].type{
                switch typeMenu{
                case "Attractions", "Activities", "Experiences":
                    //print("+++++++++++++++++++++++++++++++++++++++++++")
                    //print("height of cell: \(tableViewCarousels.frame.size.height / 3.5)")
                    return self.view.frame.size.height / 4.5
                    
                case "Recentlies", "WishList", "BestSeller", "FTPickes", "Day trip", "Multi Day Trip":
                    return self.view.frame.size.height / 3
                
                default:
                    print("")
                }
            }
            
            
        }
//            if Settings.isScaleMenuView!{
//                return ((tableViewCarousels.frame.size.height * 4) / 9 + 10)
//            }else{
//                return (tableViewCarousels.frame.size.height * 4) / 8 + 20
//            }
            
            //        if Settings.isScaleMenuView!{
            //            return ((tableViewCarousels.frame.size.height * 4) / 9) - 20
            //        }else{
            //            return (tableViewCarousels.frame.size.height * 4) / 8 - 20
            //        }
        return 0
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            if tableView == tableViewCarousels{
                if section == 0{
                    return 140
                }else{
                    return 50
                }
                
            }else{
                return 50
            }
        }
        @objc func showAllItem(sender: UIButton) {
            tableViewCarousels.isHidden = true
            collectionViewListing.isHidden = false
            menuBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
            isBackBtn = true
            isMenuBtn = false
            if Settings.isScaleMenuView!{
                moveDownCarouselsView()
            }
//            let vc = ListingViewController()
//            navigationController?.pushViewController(vc, animated: true)
            //        let section = sender.tag
            //        switch catagory[section].typeCatagory {
            //
            //        case .localGuideType, .travelAgencyType, .hotelType, .experienceType:
            //
            //            let typeMenu1 = catagory[section].typeCatagory
            //
            //            for index in 0..<dataForMenu1.count{
            //                if typeMenu1 == dataForMenu1[index].typeCatagory{
            //
            //                    self.collectionViewCarousels.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            //                    self.collectionView(collectionViewCarousels, didSelectItemAt: IndexPath(row: index + 1, section: 0))
            //                    self.collectionViewListing.isHidden = false
            //                    self.collectionViewListing.reloadData()
            //                }
            //            }
            //
            //        case .attractionType, .themParkType, .cityTourType, .foodTourType:
            //
            //            let vc = ListDetailCatagoryViewController()
            //            let dataMenu2 = catagory[section]
            //            vc.typeCatagory = dataMenu2.typeCatagory
            //            if let item = dataMenu2.catagoryItems{
            //                vc.listDetail = item
            //            }
            //            self.navigationController?.pushViewController(vc, animated: true)
            //            break
            //        default:
            //            print("")
            //        }
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            //add custome view for header
            if tableView == tableViewCarousels{
                if section == 0{
                    
                    //            view.dataForMenu2 = dataForMenu2
                    //            view.delegate = self
                    viewForHeaderZero.delegate = self
                    return viewForHeaderZero
                }else{
                    let view = HeaderView()
                    view.backgroundColor = UIColor.clear
                    view.nameOfCarousel.text = listID[section - 1].type
                    view.targetView.layer.cornerRadius = view.targetView.frame.width / 6
                    view.seeAllBtn.tag = section
                    view.seeAllBtn.addTarget(self, action: #selector(showAllItem(sender:)), for: .touchUpInside)
                    return view
                }
            }else{
                let view = HeaderView()
                view.backgroundColor = UIColor.clear
                switch typeOfMenu{
                case .Activities:
                    let data = listItemOfEachTypeMenu as! OutDoorActivities
                    view.nameOfCarousel.text = data.listSubMenu[section].type
                    print(data)
                case .Attractions:
                    let data = listItemOfEachTypeMenu as! ShowAndAttrachtions
                    view.nameOfCarousel.text = data.listSubMenu[section].type
                    print(data)
                case .BestSeller:
                    print("")
                case .Daytrip:
                    print("")
                case .MultiDayTrip:
                    print("")
                case .Experiences:
                    let data = listItemOfEachTypeMenu as! CustomExperiences
                    view.nameOfCarousel.text = data.listSubMenu[section].type
                    print(data)
                case .FTPickes:
                    print("")
                case .WishList:
                    print("")
                case .Recentlies:
                    print("")
                case .None:
                    print("")
                }
                //view.nameOfCarousel.text = listID[section].type
                view.targetView.layer.cornerRadius = view.targetView.frame.width / 6
                view.seeAllBtn.tag = section
                view.seeAllBtn.addTarget(self, action: #selector(showAllItem(sender:)), for: .touchUpInside)
                return view
            }
        }
        
        func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
            if Settings.isScaleMenuView!{
                //print("test>>>>>>>>>>>>>>>>>>>>>> :) scaled")
//                DispatchQueue.main.async {
//                    UIView.animate(withDuration: 0.0, animations: {
//                        if self.view.frame.origin.y >= 0{
//                            self.setWhiteColorForStatusBar()
//                            //move origin coordinates of main view to 0
//                            self.view.frame = CGRect(x: self.view.frame.origin.x, y: -self.newPos, width: self.view.frame.size.width, height: self.view.frame.size.height + self.newPos)
//                            Settings.isScaleMenuView = true
//                            //print("Settings.isScaleMenuView: \(Settings.isScaleMenuView)")
//                            if self.tableViewCarousels.isHidden == false{
//                                if let contentOffset = HomeViewController.verticalContentOffset{
//                                    self.tableViewCarousels.setContentOffset(CGPoint(x: 0,y:  contentOffset), animated: false)
//                                }
//                            }else if self.collectionViewListing.isHidden == false{
//                                if let contentOffset = HomeViewController.verticalContentOffset{
//                                    self.collectionViewListing.setContentOffset(CGPoint(x: 0,y:  contentOffset), animated: false)
//                                }
//                            }
//                        }
//                    })
//                }
            }else{
                //print("test>>>>>>>>>>>>>>>>>>>>>> :) not scale")
            }
            
        }
        
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            if scrollView.tag == 1 || scrollView.tag == 2{
                //let heightOfCarouselsView = carouselsView.frame.height
                if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0{
//                    //print("move down")
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5, animations: {
                            self.moveDownCarouselsView()
                        })
                        
                    }
                    

                }else if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y < 0{
//                    //print("move up")
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5, animations: {
                            self.moveUpCarouselsView()
                        })
                        
                    }
                    
                }
            }
        }
        
    }

