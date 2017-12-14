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
            }else{
                return 0
            }
        }else if tableView == tableViewSubMenu{
            return listNumSubMenu
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewCarousels{
            if section == 0{
                return 0
            }else{
                return 1
            }
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
                cell.delegate = self
                cell.indexPathTableViewCell = indexPath
                if let typeMenu = listID[currentSection].type{
                    //self.typeMenu = typeMenu
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
        }else if tableView == tableViewSubMenu{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubMenuCell", for: indexPath) as! SubMenuTableViewCell
            cell.delegate = self
            cell.indexPathTableViewCell = indexPath
            //let currentSection = indexPath.section
                        switch typeOfMenu{
                        case .Activities:
                            let data = listItemOfEachTypeMenu as! OutDoorActivities
                            if let typeSubMenu = data.listSubMenu[indexPath.section].type{
                                switch typeSubMenu{
                                case "Cruises,SaiLing And Water Tour":
                                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: data.type!, typeSubMenu: typeSubMenu, complertionHandler: {(category: CruisesSaiLingAndWaterTourSubMenu?, error: Error?) in
                                        if let category = category{
                                            cell.typeOfMenu = self.typeOfMenu
                                            cell.idMenu = data.id!
                                            cell.typeMenu = data.type!
                                            cell.typeOfSubMenu = category.type!
                                            cell.categorySubMenu = category
                                        }
                                        
                                    })
                                    break
                                case "Walking And Biking Tour":
                                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: data.type!, typeSubMenu: typeSubMenu, complertionHandler: {(category: WalkingBikingTourSubMenu?, error: Error?) in
                                        if let category = category{
                                            cell.typeOfMenu = self.typeOfMenu
                                            cell.idMenu = data.id!
                                            cell.typeMenu = data.type!
                                            cell.typeOfSubMenu = category.type!
                                            cell.categorySubMenu = category
                                        }
                                        
                                    })
                                    break
                                case "Climbing And Trekking Tour":
                                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: data.type!, typeSubMenu: typeSubMenu, complertionHandler: {(category: ClimbingAndTrekkingTourSubMenu?, error: Error?) in
                                        if let category = category{
                                            cell.typeOfMenu = self.typeOfMenu
                                            cell.idMenu = data.id!
                                            cell.typeMenu = data.type!
                                            cell.typeOfSubMenu = category.type!
                                            cell.categorySubMenu = category
                                        }
                                        
                                    })
                                    break
                                default:
                                    print("")
                                }
                            }
                            
                        case .Attractions:
                            let data = listItemOfEachTypeMenu as! ShowAndAttrachtions
                            if let typeSubMenu = data.listSubMenu[indexPath.section].type{
                                
                                switch typeSubMenu{
                                case "Show And Concerts":
                                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: data.type!, typeSubMenu: typeSubMenu, complertionHandler: {(category: ShowAndConcertsSubMenu?, error: Error?) in
                                        if let category = category{
                                            cell.typeOfMenu = self.typeOfMenu
                                            cell.idMenu = data.id!
                                            cell.typeMenu = data.type!
                                            cell.typeOfSubMenu = category.type!
                                            cell.categorySubMenu = category
                                        }
                                        
                                    })
                                    break
                                case "Sightseeing Tickets":
                                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: data.type!, typeSubMenu: typeSubMenu, complertionHandler: {(category: SightseeingTicketsSubMenu?, error: Error?) in
                                        if let category = category{
                                            cell.typeOfMenu = self.typeOfMenu
                                            cell.idMenu = data.id!
                                            cell.typeMenu = data.type!
                                            cell.typeOfSubMenu = category.type!
                                            cell.categorySubMenu = category
                                        }
                                        
                                    })
                                    break
                                case "Events":
                                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: data.type!, typeSubMenu: typeSubMenu, complertionHandler: {(category: EventsSubMenu?, error: Error?) in
                                        if let category = category{
                                            cell.typeOfMenu = self.typeOfMenu
                                            cell.idMenu = data.id!
                                            cell.typeMenu = data.type!
                                            cell.typeOfSubMenu = category.type!
                                            cell.categorySubMenu = category
                                        }
                                        
                                    })
                                    break
                                case "Passes":
                                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: data.type!, typeSubMenu: typeSubMenu, complertionHandler: {(category: PassesSubMenu?, error: Error?) in
                                        if let category = category{
                                            cell.typeOfMenu = self.typeOfMenu
                                            cell.idMenu = data.id!
                                            cell.typeMenu = data.type!
                                            cell.typeOfSubMenu = category.type!
                                            cell.categorySubMenu = category
                                        }
                                        
                                    })
                                    break
                                default:
                                    print("")
                                }
                            }
                            
                        case .Experiences:
                            let data = listItemOfEachTypeMenu as! CustomExperiences
                            if let typeSubMenu = data.listSubMenu[indexPath.section].type{
                                
                                switch typeSubMenu{
                                case "Nightlife":
                                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: data.type!, typeSubMenu: typeSubMenu, complertionHandler: {(category: NightlifeSubMenu?, error: Error?) in
                                        if let category = category{
                                            cell.typeOfMenu = self.typeOfMenu
                                            cell.idMenu = data.id!
                                            cell.typeMenu = data.type!
                                            cell.typeOfSubMenu = category.type!
                                            cell.categorySubMenu = category
                                        }
                                        
                                    })
                                    break
                                case "Food":
                                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: data.type!, typeSubMenu: typeSubMenu, complertionHandler: {(category: FoodSubMenu?, error: Error?) in
                                        if let category = category{
                                            cell.typeOfMenu = self.typeOfMenu
                                            cell.idMenu = data.id!
                                            cell.typeMenu = data.type!
                                            cell.typeOfSubMenu = category.type!
                                            cell.categorySubMenu = category
                                        }
                                        
                                    })
                                    break
                                case "Shopping":
                                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: data.type!, typeSubMenu: typeSubMenu, complertionHandler: {(category: ShoppingSubMenu?, error: Error?) in
                                        if let category = category{
                                            cell.typeOfMenu = self.typeOfMenu
                                            cell.idMenu = data.id!
                                            cell.typeMenu = data.type!
                                            cell.typeOfSubMenu = category.type!
                                            cell.categorySubMenu = category
                                        }
                                        
                                    })
                                    break
                                case "Local life":
                                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: data.type!, typeSubMenu: typeSubMenu, complertionHandler: {(category: LocalLifeSubMenu?, error: Error?) in
                                        if let category = category{
                                            cell.typeOfMenu = self.typeOfMenu
                                            cell.idMenu = data.id!
                                            cell.typeMenu = data.type!
                                            cell.typeOfSubMenu = category.type!
                                            cell.categorySubMenu = category
                                        }
                                        
                                    })
                                    break
                                default:
                                    print("")
                                }
                            }
                            
                        default:
                            print("")
                        }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewCarousels{
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
        }else if tableView == tableViewSubMenu{
            return self.view.frame.size.height / 3
        }
        //let height = self.view.frame.height / 2.7
        
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
        
        menuBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        isBackBtn = true
        isMenuBtn = false
        if Settings.isScaleMenuView!{
            moveDownCarouselsView()
        }
        
        let section = sender.tag
        print("section: \(section)")
        if let typeOfMenu = listID[section - 1].type{
            print("type of menu: \(typeOfMenu)")
            inputTextSearchTf.text = Settings.cityPicked! + " - " + typeOfMenu
            switch typeOfMenu {
            case "Recentlies":
                tableViewCarousels.isHidden = true
                collectionViewListing.isHidden = false
                tableViewSubMenu.isHidden = true
                filterView.isHidden = false
                collectionViewCarousels.isHidden = true
                
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeOfMenu, typeSubMenu: "", complertionHandler: {[weak self ](category: RecentlyMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachTypeMenu = category
                        strongSelf.typeOfMenu = .Recentlies
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                print("Recentlies")
            case "WishList":
                tableViewCarousels.isHidden = true
                collectionViewListing.isHidden = false
                tableViewSubMenu.isHidden = true
                filterView.isHidden = false
                collectionViewCarousels.isHidden = true
                
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeOfMenu, typeSubMenu: "", complertionHandler: {[weak self ](category: WishListMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachTypeMenu = category
                        strongSelf.typeOfMenu = .WishList
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                print("WishList")
            case "BestSeller":
                tableViewCarousels.isHidden = true
                collectionViewListing.isHidden = false
                tableViewSubMenu.isHidden = true
                filterView.isHidden = false
                collectionViewCarousels.isHidden = true
                
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeOfMenu, typeSubMenu: "", complertionHandler: {[weak self ](category: BestSellerMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachTypeMenu = category
                        strongSelf.typeOfMenu = .BestSeller
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                print("BestSeller")
            case "FTPickes":
                tableViewCarousels.isHidden = true
                collectionViewListing.isHidden = false
                tableViewSubMenu.isHidden = true
                filterView.isHidden = false
                collectionViewCarousels.isHidden = true
                
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeOfMenu, typeSubMenu: "", complertionHandler: {[weak self ](category: FTPickesMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachTypeMenu = category
                        strongSelf.typeOfMenu = .FTPickes
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                print("FTPickes")
            case "Attractions":
                tableViewCarousels.isHidden = true
                collectionViewListing.isHidden = true
                tableViewSubMenu.isHidden = false
//                filterView.isHidden = false
//                collectionViewCarousels.isHidden = true
                
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeOfMenu, typeSubMenu: "", complertionHandler: {[weak self ](category: ShowAndAttrachtions?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachTypeMenu = category
                        strongSelf.typeOfMenu = .Attractions
                        strongSelf.listNumSubMenu = category.listSubMenu.count
                        strongSelf.tableViewSubMenu.reloadData()
                    }
                    
                })
                print("Attractions")
            case "Day trip":
                tableViewCarousels.isHidden = true
                collectionViewListing.isHidden = false
                tableViewSubMenu.isHidden = true
                filterView.isHidden = false
                collectionViewCarousels.isHidden = true
                
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeOfMenu, typeSubMenu: "", complertionHandler: {[weak self ](category: DayTripAndExcursionsTourMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachTypeMenu = category
                        strongSelf.typeOfMenu = .Daytrip
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                print("Day trip")
            case "Multi Day Trip":
                tableViewCarousels.isHidden = true
                collectionViewListing.isHidden = false
                tableViewSubMenu.isHidden = true
                filterView.isHidden = false
                collectionViewCarousels.isHidden = true
                
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeOfMenu, typeSubMenu: "", complertionHandler: {[weak self ](category: MultiDayTripAndExcursionsTourMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachTypeMenu = category
                        strongSelf.typeOfMenu = .MultiDayTrip
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                print("Multi Day Trip")
            case "Activities":
                tableViewCarousels.isHidden = true
                collectionViewListing.isHidden = true
                tableViewSubMenu.isHidden = false
//                filterView.isHidden = false
//                collectionViewCarousels.isHidden = true
                
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeOfMenu, typeSubMenu: "", complertionHandler: {[weak self ](category: OutDoorActivities?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachTypeMenu = category
                        strongSelf.typeOfMenu = .Activities
                        strongSelf.listNumSubMenu = category.listSubMenu.count
                        strongSelf.tableViewSubMenu.reloadData()
                    }
                    
                })
                print("Activities")
            case "Experiences":
                tableViewCarousels.isHidden = true
                collectionViewListing.isHidden = true
                tableViewSubMenu.isHidden = false
//                filterView.isHidden = false
//                collectionViewCarousels.isHidden = true
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeOfMenu, typeSubMenu: "", complertionHandler: {[weak self ](category: CustomExperiences?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachTypeMenu = category
                        strongSelf.typeOfMenu = .Experiences
                        strongSelf.listNumSubMenu = category.listSubMenu.count
                        strongSelf.tableViewSubMenu.reloadData()
                    }
                    
                })
                print("Experiences")
            default:
                print("")
            }
        }
        
        
    }
    
    @objc func showAllItemOfSubMenu(sender: UIButton) {
        let section = sender.tag
        
        tableViewCarousels.isHidden = true
        tableViewSubMenu.isHidden = true
        collectionViewListing.isHidden = false
        isListSubMenuDisplay = true
        filterView.isHidden = false
        collectionViewCarousels.isHidden = true
        
        switch typeOfMenu {
        case .Attractions:
            let data = listItemOfEachTypeMenu as! ShowAndAttrachtions
            typeMenu = data.type!
            
            if let typeSubMenu = data.listSubMenu[section].type{
                inputTextSearchTf.text = typeMenu + " - " + typeSubMenu
                switch typeSubMenu{
                case "Show And Concerts":
                    print("Show And Concerts")
                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenu, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: ShowAndConcertsSubMenu?, error: Error?) in
                        
                        guard let strongSelf = self else {return}
                        if let category = category{
                            strongSelf.listItemOfEachSubMenu = category
                            strongSelf.typeOfSubMenu = "Show And Concerts"
                            strongSelf.listItem = category.listItem.count
                            strongSelf.collectionViewListing.reloadData()
                        }
                        
                    })

                case "Sightseeing Tickets":
                    print("Sightseeing Tickets")
                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenu, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: SightseeingTicketsSubMenu?, error: Error?) in
                        
                        guard let strongSelf = self else {return}
                        if let category = category{
                            strongSelf.listItemOfEachSubMenu = category
                            strongSelf.typeOfSubMenu = "Sightseeing Tickets"
                            strongSelf.listItem = category.listItem.count
                            strongSelf.collectionViewListing.reloadData()
                        }
                        
                    })

                case "Events":
                    print("Events")
                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenu, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: EventsSubMenu?, error: Error?) in
                        
                        guard let strongSelf = self else {return}
                        if let category = category{
                            strongSelf.listItemOfEachSubMenu = category
                            strongSelf.typeOfSubMenu = "Events"
                            strongSelf.listItem = category.listItem.count
                            strongSelf.collectionViewListing.reloadData()
                        }
                        
                    })

                case "Passes":
                    print("Passes")
                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenu, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: PassesSubMenu?, error: Error?) in
                        
                        guard let strongSelf = self else {return}
                        if let category = category{
                            strongSelf.listItemOfEachSubMenu = category
                            strongSelf.typeOfSubMenu = "Passes"
                            strongSelf.listItem = category.listItem.count
                            strongSelf.collectionViewListing.reloadData()
                        }
                        
                    })

                default:
                    print("")
                }
            }
            print("Attractions")
        case .Activities:
            let data = listItemOfEachTypeMenu as! OutDoorActivities
            typeMenu = data.type!
            if let typeSubMenu = data.listSubMenu[section].type{
                inputTextSearchTf.text =  typeMenu + " - " + typeSubMenu
                switch typeSubMenu{
                case "Cruises,SaiLing And Water Tour":
                    print("Cruises,SaiLing And Water Tour")
                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenu, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: CruisesSaiLingAndWaterTourSubMenu?, error: Error?) in
                        
                        guard let strongSelf = self else {return}
                        if let category = category{
                            strongSelf.listItemOfEachSubMenu = category
                            strongSelf.typeOfSubMenu = "Cruises,SaiLing And Water Tour"
                            strongSelf.listItem = category.listItem.count
                            strongSelf.collectionViewListing.reloadData()
                        }
                        
                    })

                case "Walking And Biking Tour":
                    print("Walking And Biking Tour")
                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenu, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: WalkingBikingTourSubMenu?, error: Error?) in
                        
                        guard let strongSelf = self else {return}
                        if let category = category{
                            strongSelf.listItemOfEachSubMenu = category
                            strongSelf.typeOfSubMenu = "Walking And Biking Tour"
                            strongSelf.listItem = category.listItem.count
                            strongSelf.collectionViewListing.reloadData()
                        }
                        
                    })

                case "Climbing And Trekking Tour":
                    print("Climbing And Trekking Tour")
                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenu, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: ClimbingAndTrekkingTourSubMenu?, error: Error?) in
                        
                        guard let strongSelf = self else {return}
                        if let category = category{
                            strongSelf.listItemOfEachSubMenu = category
                            strongSelf.typeOfSubMenu = "Climbing And Trekking Tour"
                            strongSelf.listItem = category.listItem.count
                            strongSelf.collectionViewListing.reloadData()
                        }
                        
                    })

                default:
                    print("")
                }
                
            }
            print("Activities")
        case .Experiences:
            let data = listItemOfEachTypeMenu as! CustomExperiences
            typeMenu = data.type!
            if let typeSubMenu = data.listSubMenu[section].type{
                inputTextSearchTf.text = typeMenu + " - " + typeSubMenu
                switch typeSubMenu{
                case "Nightlife":
                    print("Nightlife")
                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenu, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: NightlifeSubMenu?, error: Error?) in
                        
                        guard let strongSelf = self else {return}
                        if let category = category{
                            strongSelf.listItemOfEachSubMenu = category
                            strongSelf.typeOfSubMenu = "Nightlife"
                            strongSelf.listItem = category.listItem.count
                            strongSelf.collectionViewListing.reloadData()
                        }
                        
                    })

                case "Food":
                    print("Food")
                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenu, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: FoodSubMenu?, error: Error?) in
                        
                        guard let strongSelf = self else {return}
                        if let category = category{
                            strongSelf.listItemOfEachSubMenu = category
                            strongSelf.typeOfSubMenu = "Food"
                            strongSelf.listItem = category.listItem.count
                            strongSelf.collectionViewListing.reloadData()
                        }
                        
                    })

                case "Shopping":
                    print("Shopping")
                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenu, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: ShoppingSubMenu?, error: Error?) in
                        
                        guard let strongSelf = self else {return}
                        if let category = category{
                            strongSelf.listItemOfEachSubMenu = category
                            strongSelf.typeOfSubMenu = "Shopping"
                            strongSelf.listItem = category.listItem.count
                            strongSelf.collectionViewListing.reloadData()
                        }
                        
                    })

                case "Local life":
                    print("Local life")
                    RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenu, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: LocalLifeSubMenu?, error: Error?) in
                        
                        guard let strongSelf = self else {return}
                        if let category = category{
                            strongSelf.listItemOfEachSubMenu = category
                            strongSelf.typeOfSubMenu = "Local life"
                            strongSelf.listItem = category.listItem.count
                            strongSelf.collectionViewListing.reloadData()
                        }
                        
                    })

                default:
                    print("")
                }
                
            }
            print("Experiences")
        default:
            print("")
        }
        //inputTextSearchTf.textAlignment = .right
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
                //view.targetView.layer.cornerRadius = view.targetView.frame.width / 6
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
            case .Experiences:
                let data = listItemOfEachTypeMenu as! CustomExperiences
                view.nameOfCarousel.text = data.listSubMenu[section].type
                print(data)
            default:
                print("")
            }
            //view.nameOfCarousel.text = listID[section].type
//            view.targetView.layer.cornerRadius = view.targetView.frame.width / 6
            view.seeAllBtn.tag = section
            view.seeAllBtn.addTarget(self, action: #selector(showAllItemOfSubMenu(sender:)), for: .touchUpInside)
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableview cell pressed")
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

