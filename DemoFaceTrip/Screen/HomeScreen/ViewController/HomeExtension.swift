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
    
    func didPressOnCellHeaderZero(id: Int, type: String) {
        //let vc = ListingViewController()
        //vc.typeCatagory = type
        //vc.listDetail = dataForMenu2[index].catagoryItems
        //navigationController?.pushViewController(vc, animated: true)
        tableViewCarousels.isHidden = true
        collectionViewListing.isHidden = false
        menuBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        isBackBtn = true
        isMenuBtn = false
        if Settings.isScaleMenuView!{
            moveDownCarouselsView()
        }
        //for index in listID{
            switch type {
            case "Attractions":
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu( urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: type, typeSubMenu: "", complertionHandler: {(category: ShowAndAttrachtions?, error: Error?) in
                    if let category = category{
                        print(category)
                    }
                })
            case "Day trip":
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: type, typeSubMenu: "", complertionHandler: {(category: DayTripAndExcursionsTourMenu?, error: Error?) in
                    if let category = category{
                        
                        print(category)
                    }
                })
            case "Multi Day Trip":
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: type, typeSubMenu: "", complertionHandler: {(category: MultiDayTripAndExcursionsTourMenu?, error: Error?) in
                    if let category = category{
                        
                        print(category)
                    }
                })
            case "Activities":
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: type, typeSubMenu: "", complertionHandler: {(category: OutDoorActivities?, error: Error?) in
                    if let category = category{
                        
                        print(category)
                    }
                })
            case "Experiences":
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: type, typeSubMenu: "", complertionHandler: {(category: CustomExperiences?, error: Error?) in
                    if let category = category{
                        
                        print(category)
                    }
                })
            default:
                print("")
            }
            
        //}
        
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
