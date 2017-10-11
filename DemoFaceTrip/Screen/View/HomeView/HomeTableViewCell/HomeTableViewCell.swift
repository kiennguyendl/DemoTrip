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

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionViewForCell: UICollectionView!
    var rowIndex = -1
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
            case .tourType:
                for _ in 0..<4{
                    if let item = items[indexPath.row] as? Tour{
                        if let nameTour = item.tour{
                            cell.name.text = nameTour
                        }
                        
                        if let urlStr = item.urlImg{
                            let url = URL(string: urlStr)
                            let dafautImg = UIImage(named: "default")
                            cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                            
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
            default:
                break
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let witdh = collectionViewForCell.frame.width / 1.5
        let height = witdh * 3 / 2
        return CGSize(width: witdh, height: height)
    }
}
