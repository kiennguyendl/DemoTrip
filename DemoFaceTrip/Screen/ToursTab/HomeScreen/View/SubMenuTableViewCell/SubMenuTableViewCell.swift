//
//  SubMenuTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

protocol SubMenuProtocol {
    func didPressCellOnSubMenu(_ tableCell: SubMenuTableViewCell, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, typeMenu: typeOfCategoryMenu, typeMenuStr: String, typeSubMenu: String, idItem: Int, idSubMenu: Int, imageUrl: String)
}

class SubMenuTableViewCell: UITableViewCell {
    
    var indexPathTableViewCell: IndexPath?
    
    @IBOutlet weak var collectionViewSubMenu: UICollectionView!
    var typeOfMenu: typeOfCategoryMenu = .None
    var typeMenu = ""
    var idMenu: Int = 0
    var typeOfSubMenu = ""
    var numberOfRow = 0
    var delegate: SubMenuProtocol?
    var categorySubMenu: AnyObject?{
        didSet{
            switch typeOfSubMenu {
            case "Show And Concerts":
                if let categorySubMenu = categorySubMenu{
                    let data = categorySubMenu as! ShowAndConcertsSubMenu
                    numberOfRow = data.listItem.count
                }
                print("")
                break
            case "Sightseeing Tickets":
                if let categorySubMenu = categorySubMenu{
                    let data = categorySubMenu as! SightseeingTicketsSubMenu
                    numberOfRow = data.listItem.count
                }
                print("")
                break
            case "Events":
                if let categorySubMenu = categorySubMenu{
                    let data = categorySubMenu as! EventsSubMenu
                    numberOfRow = data.listItem.count
                }
                print("")
                break
            case "Passes":
                if let categorySubMenu = categorySubMenu{
                    let data = categorySubMenu as! PassesSubMenu
                    numberOfRow = data.listItem.count
                }
                print("")
                break
            case "Cruises,SaiLing And Water Tour":
                if let categorySubMenu = categorySubMenu{
                    let data = categorySubMenu as! CruisesSaiLingAndWaterTourSubMenu
                    numberOfRow = data.listItem.count
                }
                print("")
                break
            case "Walking And Biking Tour":
                if let categorySubMenu = categorySubMenu{
                    let data = categorySubMenu as! WalkingBikingTourSubMenu
                    numberOfRow = data.listItem.count
                }
                print("")
                break
            case "Climbing And Trekking Tour":
                if let categorySubMenu = categorySubMenu{
                    let data = categorySubMenu as! ClimbingAndTrekkingTourSubMenu
                    numberOfRow = data.listItem.count
                }
                print("")
                break
            case "Nightlife":
                if let categorySubMenu = categorySubMenu{
                    let data = categorySubMenu as! NightlifeSubMenu
                    numberOfRow = data.listItem.count
                }
                print("")
                break
            case "Food":
                if let categorySubMenu = categorySubMenu{
                    let data = categorySubMenu as! FoodSubMenu
                    numberOfRow = data.listItem.count
                }
                print("")
                break
            case "Shopping":
                if let categorySubMenu = categorySubMenu{
                    let data = categorySubMenu as! ShoppingSubMenu
                    numberOfRow = data.listItem.count
                }
                print("")
                break
            case "Local life":
                if let categorySubMenu = categorySubMenu{
                    let data = categorySubMenu as! LocalLifeSubMenu
                    numberOfRow = data.listItem.count
                }
                print("")
                break
            default:
                print("")
            }
            collectionViewSubMenu.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewSubMenu.delegate = self
        collectionViewSubMenu.dataSource = self
        collectionViewSubMenu.register(UINib.init(nibName: "NewHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewHomeCollectionCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension SubMenuTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if numberOfRow >= 4{
            return 4
        }
        return numberOfRow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewHomeCollectionCell", for: indexPath) as! NewHomeCollectionViewCell
        let currentItem = indexPath.row
        
        var urlStr: String!
        var typeOfTour: String!
        var nameTour: String!
        var priceTour: Double!
        var ratingTour: Float!
        
        switch typeOfSubMenu {
        case "Show And Concerts":
            
            
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! ShowAndConcertsSubMenu
                if let urlImg = data.listItem[currentItem].imageURL{
                    urlStr = urlImg
                }
                if let name = data.listItem[currentItem].name{
                    nameTour = name
                }
                
                if let price = data.listItem[currentItem].price{
                    priceTour = Double(price)
                }
                typeOfTour = "workshop"
                
                if let rating = data.listItem[currentItem].rating{
                    ratingTour = rating
                }else{
                    ratingTour = 0
                }
            }
            return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case "Sightseeing Tickets":
            
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! SightseeingTicketsSubMenu
                if let urlImg = data.listItem[currentItem].imageURL{
                    urlStr = urlImg
                }
                if let name = data.listItem[currentItem].name{
                    nameTour = name
                }
                
                if let price = data.listItem[currentItem].price{
                    priceTour = Double(price)
                }
                typeOfTour = "workshop"
                
                if let rating = data.listItem[currentItem].rating{
                    ratingTour = rating
                }else{
                    ratingTour = 0
                }
            }
            return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case "Events":
            
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! EventsSubMenu
                if let urlImg = data.listItem[currentItem].imageURL{
                    urlStr = urlImg
                }
                if let name = data.listItem[currentItem].name{
                    nameTour = name
                }
                
                if let price = data.listItem[currentItem].price{
                    priceTour = Double(price)
                }
                typeOfTour = "workshop"
                
                if let rating = data.listItem[currentItem].rating{
                    ratingTour = rating
                }else{
                    ratingTour = 0
                }
            }
            return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case "Passes":
            
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! PassesSubMenu
                if let urlImg = data.listItem[currentItem].imageURL{
                    urlStr = urlImg
                }
                if let name = data.listItem[currentItem].name{
                    nameTour = name
                }
                
                if let price = data.listItem[currentItem].price{
                    priceTour = Double(price)
                }
                typeOfTour = "workshop"
                
                if let rating = data.listItem[currentItem].rating{
                    ratingTour = rating
                }else{
                    ratingTour = 0
                }
            }
            return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case "Cruises,SaiLing And Water Tour":
            
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! CruisesSaiLingAndWaterTourSubMenu
                if let urlImg = data.listItem[currentItem].imageURL{
                    urlStr = urlImg
                }
                if let name = data.listItem[currentItem].name{
                    nameTour = name
                }
                
                if let price = data.listItem[currentItem].price{
                    priceTour = Double(price)
                }
                typeOfTour = "workshop"
                
                if let rating = data.listItem[currentItem].rating{
                    ratingTour = rating
                }else{
                    ratingTour = 0
                }
            }
            return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case "Walking And Biking Tour":
            
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! WalkingBikingTourSubMenu
                if let urlImg = data.listItem[currentItem].imageURL{
                    urlStr = urlImg
                }
                if let name = data.listItem[currentItem].name{
                    nameTour = name
                }
                
                if let price = data.listItem[currentItem].price{
                    priceTour = Double(price)
                }
                typeOfTour = "workshop"
                
                if let rating = data.listItem[currentItem].rating{
                    ratingTour = rating
                }else{
                    ratingTour = 0
                }
            }
            return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case "Climbing And Trekking Tour":
            
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! ClimbingAndTrekkingTourSubMenu
                if let urlImg = data.listItem[currentItem].imageURL{
                    urlStr = urlImg
                }
                if let name = data.listItem[currentItem].name{
                    nameTour = name
                }
                
                if let price = data.listItem[currentItem].price{
                    priceTour = Double(price)
                }
                typeOfTour = "workshop"
                
                if let rating = data.listItem[currentItem].rating{
                    ratingTour = rating
                }else{
                    ratingTour = 0
                }
            }
            return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case "Nightlife":
            
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! NightlifeSubMenu
                if let urlImg = data.listItem[currentItem].imageURL{
                    urlStr = urlImg
                }
                if let name = data.listItem[currentItem].name{
                    nameTour = name
                }
                
                if let price = data.listItem[currentItem].price{
                    priceTour = Double(price)
                }
                typeOfTour = "workshop"
                
                if let rating = data.listItem[currentItem].rating{
                    ratingTour = rating
                }else{
                    ratingTour = 0
                }
            }
            return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case "Food":
            
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! FoodSubMenu
                if let urlImg = data.listItem[currentItem].imageURL{
                    urlStr = urlImg
                }
                if let name = data.listItem[currentItem].name{
                    nameTour = name
                }
                
                if let price = data.listItem[currentItem].price{
                    priceTour = Double(price)
                }
                typeOfTour = "workshop"
                
                if let rating = data.listItem[currentItem].rating{
                    ratingTour = rating
                }else{
                    ratingTour = 0
                }
            }
            print("")
            return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case "Shopping":
            
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! ShoppingSubMenu
                if let urlImg = data.listItem[currentItem].imageURL{
                    urlStr = urlImg
                }
                if let name = data.listItem[currentItem].name{
                    nameTour = name
                }
                
                if let price = data.listItem[currentItem].price{
                    priceTour = Double(price)
                }
                typeOfTour = "workshop"
                
                if let rating = data.listItem[currentItem].rating{
                    ratingTour = rating
                }else{
                    ratingTour = 0
                }
            }
            return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case "Local life":
            
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! LocalLifeSubMenu
                if let urlImg = data.listItem[currentItem].imageURL{
                    urlStr = urlImg
                }
                if let name = data.listItem[currentItem].name{
                    nameTour = name
                }
                
                if let price = data.listItem[currentItem].price{
                    priceTour = Double(price)
                }
                typeOfTour = "workshop"
                
                if let rating = data.listItem[currentItem].rating{
                    ratingTour = rating
                }else{
                    ratingTour = 0
                }
                
            }
            return collectionView.setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        default:
            print("")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var witdh: CGFloat = 0
        var height: CGFloat = 0
        witdh = collectionView.frame.width / 2.3
        height = self.frame.height
        return CGSize(width: witdh, height: height )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var typeMenuStr = ""
//        switch typeOfMenu {
//        case .Activities:
//            typeMenuStr = "Activities"
//            if let catagory = categorySubMenu{
//                let data = catagory as! OutDoorActivities
//                let idSubMenu = data.listSubMenu[indexPath.row].id
//                delegate?.didPressCellOnSubMenu(typeMenu: typeOfMenu, typeMenuStr: typeMenuStr, typeSubMenu: typeOfSubMenu, idItem: idMenu, idSubMenu: idSubMenu!)
//            }
//
//        case .Attractions:
//            typeMenuStr = "Attractions"
//            if let catagory = categorySubMenu{
//                let data = catagory as! OutDoorActivities
//                let idSubMenu = data.listSubMenu[indexPath.row].id
//                delegate?.didPressCellOnSubMenu(typeMenu: typeOfMenu, typeMenuStr: typeMenuStr, typeSubMenu: typeOfSubMenu, idItem: idMenu, idSubMenu: idSubMenu!)
//            }
//        case .Experiences:
//            typeMenuStr = "Experiences"
//            if let catagory = categorySubMenu{
//                let data = catagory as! CustomExperiences
//                let idSubMenu = data.listSubMenu[indexPath.row].id
//                delegate?.didPressCellOnSubMenu(typeMenu: typeOfMenu, typeMenuStr: typeMenuStr, typeSubMenu: typeOfSubMenu, idItem: idMenu, idSubMenu: idSubMenu!)
//            }
//        default:
//            print("")
//        }
        
        switch typeOfSubMenu {
        case "Show And Concerts":
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! ShowAndConcertsSubMenu
                let idOfMenu = data.id!
                let idSubMenu = data.listItem[indexPath.row].id
                let imageUrl = data.listItem[indexPath.row].imageURL
                delegate?.didPressCellOnSubMenu(self, collectionView: collectionViewSubMenu, didSelectItemAt: indexPath, typeMenu: typeOfMenu, typeMenuStr: typeMenu, typeSubMenu: typeOfSubMenu, idItem: idOfMenu, idSubMenu: idSubMenu!, imageUrl: imageUrl!)
            }
            print("")
            break
        case "Sightseeing Tickets":
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! SightseeingTicketsSubMenu
                let idOfMenu = data.id!
                let idSubMenu = data.listItem[indexPath.row].id
                let imageUrl = data.listItem[indexPath.row].imageURL
                delegate?.didPressCellOnSubMenu(self, collectionView: collectionViewSubMenu, didSelectItemAt: indexPath, typeMenu: typeOfMenu, typeMenuStr: typeMenu, typeSubMenu: typeOfSubMenu, idItem: idOfMenu, idSubMenu: idSubMenu!, imageUrl: imageUrl!)
            }
            print("")
            break
        case "Events":
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! EventsSubMenu
                let idOfMenu = data.id!
                let idSubMenu = data.listItem[indexPath.row].id
                let imageUrl = data.listItem[indexPath.row].imageURL
                delegate?.didPressCellOnSubMenu(self, collectionView: collectionViewSubMenu, didSelectItemAt: indexPath, typeMenu: typeOfMenu, typeMenuStr: typeMenu, typeSubMenu: typeOfSubMenu, idItem: idOfMenu, idSubMenu: idSubMenu!, imageUrl: imageUrl!)
            }
            print("")
            break
        case "Passes":
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! PassesSubMenu
                let idOfMenu = data.id!
                let idSubMenu = data.listItem[indexPath.row].id
                let imageUrl = data.listItem[indexPath.row].imageURL
                delegate?.didPressCellOnSubMenu(self, collectionView: collectionViewSubMenu, didSelectItemAt: indexPath, typeMenu: typeOfMenu, typeMenuStr: typeMenu, typeSubMenu: typeOfSubMenu, idItem: idOfMenu, idSubMenu: idSubMenu!, imageUrl: imageUrl!)
            }
            print("")
            break
        case "Cruises,SaiLing And Water Tour":
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! CruisesSaiLingAndWaterTourSubMenu
                let idOfMenu = data.id!
                let idSubMenu = data.listItem[indexPath.row].id
                let imageUrl = data.listItem[indexPath.row].imageURL
                delegate?.didPressCellOnSubMenu(self, collectionView: collectionViewSubMenu, didSelectItemAt: indexPath, typeMenu: typeOfMenu, typeMenuStr: typeMenu, typeSubMenu: typeOfSubMenu, idItem: idOfMenu, idSubMenu: idSubMenu!, imageUrl: imageUrl!)
            }
            print("")
            break
        case "Walking And Biking Tour":
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! WalkingBikingTourSubMenu
                let idOfMenu = data.id!
                let idSubMenu = data.listItem[indexPath.row].id
                let imageUrl = data.listItem[indexPath.row].imageURL
                delegate?.didPressCellOnSubMenu(self, collectionView: collectionViewSubMenu, didSelectItemAt: indexPath, typeMenu: typeOfMenu, typeMenuStr: typeMenu, typeSubMenu: typeOfSubMenu, idItem: idOfMenu, idSubMenu: idSubMenu!, imageUrl: imageUrl!)
            }
            print("")
            break
        case "Climbing And Trekking Tour":
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! ClimbingAndTrekkingTourSubMenu
                let idOfMenu = data.id!
                let idSubMenu = data.listItem[indexPath.row].id
                let imageUrl = data.listItem[indexPath.row].imageURL
                delegate?.didPressCellOnSubMenu(self, collectionView: collectionViewSubMenu, didSelectItemAt: indexPath, typeMenu: typeOfMenu, typeMenuStr: typeMenu, typeSubMenu: typeOfSubMenu, idItem: idOfMenu, idSubMenu: idSubMenu!, imageUrl: imageUrl!)
            }
            print("")
            break
        case "Nightlife":
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! NightlifeSubMenu
                let idOfMenu = data.id!
                let idSubMenu = data.listItem[indexPath.row].id
                let imageUrl = data.listItem[indexPath.row].imageURL
                delegate?.didPressCellOnSubMenu(self, collectionView: collectionViewSubMenu, didSelectItemAt: indexPath, typeMenu: typeOfMenu, typeMenuStr: typeMenu, typeSubMenu: typeOfSubMenu, idItem: idOfMenu, idSubMenu: idSubMenu!, imageUrl: imageUrl!)
            }
            print("")
            break
        case "Food":
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! FoodSubMenu
                let idOfMenu = data.id!
                let idSubMenu = data.listItem[indexPath.row].id
                let imageUrl = data.listItem[indexPath.row].imageURL
                delegate?.didPressCellOnSubMenu(self, collectionView: collectionViewSubMenu, didSelectItemAt: indexPath, typeMenu: typeOfMenu, typeMenuStr: typeMenu, typeSubMenu: typeOfSubMenu, idItem: idOfMenu, idSubMenu: idSubMenu!, imageUrl: imageUrl!)
            }
            print("")
            break
        case "Shopping":
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! ShoppingSubMenu
                let idOfMenu = data.id!
                let idSubMenu = data.listItem[indexPath.row].id
                let imageUrl = data.listItem[indexPath.row].imageURL
                delegate?.didPressCellOnSubMenu(self, collectionView: collectionViewSubMenu, didSelectItemAt: indexPath, typeMenu: typeOfMenu, typeMenuStr: typeMenu, typeSubMenu: typeOfSubMenu, idItem: idOfMenu, idSubMenu: idSubMenu!, imageUrl: imageUrl!)
            }
            print("")
            break
        case "Local life":
            if let categorySubMenu = categorySubMenu{
                let data = categorySubMenu as! LocalLifeSubMenu
                let idOfMenu = data.id!
                let idSubMenu = data.listItem[indexPath.row].id
                let imageUrl = data.listItem[indexPath.row].imageURL
                delegate?.didPressCellOnSubMenu(self, collectionView: collectionViewSubMenu, didSelectItemAt: indexPath, typeMenu: typeOfMenu, typeMenuStr: typeMenu, typeSubMenu: typeOfSubMenu, idItem: idOfMenu, idSubMenu: idSubMenu!, imageUrl: imageUrl!)
            }
            print("")
            break
        default:
            print("")
        }
    }
}
