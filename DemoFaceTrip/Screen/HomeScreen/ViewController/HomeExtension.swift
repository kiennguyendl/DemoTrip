//
//  HomeExtension.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

var pointCell: CGPoint!
extension HomeViewController: HomeCellDelegate{
    
//    func pressentView(vc: UIViewController, point: CGPoint) {
//        //present(vc, animated: true, completion: nil)
//        let vc = DetailViewController()
//        vc.transitioningDelegate = self
//        vc.modalPresentationStyle = .custom
//        pointCell = point
//        present(vc, animated: true, completion: nil)
////        navigationController?.pushViewController(vc, animated: true)
//    }
    
    func didPressCellItem(typeMenu: typeOfCategoryMenu) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func didPressCellSubMenu(typeMenu: typeOfCategoryMenu, typeMenuStr: String, typeSubMenu: String) {
        menuBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        isBackBtn = true
        isMenuBtn = false
        if Settings.isScaleMenuView!{
            moveDownCarouselsView()
        }
        tableViewCarousels.isHidden = true
        tableViewSubMenu.isHidden = true
        collectionViewListing.isHidden = false
        typeOfMenu = typeMenu
        switch typeMenu {
        case .Attractions:
            
            inputTextSearchTf.text = Settings.cityPicked! + " - " + typeMenuStr + " - " + typeSubMenu
            switch typeSubMenu{
            case "Show And Concerts":
                print("Show And Concerts")
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenuStr, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: ShowAndConcertsSubMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachSubMenu = category
                        strongSelf.typeOfSubMenu = typeSubMenu
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                
            case "Sightseeing Tickets":
                print("Sightseeing Tickets")
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenuStr, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: SightseeingTicketsSubMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachSubMenu = category
                        strongSelf.typeOfSubMenu = typeSubMenu
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                
            case "Events":
                print("Events")
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenuStr, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: EventsSubMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachSubMenu = category
                        strongSelf.typeOfSubMenu = typeSubMenu
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                
            case "Passes":
                print("Passes")
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenuStr, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: PassesSubMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachSubMenu = category
                        strongSelf.typeOfSubMenu = typeSubMenu
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                
            default:
                print("")
            }
            
            print("")
        case .Activities:
            inputTextSearchTf.text = Settings.cityPicked! + " - " + typeMenuStr + " - " + typeSubMenu
            switch typeSubMenu{
            case "Cruises,SaiLing And Water Tour":
                print("Cruises,SaiLing And Water Tour")
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenuStr, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: CruisesSaiLingAndWaterTourSubMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachSubMenu = category
                        strongSelf.typeOfSubMenu = typeSubMenu
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                
            case "Walking And Biking Tour":
                print("Walking And Biking Tour")
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenuStr, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: WalkingBikingTourSubMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachSubMenu = category
                        strongSelf.typeOfSubMenu = typeSubMenu
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                
            case "Climbing And Trekking Tour":
                print("Climbing And Trekking Tour")
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenuStr, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: ClimbingAndTrekkingTourSubMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachSubMenu = category
                        strongSelf.typeOfSubMenu = typeSubMenu
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                
            default:
                print("")
            }
            
        case .Experiences:
            
            inputTextSearchTf.text = Settings.cityPicked! + " - " + typeMenuStr + " - " + typeSubMenu
            switch typeSubMenu{
            case "Nightlife":
                print("Nightlife")
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenuStr, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: NightlifeSubMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachSubMenu = category
                        strongSelf.typeOfSubMenu = typeSubMenu
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                
            case "Food":
                print("Food")
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenuStr, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: FoodSubMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachSubMenu = category
                        strongSelf.typeOfSubMenu = typeSubMenu
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                
            case "Shopping":
                print("Shopping")
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenuStr, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: ShoppingSubMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachSubMenu = category
                        strongSelf.typeOfSubMenu = typeSubMenu
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                
            case "Local life":
                print("Local life")
                RestDataManager.shareInstance.restDataForListingScrenFollowTypeOfMenu(urlForHome, menu: "listing", action: "getlisting", idCity: city.id!, type: typeMenuStr, typeSubMenu: typeSubMenu, complertionHandler: {[weak self ](category: LocalLifeSubMenu?, error: Error?) in
                    
                    guard let strongSelf = self else {return}
                    if let category = category{
                        strongSelf.listItemOfEachSubMenu = category
                        strongSelf.typeOfSubMenu = typeSubMenu
                        strongSelf.listItem = category.listItem.count
                        strongSelf.collectionViewListing.reloadData()
                    }
                    
                })
                
            default:
                print("")
            }
            
        default:
            print("")
        }
    }
    //    func didPressCell() {
    //        let vc = DetailViewController()
    //
    //        self.navigationController?.pushViewController(vc, animated: true)
    //    }
    
}

extension HomeViewController: SubMenuProtocol{
    func didPressCellOnSubMenu() {
        
//        let vc = DetailViewController()
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
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
            typeMenu = typeStr
            switch type {
            case .Attractions:
                tableViewCarousels.isHidden = true
                collectionViewListing.isHidden = true
                tableViewSubMenu.isHidden = false
                inputTextSearchTf.text = Settings.cityPicked! + " - " + typeStr
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
                inputTextSearchTf.text = Settings.cityPicked! + " - " + typeStr
                
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
                inputTextSearchTf.text = Settings.cityPicked! + " - " + typeStr
                
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
                inputTextSearchTf.text = Settings.cityPicked! + " - " + typeStr
                
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
                inputTextSearchTf.text = Settings.cityPicked! + " - " + typeStr
                
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

extension HomeViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = pointCell
        //transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = pointCell
       // transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
}
//
//extension HomeViewController: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        // In this method belonging to the protocol UINavigationControllerDelegate you must
//        // return an animator conforming to the protocol UIViewControllerAnimatedTransitioning.
//        // To perform the Pop in and Out animation PopInAndOutAnimator should be returned
//        return PopInAndOutAnimator(operation: operation)
//    }
//}

