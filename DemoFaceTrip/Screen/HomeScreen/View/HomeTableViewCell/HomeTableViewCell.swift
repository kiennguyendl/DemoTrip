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

protocol HomeCellDelegate {
    func didPressCell(currentSection: Int, index: Int, type: catagoryType)
}

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionViewForCell: UICollectionView!
    var delegate: HomeCellDelegate?
    var currentSection = -1
    var type: catagoryType = .None
    var catagoryItems: [AnyObject]?{
        didSet{
            collectionViewForCell.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewForCell.dataSource = self
        collectionViewForCell.delegate = self
        collectionViewForCell.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
        collectionViewForCell.showsHorizontalScrollIndicator = false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.catagoryItems?.count != nil{
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
        if let items = self.catagoryItems{
            switch self.type{
            case .hotelType:
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? Hotel{
                        if let nameHotel = item.nameHotel{
                            cell.name.text = nameHotel
                        }
                        
                        if let urlStr = item.urlImg{
                            let url = URL(string: urlStr)
                            let dafautImg = UIImage(named: "default")
                            cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                            cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                        }
                        
                        if let place = item.place{
                            cell.place.text = place
                        }
                        
                        if let price = item.price{
                           // print(price)
                            cell.price.text = "Price: " + "\(price)" + "$"
                        }
                        
                        if let review = item.numPersonReview{
                            cell.Review.text = "Review: " + "\(review)"
                            //print(review)
                        }
                    }
                }
                break
            case .experienceType:
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? Experience{
                        if let nameExp = item.experience{
                            cell.name.text = nameExp
                        }
                        
                        if let urlStr = item.urlImg{
                            let url = URL(string: urlStr)
                            let dafautImg = UIImage(named: "default")
                            cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                            cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                        }
                        
                        if let place = item.place{
                            cell.place.text = place
                        }
                        
                        if let price = item.price{
                            cell.price.text = "Price: " + "\(price)" + "$"
                        }
                        
                        if let review = item.numPersonReview{
                            cell.Review.text = "Review: " + "\(review)"
                        }
                    }
                }
                break
            case .cityTourType:
                for _ in 0..<4{
                    if let item = items[indexPath.row] as? CityTour{
                        if let nameTour = item.tour{
                            cell.name.text = nameTour
                        }
                        
                        if let urlStr = item.urlImg{
                            let url = URL(string: urlStr)
                            let dafautImg = UIImage(named: "default")
                            cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                            cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                        }
                        
                        if let place = item.place{
                            cell.place.text = place
                        }
                        
                        if let price = item.price{
                            cell.price.text = "Price: " + "\(price)" + "$"
                        }
                        
                        if let review = item.numPersonReview{
                            cell.Review.text = "Review: " + "\(review)"
                        }
                    }
                }
                break
            case .foodTourType:
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? FoodTour{
                        if let name = item.name{
                            cell.name.text = name
                        }
                        
                        if let urlStr = item.image{
                            let url = URL(string: urlStr)
                            let dafautImg = UIImage(named: "default")
                            cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                            cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                        }
                        
                        if let place = item.place{
                            cell.place.text = place
                        }
                        
                        if let price = item.price{
                            cell.price.text = "Price: " + "\(price)" + "$"
                        }
                        
                        if let review = item.numReview{
                            cell.Review.text = "Review: " + "\(review)"
                        }
                    }
                }
                break
            case .localGuideType:
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? LocalGuide{
                        if let nameGuide = item.nameGuide{
                            cell.name.text = nameGuide
                        }
                        
                        if let urlStr = item.avatar{
                            let url = URL(string: urlStr)
                            let dafautImg = UIImage(named: "default")
                            cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                            cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                        }
                        
                        if let place = item.place{
                            cell.place.text = place
                        }
                        
                        if let price = item.price{
                            cell.price.text = "Price: " + "\(price)" + "$/Person"
                        }
                        
                        if let numLike = item.numLike{
                            cell.Review.text = "Like: " + "\(numLike)"
                        }
                    }
                }
                break
            case .attractionType:
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? Attraction{
                        if let name = item.name{
                            cell.name.text = name
                        }
                        
                        if let urlStr = item.image{
                            let url = URL(string: urlStr)
                            let dafautImg = UIImage(named: "default")
                            cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                            cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                        }
                        
                        if let place = item.place{
                            cell.place.text = place
                        }
                        
                        if let country = item.country{
                            cell.price.text = "country: " + "\(country)"
                        }
                        
                        if let review = item.numReview{
                            cell.Review.text = "Review: " + "\(review)"
                        }
                    }
                }
                break
            case .travelAgencyType:
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? TravelAgency{
                        if let name = item.name{
                            cell.name.text = name
                        }
                        
                        if let urlStr = item.image{
                            let url = URL(string: urlStr)
                            let dafautImg = UIImage(named: "default")
                            cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                            cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                        }
                        
                        if let place = item.place{
                            cell.place.text = place
                        }
                        
                        if let country = item.country{
                            cell.price.text = "Country: " + "\(country)"
                        }
                        
                        if let review = item.numReview{
                            cell.Review.text = "Review: " + "\(review)"
                        }
                    }
                }
                break
            case .themParkType:
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? ThemeParks{
                        if let name = item.name{
                            cell.name.text = name
                        }
                        
                        if let urlStr = item.image{
                            let url = URL(string: urlStr)
                            let dafautImg = UIImage(named: "default")
                            cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                            cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                        }
                        
                        if let place = item.place{
                            cell.place.text = place
                        }
                        
                        if let price = item.price{
                            cell.price.text = "Price: " + "\(price)" + "$"
                        }
                        
                        if let review = item.numReview{
                            cell.Review.text = "Review: " + "\(review)"
                        }
                    }
                }
                break
            default:
                break
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let witdh = collectionViewForCell.frame.width / 1.3
        let height = self.frame.height
        return CGSize(width: witdh, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didPressCell(currentSection: currentSection, index: indexPath.row, type: type)
    }
}
