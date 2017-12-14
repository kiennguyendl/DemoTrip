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

    func didPressCellItem(_ tableCell: HomeTableViewCell, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, typeMenu: typeOfCategoryMenu, typeMenuStr: String, idItem: Int, imageURL imagerURL: String) {

        let vc = DetailViewController()
        vc.typeMenu = typeMenuStr
        vc.idItem = idItem
        
        vc.tableIndexPathDetailView = tableCell.indexPathTableViewCell
        vc.cellIndexPathPathDetailView = indexPath
        vc.delegate = self
        vc.imageUrl = imagerURL
        vc.cityName = city.name
        
        /*save for animation
         
        let cell = collectionView.cellForItem(at: indexPath) as! NewHomeCollectionViewCell
        let frame = cell.convert(cell.image.frame, to: view)
        imageExpandAnimationController.originFrame = frame
        vc.transitioningDelegate = self
        changeColorMenuViewWhenPresent()
        present(vc, animated: true, completion: nil)
        */
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didPressCellSubMenu(_ tableCell: HomeTableViewCell, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, typeMenu: typeOfCategoryMenu, typeMenuStr: String, typeSubMenu: String) {
        
        menuBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        isBackBtn = true
        isMenuBtn = false
        if Settings.isScaleMenuView!{
            moveDownCarouselsView()
        }
        tableViewCarousels.isHidden = true
        tableViewSubMenu.isHidden = true
        collectionViewListing.isHidden = false
        filterView.isHidden = false
        collectionViewCarousels.isHidden = true
        inputTextSearchTf.textAlignment = .right
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
}

extension HomeViewController: SubMenuProtocol{
    
    func didPressCellOnSubMenu(_ tableCell: SubMenuTableViewCell, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, typeMenu: typeOfCategoryMenu, typeMenuStr: String, typeSubMenu: String, idItem: Int, idSubMenu: Int, imageUrl: String) {
        
        let vc = DetailViewController()
        vc.typeOfMenu = typeMenu
        vc.typeMenu = typeMenuStr
        vc.typeSubMenu = typeSubMenu
        vc.idItem = idItem
        vc.idSubItem = idSubMenu
        vc.imageUrl = imageUrl
        
        vc.tableIndexPathDetailView = tableCell.indexPathTableViewCell
        vc.cellIndexPathPathDetailView = indexPath
        vc.delegate = self
        vc.cityName = city.name
        /*
        let cell = collectionView.cellForItem(at: indexPath) as! NewHomeCollectionViewCell
        let frame = cell.convert(cell.image.frame, to: view)
        imageExpandAnimationController.originFrame = frame
        changeColorMenuViewWhenPresent()
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)
        */
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
//
extension HomeViewController: HeaderZeroProtocol{
    
    func didPressOnCellHeaderZero(menu: CategoryMenu) {
        
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
//                filterView.isHidden = false
//                collectionViewCarousels.isHidden = true
                
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
                filterView.isHidden = false
                collectionViewCarousels.isHidden = true
                
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
                filterView.isHidden = false
                collectionViewCarousels.isHidden = true
                
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
//                filterView.isHidden = false
//                collectionViewCarousels.isHidden = true
                
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
//                filterView.isHidden = false
//                collectionViewCarousels.isHidden = true
                
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
    }
    
}

extension HomeViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("test")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("")
    }
    
}

extension HomeViewController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return imageExpandAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let dismissed = dismissed as? DetailViewController else {
                return nil
        }
        let presentingVC = self
        
        if let cellIndexPath = dismissed.cellIndexPathPathDetailView {
            
            if let tableIndexPath = dismissed.tableIndexPathDetailView{
                if self.tableViewCarousels.isHidden == false && self.tableViewSubMenu.isHidden == true && self.collectionViewListing.isHidden == true{
                    let tableCell = presentingVC.tableViewCarousels.cellForRow(at: tableIndexPath) as! HomeTableViewCell
                    let collectionCell = tableCell.collectionViewForCell.cellForItem(at: cellIndexPath) as! NewHomeCollectionViewCell
                    let frame = collectionCell.convert(collectionCell.image.frame, to: view)
                    imageShrinkAnimationController.destinationFrame = frame
                }
                
                if self.tableViewCarousels.isHidden == true && self.tableViewSubMenu.isHidden == false && self.collectionViewListing.isHidden == true{
                    let tableCell = presentingVC.tableViewSubMenu.cellForRow(at: tableIndexPath) as! SubMenuTableViewCell
                    let collectionCell = tableCell.collectionViewSubMenu.cellForItem(at: cellIndexPath) as! NewHomeCollectionViewCell
                    let frame = collectionCell.convert(collectionCell.image.frame, to: view)
                    imageShrinkAnimationController.destinationFrame = frame
                }
            }else{
                
                if self.tableViewCarousels.isHidden == true && self.tableViewSubMenu.isHidden == true && self.collectionViewListing.isHidden == false{
                    
                    let collectionCell = self.collectionViewListing.cellForItem(at: cellIndexPath) as! NewHomeCollectionViewCell
                    let frame = collectionCell.convert(collectionCell.image.frame, to: view)
                    imageShrinkAnimationController.destinationFrame = frame
                }
            }
        }
        

        return imageShrinkAnimationController
    }
    
}

extension HomeViewController: changeColorOfMenuViewHome{
    func changeColor() {
        DispatchQueue.main.async {
//             self.setColorMenuViewWhenDismiss()
        }
       
        
        
    }
}

