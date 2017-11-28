//
//  HomeExtension.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

//extension HomeViewController: HomeCellDelegate{
//    func didPressCell(currentSection: Int, index: Int, type: catagoryType) {
//        let vc = DetailViewController()
//        vc.type = type
//        //self.setColorForMenuView()
//        if let items = catagory[currentSection].catagoryItems   {
//            switch type {
//            case .attractionType:
//                let item = items[index] as? Attraction
//                vc.item = item
//            case .themParkType:
//                let item = items[index] as? ThemeParks
//                vc.item = item
//            case .localGuideType:
//                let item = items[index] as? LocalGuide
//                vc.item = item
//            case .experienceType:
//                let item = items[index] as? Experience
//                vc.item = item
//            case .cityTourType:
//                let item = items[index] as? CityTour
//                vc.item = item
//            case .foodTourType:
//                let item = items[index] as? FoodTour
//                vc.item = item
//            case .hotelType:
//                let item = items[index] as? Hotel
//                vc.item = item
//            case .travelAgencyType:
//                let item = items[index] as? TravelAgency
//                vc.item = item
//            default:
//                print("")
//            }
//        }
//        self.setWhiteColorForStatusBar()
//        //Settings.isScaleMenuView = false
//        HomeViewController.verticalContentOffset = self.tableViewCarousels.contentOffset.y
//        self.tableViewCarousels.isScrollEnabled = false
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//}
//
extension HomeViewController: HeaderZeroProtocol{
    
    func didPressOnCellHeaderZero(menu: CategoryMenu) {
        //let vc = ListingViewController()
        //vc.typeCatagory = type
        //vc.listDetail = dataForMenu2[index].catagoryItems
        //navigationController?.pushViewController(vc, animated: true)
        
        menuBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        isBackBtn = true
        isMenuBtn = false
        if Settings.isScaleMenuView!{
            moveDownCarouselsView()
        }
        //for index in listID{
        let type = menu.typeOfMenu
        if let typeStr = menu.type{
        switch type {
        case .Attractions:
            tableViewCarousels.isHidden = true
            collectionViewListing.isHidden = true
            tableViewSubMenu.isHidden = false
            
            RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu( urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeStr, typeSubMenu: "", complertionHandler: {[weak self ](category: ShowAndAttrachtions?, error: Error?) in
                guard let strongSelf = self else {return}
                if let category = category{
                    strongSelf.listItemOfEachTypeMenu = category
                    strongSelf.typeOfMenu = type
                    strongSelf.listNumSubMenu = category.listSubMenu.count
                    strongSelf.tableViewSubMenu.reloadData()
                }
            })
        case .Daytrip:
            tableViewCarousels.isHidden = true
            collectionViewListing.isHidden = false
            tableViewSubMenu.isHidden = true
            RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeStr, typeSubMenu: "", complertionHandler: {[weak self ](category: DayTripAndExcursionsTourMenu?, error: Error?) in
                
                guard let strongSelf = self else {return}
                if let category = category{
                    strongSelf.listItemOfEachTypeMenu = category
                    strongSelf.typeOfMenu = type
                    strongSelf.listItem = category.listItem.count
                    strongSelf.collectionViewListing.reloadData()
                }
                
            })
        case .MultiDayTrip:
            tableViewCarousels.isHidden = true
            collectionViewListing.isHidden = false
            tableViewSubMenu.isHidden = true
            RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeStr, typeSubMenu: "", complertionHandler: {[weak self ](category: MultiDayTripAndExcursionsTourMenu?, error: Error?) in
                
                guard let strongSelf = self else {return}
                if let category = category{
                    strongSelf.listItemOfEachTypeMenu = category
                    strongSelf.typeOfMenu = type
                    strongSelf.listItem = category.listItem.count
                    strongSelf.collectionViewListing.reloadData()
                }
                
            })
        case .Activities:
            tableViewCarousels.isHidden = true
            collectionViewListing.isHidden = true
            tableViewSubMenu.isHidden = false
            
            RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeStr, typeSubMenu: "", complertionHandler: {[weak self ](category: OutDoorActivities?, error: Error?) in
                
                guard let strongSelf = self else {return}
                if let category = category{
                    strongSelf.listItemOfEachTypeMenu = category
                    strongSelf.typeOfMenu = type
                    strongSelf.listNumSubMenu = category.listSubMenu.count
                    strongSelf.tableViewSubMenu.reloadData()
                }
                
            })
        case .Experiences:
            tableViewCarousels.isHidden = true
            collectionViewListing.isHidden = true
            tableViewSubMenu.isHidden = false
            
            RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeStr, typeSubMenu: "", complertionHandler: {[weak self ](category: CustomExperiences?, error: Error?) in
                
                guard let strongSelf = self else {return}
                if let category = category{
                    strongSelf.listItemOfEachTypeMenu = category
                    strongSelf.typeOfMenu = type
                    strongSelf.listNumSubMenu = category.listSubMenu.count
                    strongSelf.tableViewSubMenu.reloadData()
                }
                
            })
        default:
            print("")
        }
        
        }
        
    }
    
}

extension HomeViewController: ChooseCityProtocol{
    func loadDataForHome(city: City) {
        inputTextSearchTf.text = Settings.cityPicked
        let cityData: Data = NSKeyedArchiver.archivedData(withRootObject: city)
        Settings.city = cityData
        self.city = city
        self.listID = city.listID!
        tableViewCarousels.reloadData()
        
        //        self.restDataForHome()
    }
    
}

extension HomeViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("test")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
