//
//  HomeCollectionViewDelegate+DataSource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

//CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewCarousels{
            return listCarousel.count
        }else{
            return listItem
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViewCarousels{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselsCollectionViewCell
            cell.nameCarousel.text = listCarousel[indexPath.row].uppercased()
            
            cell.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
            if Settings.isScaleMenuView!{
                
                if self.indexPathSelected == indexPath{
                    cell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                    cell.nameCarousel.textColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                }else{
                    cell.viewColor.backgroundColor = UIColor.white
                    cell.nameCarousel.textColor = UIColor.gray
                }
                cell.backgroundColor = UIColor.white
            }else{
                if indexPath == indexPathSelected{
                    cell.viewColor.backgroundColor = UIColor.white
                    cell.nameCarousel.textColor = UIColor.white
                    //self.collectionViewCarousels.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
                }else{
                    cell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                    cell.nameCarousel.textColor = color4
                }
                cell.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
            }
            
            //cell.nameCarousel.text = menuCatagory1[indexPath.row].uppercased()
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewHomeCollectionCell", for: indexPath) as! NewHomeCollectionViewCell
            let currentRow = indexPath.item
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
            switch typeOfMenu{
            case .Activities:
                
                switch typeOfSubMenu{
                case "Cruises,SaiLing And Water Tour":
                    print("Cruises,SaiLing And Water Tour")
                    
                    if let data = listItemOfEachSubMenu as? CruisesSaiLingAndWaterTourSubMenu{
                        if let urlImg = data.listItem[currentRow].imageURL{
                            urlStr = urlImg
                        }
                        if let name = data.listItem[currentRow].name{
                            nameTour = name
                        }
                        
                        if let price = data.listItem[currentRow].price{
                            priceTour = Double(price)
                        }
                        typeOfTour = "workshop"
                        
                        if let rating = data.listItem[currentRow].rating{
                            ratingTour = rating
                        }else{
                            ratingTour = 0
                        }
                    }
                    
                    return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
                case "Walking And Biking Tour":
                    print("Walking And Biking Tour")
                    
                    if let data = listItemOfEachSubMenu as? WalkingBikingTourSubMenu{
                        if let urlImg = data.listItem[currentRow].imageURL{
                            urlStr = urlImg
                        }
                        if let name = data.listItem[currentRow].name{
                            nameTour = name
                        }
                        
                        if let price = data.listItem[currentRow].price{
                            priceTour = Double(price)
                        }
                        typeOfTour = "workshop"
                        
                        if let rating = data.listItem[currentRow].rating{
                            ratingTour = rating
                        }else{
                            ratingTour = 0
                        }
                    }
                    
                    return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
                case "Climbing And Trekking Tour":
                    print("Climbing And Trekking Tour")
                    
                    if let data = listItemOfEachSubMenu as? ClimbingAndTrekkingTourSubMenu{
                        if let urlImg = data.listItem[currentRow].imageURL{
                            urlStr = urlImg
                        }
                        if let name = data.listItem[currentRow].name{
                            nameTour = name
                        }
                        
                        if let price = data.listItem[currentRow].price{
                            priceTour = Double(price)
                        }
                        typeOfTour = "workshop"
                        
                        if let rating = data.listItem[currentRow].rating{
                            ratingTour = rating
                        }else{
                            ratingTour = 0
                        }
                    }
                    
                    return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
                default:
                    print("")
                }
                print("")
            case .Attractions:
                
                switch typeOfSubMenu{
                case "Show And Concerts":
                    print("Show And Concerts")
                    
                    if let data = listItemOfEachSubMenu as? ShowAndConcertsSubMenu{
                        if let urlImg = data.listItem[currentRow].imageURL{
                            urlStr = urlImg
                        }
                        if let name = data.listItem[currentRow].name{
                            nameTour = name
                        }
                        
                        if let price = data.listItem[currentRow].price{
                            priceTour = Double(price)
                        }
                        typeOfTour = "workshop"
                        
                        if let rating = data.listItem[currentRow].rating{
                            ratingTour = rating
                        }else{
                            ratingTour = 0
                        }
                    }
                    
                    return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
                case "Sightseeing Tickets":
                    print("Sightseeing Tickets")
                    
                    if let data = listItemOfEachSubMenu as? SightseeingTicketsSubMenu{
                        if let urlImg = data.listItem[currentRow].imageURL{
                            urlStr = urlImg
                        }
                        if let name = data.listItem[currentRow].name{
                            nameTour = name
                        }
                        
                        if let price = data.listItem[currentRow].price{
                            priceTour = Double(price)
                        }
                        typeOfTour = "workshop"
                        
                        if let rating = data.listItem[currentRow].rating{
                            ratingTour = rating
                        }else{
                            ratingTour = 0
                        }
                    }
                    
                    return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
                case "Events":
                    print("Events")
                    
                    if let data = listItemOfEachSubMenu as? EventsSubMenu{
                        if let urlImg = data.listItem[currentRow].imageURL{
                            urlStr = urlImg
                        }
                        if let name = data.listItem[currentRow].name{
                            nameTour = name
                        }
                        
                        if let price = data.listItem[currentRow].price{
                            priceTour = Double(price)
                        }
                        typeOfTour = "workshop"
                        
                        if let rating = data.listItem[currentRow].rating{
                            ratingTour = rating
                        }else{
                            ratingTour = 0
                        }
                    }
                    
                    return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
                case "Passes":
                    print("Passes")
                    
                    if let data = listItemOfEachSubMenu as? PassesSubMenu{
                        if let urlImg = data.listItem[currentRow].imageURL{
                            urlStr = urlImg
                        }
                        if let name = data.listItem[currentRow].name{
                            nameTour = name
                        }
                        
                        if let price = data.listItem[currentRow].price{
                            priceTour = Double(price)
                        }
                        typeOfTour = "workshop"
                        
                        if let rating = data.listItem[currentRow].rating{
                            ratingTour = rating
                        }else{
                            ratingTour = 0
                        }
                    }
                    
                    return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
                default:
                    print("")
                }
                print("")
            case .BestSeller:
                
                if let data = listItemOfEachTypeMenu as? BestSellerMenu{
                    if let urlImg = data.listItem[currentRow].imageURL{
                        urlStr = urlImg
                    }
                    if let name = data.listItem[currentRow].name{
                        nameTour = name
                    }
                    
                    if let price = data.listItem[currentRow].price{
                        priceTour = Double(price)
                    }
                    typeOfTour = "workshop"
                    
                    if let rating = data.listItem[currentRow].rating{
                        ratingTour = rating
                    }else{
                        ratingTour = 0
                    }
                }
                
                return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
            case .Daytrip:
                
                if let data = listItemOfEachTypeMenu as? DayTripAndExcursionsTourMenu{
                    if let urlImg = data.listItem[currentRow].imageURL{
                        urlStr = urlImg
                    }
                    if let name = data.listItem[currentRow].name{
                        nameTour = name
                    }
                    
                    if let price = data.listItem[currentRow].price{
                        priceTour = Double(price)
                    }
                    typeOfTour = "workshop"
                    
                    if let rating = data.listItem[currentRow].rating{
                        ratingTour = rating
                    }else{
                        ratingTour = 0
                    }
                }
                
                return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
            case .Experiences:
                
                switch typeOfSubMenu{
                case "Nightlife":
                    print("Nightlife")
                    
                    if let data = listItemOfEachSubMenu as? NightlifeSubMenu{
                        if let urlImg = data.listItem[currentRow].imageURL{
                            urlStr = urlImg
                        }
                        if let name = data.listItem[currentRow].name{
                            nameTour = name
                        }
                        
                        if let price = data.listItem[currentRow].price{
                            priceTour = Double(price)
                        }
                        typeOfTour = "workshop"
                        
                        if let rating = data.listItem[currentRow].rating{
                            ratingTour = rating
                        }else{
                            ratingTour = 0
                        }
                    }
                    
                    return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
                case "Food":
                    print("Food")
                    
                    if let data = listItemOfEachSubMenu as? FoodSubMenu{
                        if let urlImg = data.listItem[currentRow].imageURL{
                            urlStr = urlImg
                        }
                        if let name = data.listItem[currentRow].name{
                            nameTour = name
                        }
                        
                        if let price = data.listItem[currentRow].price{
                            priceTour = Double(price)
                        }
                        typeOfTour = "workshop"
                        
                        if let rating = data.listItem[currentRow].rating{
                            ratingTour = rating
                        }else{
                            ratingTour = 0
                        }
                    }
                    
                    return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
                case "Shopping":
                    print("Shopping")
                    
                    if let data = listItemOfEachSubMenu as? ShoppingSubMenu{
                        if let urlImg = data.listItem[currentRow].imageURL{
                            urlStr = urlImg
                        }
                        if let name = data.listItem[currentRow].name{
                            nameTour = name
                        }
                        
                        if let price = data.listItem[currentRow].price{
                            priceTour = Double(price)
                        }
                        typeOfTour = "workshop"
                        
                        if let rating = data.listItem[currentRow].rating{
                            ratingTour = rating
                        }else{
                            ratingTour = 0
                        }
                    }
                    
                    return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
                case "Local life":
                    print("Local life")
                    
                    if let data = listItemOfEachSubMenu as? LocalLifeSubMenu{
                        if let urlImg = data.listItem[currentRow].imageURL{
                            urlStr = urlImg
                        }
                        if let name = data.listItem[currentRow].name{
                            nameTour = name
                        }
                        
                        if let price = data.listItem[currentRow].price{
                            priceTour = Double(price)
                        }
                        typeOfTour = "workshop"
                        
                        if let rating = data.listItem[currentRow].rating{
                            ratingTour = rating
                        }else{
                            ratingTour = 0
                        }
                    }
                    
                    return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
                default:
                    print("")
                }
                print("")
            case .FTPickes:
                
                if let data = listItemOfEachTypeMenu as? FTPickesMenu{
                    if let urlImg = data.listItem[currentRow].imageURL{
                        urlStr = urlImg
                    }
                    if let name = data.listItem[currentRow].name{
                        nameTour = name
                    }
                    
                    if let price = data.listItem[currentRow].price{
                        priceTour = Double(price)
                    }
                    typeOfTour = "workshop"
                    
                    if let rating = data.listItem[currentRow].rating{
                        ratingTour = rating
                    }else{
                        ratingTour = 0
                    }
                }
                
                return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
            case .MultiDayTrip:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewHomeCollectionCell", for: indexPath)
                
                if let data = listItemOfEachTypeMenu as? MultiDayTripAndExcursionsTourMenu{
                    if let urlImg = data.listItem[currentRow].imageURL{
                        urlStr = urlImg
                    }
                    if let name = data.listItem[currentRow].name{
                        nameTour = name
                    }
                    
                    if let price = data.listItem[currentRow].price{
                        priceTour = Double(price)
                    }
                    typeOfTour = "workshop"
                    
                    if let rating = data.listItem[currentRow].rating{
                        ratingTour = rating
                    }else{
                        ratingTour = 0
                    }
                }
                
                return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
            case .WishList:
                
                if let data = listItemOfEachTypeMenu as? WishListMenu{
                    if let urlImg = data.listItem[currentRow].imageURL{
                        urlStr = urlImg
                    }
                    if let name = data.listItem[currentRow].name{
                        nameTour = name
                    }
                    
                    if let price = data.listItem[currentRow].price{
                        priceTour = Double(price)
                    }
                    typeOfTour = "workshop"
                    
                    if let rating = data.listItem[currentRow].rating{
                        ratingTour = rating
                    }else{
                        ratingTour = 0
                    }
                }
                
                return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
            case .Recentlies:
                
                if let data = listItemOfEachTypeMenu as? RecentlyMenu{
                    if let urlImg = data.listItem[currentRow].imageURL{
                        urlStr = urlImg
                    }
                    if let name = data.listItem[currentRow].name{
                        nameTour = name
                    }
                    
                    if let price = data.listItem[currentRow].price{
                        priceTour = Double(price)
                    }
                    typeOfTour = "workshop"
                    
                    if let rating = data.listItem[currentRow].rating{
                        ratingTour = rating
                    }else{
                        ratingTour = 0
                    }
                }
                
                return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
            case .None:
                print("")
                
            }
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewCarousels{
            var width: CGFloat = 0.0
            var height: CGFloat = 0.0
            if listCarousel.count > 1 {
                let size: CGSize = listCarousel[indexPath.row].size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)])

                width = size.width
                height = collectionViewCarousels.frame.height

            }else{
                width = collectionViewCarousels.frame.width
                height = collectionViewCarousels.frame.height
            }

            return CGSize(width: width, height: height)
        }else{
            let width = self.collectionViewListing.frame.width / 2.3
            let height = self.view.frame.size.height / 3
            return CGSize(width: width, height: height)
        }
//        }else{
//            let width = collectionViewDetail.frame.width / 2 - 10
//            return CGSize(width: width, height: width * 1.5)
//        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == collectionViewListing{
            return CGSize(width: collectionView.frame.width, height: 50.0)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == collectionViewListing{
            switch kind {
            case UICollectionElementKindSectionHeader:
                let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderViewForListing", for: indexPath) as! HeaderForListingCollectionReusableView
                switch typeOfMenu{
                case .Recentlies:
                    reusableview.nameMenuType.text = "Recentlies"
                case .WishList:
                    reusableview.nameMenuType.text = "Wish List"
                case .BestSeller:
                    reusableview.nameMenuType.text = "Best Seller"
                case .FTPickes:
                    reusableview.nameMenuType.text = "FT Pickes"

                case .Daytrip:
                    reusableview.nameMenuType.text = "Day Trip"
                case .MultiDayTrip:
                    reusableview.nameMenuType.text = "Multi Day Trip"
    
                case .Attractions, .Activities, .Experiences:
                    reusableview.nameMenuType.text = typeOfSubMenu
                case .None:
                    print("")
                }
                return reusableview
            default:  fatalError("Unexpected element kind")
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionViewCarousels{
            
//            indexPathSelected = []
//            indexPathSelected = indexPath
//            tableViewCarousels.isHidden = true
//            collectionViewDetail.isHidden = false
//            if indexPath.row > 0{
//                dataForHome.removeAll()
//                if let data = dataForMenu1[indexPath.row - 1].catagoryItems{
//                    self.dataForHome = data
//                    switch dataForMenu1[indexPath.row - 1].typeCatagory{
//                    case .localGuideType:
//                        type = .LocalGuide
//                    case .travelAgencyType:
//                        type = .TravelAgency
//                    case .hotelType:
//                        type = .Hotel
//                    case .experienceType:
//                        type = .Experience
//                    default:
//                        print("abc")
//                    }
//                }
//                collectionViewCarousels.reloadData()
//                collectionViewCarousels.scrollToItem(at: indexPathSelected, at: .centeredHorizontally, animated: true)
//                collectionViewDetail.reloadData()
//                collectionViewDetail.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredVertically, animated: true)
//            }else{
//                dataForHome.removeAll()
//                tableViewCarousels.isHidden = false
//                collectionViewDetail.isHidden = true
//                type = .ForYou
//                collectionViewCarousels.reloadData()
//                collectionViewCarousels.scrollToItem(at: indexPathSelected, at: .centeredHorizontally, animated: true)
//                tableViewCarousels.reloadData()
//            }
//            collectionViewCarousels.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//
//        }else if collectionView == collectionViewDetail{
//
//            let vc = DetailViewController()
//            let data = dataForMenu1[self.indexPathSelected.row - 1]
//            vc.type = data.typeCatagory
//            if let item = data.catagoryItems?[indexPath.row]{
//                vc.item = item
//            }
//            HomeViewController.verticalContentOffset = collectionViewDetail.contentOffset.y
//            self.navigationController?.pushViewController(vc, animated: true)
//
        }else if collectionView == collectionViewListing{
            
//             let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! NewHomeCollectionViewCell
//            cell.superview?.bringSubview(toFront: cell)
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
//                cell.frame = self.view.bounds
//            }, completion: nil)
            let vc = DetailViewController()
            
            vc.typeOfMenu = typeOfMenu
            vc.typeSubMenu = typeOfSubMenu
            
            vc.cellIndexPathPathDetailView = indexPath
            vc.delegate = self
            
            switch typeOfMenu{
            case .Activities:
                vc.typeMenu = "Activities"
                switch typeOfSubMenu{
                case "Cruises,SaiLing And Water Tour":
                    
                    if let data = listItemOfEachSubMenu as? CruisesSaiLingAndWaterTourSubMenu{
                        let idMenu = data.id!
                        let idSubMenu = data.listItem[indexPath.row].id!
                        let imageUrl = data.listItem[indexPath.row].imageURL
                        vc.idItem = idMenu
                        vc.idSubItem = idSubMenu
                        vc.imageUrl = imageUrl!
                    }

                case "Walking And Biking Tour":
                    if let data = listItemOfEachSubMenu as? WalkingBikingTourSubMenu{
                        let idMenu = data.id!
                        let idSubMenu = data.listItem[indexPath.row].id!
                        let imageUrl = data.listItem[indexPath.row].imageURL
                        vc.idItem = idMenu
                        vc.idSubItem = idSubMenu
                        vc.imageUrl = imageUrl!
                    }
                    
                case "Climbing And Trekking Tour":
                    if let data = listItemOfEachSubMenu as? ClimbingAndTrekkingTourSubMenu{
                        let idMenu = data.id!
                        let idSubMenu = data.listItem[indexPath.row].id!
                        let imageUrl = data.listItem[indexPath.row].imageURL
                        vc.idItem = idMenu
                        vc.idSubItem = idSubMenu
                        vc.imageUrl = imageUrl!
                    }
                    
                default:
                    print("")
                }
                print("")
            case .Attractions:
                vc.typeMenu = "Attractions"
                switch typeOfSubMenu{
                case "Show And Concerts":
                    if let data = listItemOfEachSubMenu as? ShowAndConcertsSubMenu{
                        let idMenu = data.id!
                        let idSubMenu = data.listItem[indexPath.row].id!
                        let imageUrl = data.listItem[indexPath.row].imageURL
                        vc.idItem = idMenu
                        vc.idSubItem = idSubMenu
                        vc.imageUrl = imageUrl!
                    }
                    
                    
                case "Sightseeing Tickets":
                    
                    if let data = listItemOfEachSubMenu as? SightseeingTicketsSubMenu{
                        let idMenu = data.id!
                        let idSubMenu = data.listItem[indexPath.row].id!
                        let imageUrl = data.listItem[indexPath.row].imageURL
                        vc.idItem = idMenu
                        vc.idSubItem = idSubMenu
                        vc.imageUrl = imageUrl!
                    }
                    
                    
                case "Events":
                    
                    if let data = listItemOfEachSubMenu as? EventsSubMenu{
                        let idMenu = data.id!
                        let idSubMenu = data.listItem[indexPath.row].id!
                        let imageUrl = data.listItem[indexPath.row].imageURL
                        vc.idItem = idMenu
                        vc.idSubItem = idSubMenu
                        vc.imageUrl = imageUrl!
                    }
                    
                    
                case "Passes":
                    
                    if let data = listItemOfEachSubMenu as? PassesSubMenu{
                        let idMenu = data.id!
                        let idSubMenu = data.listItem[indexPath.row].id!
                        let imageUrl = data.listItem[indexPath.row].imageURL
                        vc.idItem = idMenu
                        vc.idSubItem = idSubMenu
                        vc.imageUrl = imageUrl!
                    }
                    
                    
                default:
                    print("")
                }
                print("")
            case .BestSeller:
                vc.typeMenu = "BestSeller"
                if let data = listItemOfEachTypeMenu as? BestSellerMenu{
                    let id = data.listItem[indexPath.row].id!
                    let imageUrl = data.listItem[indexPath.row].imageURL
                    vc.idItem = id
                    vc.imageUrl = imageUrl!
                    
                }
                
                
            case .Daytrip:
                vc.typeMenu = "Day trip"
                if let data = listItemOfEachTypeMenu as? DayTripAndExcursionsTourMenu{
                    let id = data.listItem[indexPath.row].id!
                    let imageUrl = data.listItem[indexPath.row].imageURL
                    vc.idItem = id
                    vc.imageUrl = imageUrl!
                }
                
                
            case .Experiences:
                vc.typeMenu = "Experiences"
                switch typeOfSubMenu{
                case "Nightlife":
                    
                    if let data = listItemOfEachSubMenu as? NightlifeSubMenu{
                        let idMenu = data.id!
                        let idSubMenu = data.listItem[indexPath.row].id!
                        let imageUrl = data.listItem[indexPath.row].imageURL
                        vc.idItem = idMenu
                        vc.idSubItem = idSubMenu
                        vc.imageUrl = imageUrl!
                    }
                    
                case "Food":
                    
                    if let data = listItemOfEachSubMenu as? FoodSubMenu{
                        let idMenu = data.id!
                        let idSubMenu = data.listItem[indexPath.row].id!
                        let imageUrl = data.listItem[indexPath.row].imageURL
                        vc.idItem = idMenu
                        vc.idSubItem = idSubMenu
                        vc.imageUrl = imageUrl!
                    }
                    
                    
                case "Shopping":
                    
                    if let data = listItemOfEachSubMenu as? ShoppingSubMenu{
                        let idMenu = data.id!
                        let idSubMenu = data.listItem[indexPath.row].id!
                        let imageUrl = data.listItem[indexPath.row].imageURL
                        vc.idItem = idMenu
                        vc.idSubItem = idSubMenu
                        vc.imageUrl = imageUrl!
                    }
                    
                    
                case "Local life":
                    
                    if let data = listItemOfEachSubMenu as? LocalLifeSubMenu{
                        let idMenu = data.id!
                        let idSubMenu = data.listItem[indexPath.row].id!
                        let imageUrl = data.listItem[indexPath.row].imageURL
                        vc.idItem = idMenu
                        vc.idSubItem = idSubMenu
                        vc.imageUrl = imageUrl!
                    }
                    
                default:
                    print("")
                }
            case .FTPickes:
                vc.typeMenu = "FTPickes"
                if let data = listItemOfEachTypeMenu as? FTPickesMenu{
                    let id = data.listItem[indexPath.row].id!
                    let imageUrl = data.listItem[indexPath.row].imageURL
                    vc.idItem = id
                    vc.imageUrl = imageUrl!
                }
                
                
            case .MultiDayTrip:
                vc.typeMenu = "Multi Day Trip"
                if let data = listItemOfEachTypeMenu as? MultiDayTripAndExcursionsTourMenu{
                    let id = data.listItem[indexPath.row].id!
                    let imageUrl = data.listItem[indexPath.row].imageURL
                    vc.idItem = id
                    vc.imageUrl = imageUrl!
                }
                
            case .WishList:
                vc.typeMenu = "WishList"
                if let data = listItemOfEachTypeMenu as? WishListMenu{
                    let id = data.listItem[indexPath.row].id!
                    let imageUrl = data.listItem[indexPath.row].imageURL
                    vc.idItem = id
                    vc.imageUrl = imageUrl!
                }
                
                
            case .Recentlies:
                vc.typeMenu = "Recentlies"
                if let data = listItemOfEachTypeMenu as? RecentlyMenu{
                    let id = data.listItem[indexPath.row].id!
                    let imageUrl = data.listItem[indexPath.row].imageURL
                    vc.idItem = id
                    vc.imageUrl = imageUrl!
                }
                
                
            case .None:
                print("")
                
            }
            //vc.transitioningDelegate = self
            //present(vc, animated: true, completion: nil)
            vc.cityName = city.name
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
