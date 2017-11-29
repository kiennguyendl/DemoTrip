//
//  SubMenuTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class SubMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionViewSubMenu: UICollectionView!
    var typeOfSubMenu = ""
    var numberOfRow = 0
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
        switch typeOfSubMenu {
        case "Show And Concerts":
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
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
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
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
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
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
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
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
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
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
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
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
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
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
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
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
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
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
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
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
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
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
}
