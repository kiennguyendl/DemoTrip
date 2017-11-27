//
//  HomeTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/5/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import CoreMedia
import AlamofireImage
import Cosmos

protocol HomeCellDelegate {
    func didPressCell(currentSection: Int, index: Int, type: catagoryType)
}

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionViewForCell: UICollectionView!
    var delegate: HomeCellDelegate?
    
    var typeOfMenu: typeOfCategoryMenu = .None
    var numberOfRow: Int = 0
    var category: AnyObject?{
        didSet{
            switch typeOfMenu {
            case .Activities:
                if let category = category{
                    let data = category as! OutDoorActivities
                    numberOfRow = data.listSubMenu.count
                }
                break
            case .Attractions:
                if let category = category{
                    let data = category as! ShowAndAttrachtions
                    numberOfRow = data.listSubMenu.count
                }
                break
            case .BestSeller:
                if let category = category{
                    let data = category as! BestSellerMenu
                    numberOfRow = data.listItem.count
                }
                break
            case .Daytrip:
                if let category = category{
                    let data = category as! DayTripAndExcursionsTourMenu
                    numberOfRow = data.listItem.count
                }
                break
            case .Experiences:
                if let category = category{
                    let data = category as! CustomExperiences
                    numberOfRow = data.listSubMenu.count
                }
                break
            case .FTPickes:
                if let category = category{
                    let data = category as! FTPickesMenu
                    numberOfRow = data.listItem.count
                }
                break
            case .MultiDayTrip:
                if let category = category{
                    let data = category as! MultiDayTripAndExcursionsTourMenu
                    numberOfRow = data.listItem.count
                }
                break
            case .Recentlies:
                if let category = category{
                    let data = category as! RecentlyMenu
                    numberOfRow = data.listItem.count
                }
                break
            case .WishList:
                if let category = category{
                    let data = category as! WishListMenu
                    numberOfRow = data.listItem.count
                }
                break
            case .None:
                break
            }
            collectionViewForCell.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewForCell.dataSource = self
        collectionViewForCell.delegate = self
        
        collectionViewForCell.register(UINib.init(nibName: "NewHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewHomeCollectionCell")
        
        collectionViewForCell.register(UINib.init(nibName: "SubMenuItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubMenu")
        
        collectionViewForCell.showsHorizontalScrollIndicator = false

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}



extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return numberOfRow
    }
    
    
    func setDataForItemCell(cell: UICollectionViewCell, urlStr: String, typeOfTour: String, name: String, price: Double, rating: Float) -> UICollectionViewCell {
        
        let cell = cell as! NewHomeCollectionViewCell
        
            let url = URL(string: urlStr)
            cell.image.af_setImage(withURL: url!, completion: { response in
                guard let image = response.result.value else{return}
                let img = image.cropImage(image: image)
                cell.image.image = img
            })
        
        
        cell.typeOfTour.text = typeOfTour.uppercased()
        cell.typeOfTour.textColor = UIColor.red
        
        cell.nameOfTour.text = name
        
        cell.priceOfTour.text = "$\(price)"
        
        
        if rating > 0{
            cell.ratingView.rating = Double(rating)
            cell.pointRating.text = "\(rating)"
        }else{
            cell.ratingView.rating = 0
            cell.pointRating.text = "no rating"
        }
        
        return cell
    }
    
    func setDataforSubMenu(cell: UICollectionViewCell, urlStr: String, nameSubMenu: String) -> UICollectionViewCell{
        
        let cell = cell as! SubMenuItemCollectionViewCell
        let url = URL(string: urlStr)
        cell.imageMenu.af_setImage(withURL: url!, completion: { response in
            guard let image = response.result.value else{return}
            let img = image.cropImage(image: image)
            cell.imageMenu.image = img
            //                        cell.imageMenu.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
        })
        
        
        
        cell.nameSubMenu.text = nameSubMenu
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //var cell = UICollectionViewCell()
        let currentItem = indexPath.row
        switch typeOfMenu {
        case .Activities:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubMenu", for: indexPath)
            let data = category as! OutDoorActivities
            
            let urlStr = data.listSubMenu[currentItem].avatar
            let nameSubmenu = data.listSubMenu[currentItem].type

            return setDataforSubMenu(cell: cell, urlStr: urlStr!, nameSubMenu: nameSubmenu!)
        case .Attractions:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubMenu", for: indexPath)
            let data = category as! ShowAndAttrachtions
            
            let urlStr = data.listSubMenu[currentItem].avatar
            let nameSubmenu = data.listSubMenu[currentItem].type
            
            return setDataforSubMenu(cell: cell, urlStr: urlStr!, nameSubMenu: nameSubmenu!)
        case .BestSeller:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewHomeCollectionCell", for: indexPath)
 
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
            if let data = category as? BestSellerMenu{
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

            return setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case .Daytrip:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewHomeCollectionCell", for: indexPath)
            
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
            if let data = category as? DayTripAndExcursionsTourMenu{
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
            
            return setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case .Experiences:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubMenu", for: indexPath)
            let data = category as! CustomExperiences
            
            let urlStr = data.listSubMenu[currentItem].avatar
            let nameSubmenu = data.listSubMenu[currentItem].type
            
            return setDataforSubMenu(cell: cell, urlStr: urlStr!, nameSubMenu: nameSubmenu!)
        case .FTPickes:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewHomeCollectionCell", for: indexPath)
            
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
            if let data = category as? FTPickesMenu{
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
            
            return setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case .MultiDayTrip:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewHomeCollectionCell", for: indexPath)
            
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
            if let data = category as? MultiDayTripAndExcursionsTourMenu{
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
            
            return setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case .Recentlies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewHomeCollectionCell", for: indexPath)
            
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
            if let data = category as? RecentlyMenu{
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
            
            return setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case .WishList:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewHomeCollectionCell", for: indexPath)
            
            var urlStr: String!
            var typeOfTour: String!
            var nameTour: String!
            var priceTour: Double!
            var ratingTour: Float!
            
            if let data = category as? WishListMenu{
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
            
            return setDataForItemCell(cell: cell, urlStr: urlStr!, typeOfTour: typeOfTour, name: nameTour!, price: priceTour, rating: ratingTour)
        case .None:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var witdh: CGFloat = 0
        var height: CGFloat = 0
        switch typeOfMenu {
        case .Activities, .Experiences, .Attractions:
            witdh = collectionViewForCell.frame.width / 2.7
            height = self.frame.height
        default:
            witdh = collectionViewForCell.frame.width / 2.3
            height = self.frame.height
        }
        
        return CGSize(width: witdh, height: height )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //delegate?.didPressCell(currentSection: currentSection, index: indexPath.row, type: type)
        switch typeOfMenu {
        case .Activities:
            break
        case .Attractions:
            break
        case .BestSeller:
            break
        case .Daytrip:
            break
        case .Experiences:
            break
        case .FTPickes:
            break
        case .MultiDayTrip:
            break
        case .Recentlies:
            break
        case .WishList:
            break
        case .None:
            print("")
         
        }
    }
}
