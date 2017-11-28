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
            switch typeOfMenu{
            case .Activities:
                let data = listItemOfEachTypeMenu as! OutDoorActivities
                print("")
            case .Attractions:
                let data = listItemOfEachTypeMenu as! ShowAndAttrachtions
                print("")
            case .BestSeller:
                let data = listItemOfEachTypeMenu as! BestSellerMenu
                print("")
            case .Daytrip:
                
                var urlStr: String!
                var typeOfTour: String!
                var nameTour: String!
                var priceTour: Double!
                var ratingTour: Float!
                
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
                let data = listItemOfEachTypeMenu as! CustomExperiences
                print("")
            case .FTPickes:
                let data = listItemOfEachTypeMenu as! FTPickesMenu
                print("")
            case .MultiDayTrip:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewHomeCollectionCell", for: indexPath)
                var urlStr: String!
                var typeOfTour: String!
                var nameTour: String!
                var priceTour: Double!
                var ratingTour: Float!
                
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
                let data = listItemOfEachTypeMenu as! WishListMenu
                print("")
            case .Recentlies:
                let data = listItemOfEachTypeMenu as! RecentlyMenu
                print("")
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
        }
    }
    
}
