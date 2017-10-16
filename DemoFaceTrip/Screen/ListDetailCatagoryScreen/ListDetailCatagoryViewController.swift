//
//  ListDetailCatagoryViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/12/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class ListDetailCatagoryViewController: BaseViewController {
    
    @IBOutlet weak var listDetailCollectionView: UICollectionView!
    var listDetail: [AnyObject]?
    var typeCatagory: catagoryType = .None
    override func viewDidLoad() {
        super.viewDidLoad()
        listDetailCollectionView.delegate = self
        listDetailCollectionView.dataSource = self
        listDetailCollectionView.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initBackButton()
        navigationItem.title = "Ho Chi Minh"
        tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

extension ListDetailCatagoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let listDetail = listDetail{
            return listDetail.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
        
        if let listDetail = listDetail{
            switch typeCatagory{
            case .attractionType:
                if let item = listDetail[indexPath.row] as? Attraction{
                    if let name = item.name{
                        cell.name.text = name
                    }
                    
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        
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
                break
            case .themParkType:
                if let item = listDetail[indexPath.row] as? ThemeParks{
                    if let name = item.name{
                        cell.name.text = name
                    }
                    
                    if let urlStr = item.image{
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
                    
                    if let review = item.numReview{
                        cell.Review.text = "Review: " + "\(review)"
                    }
                }
                break
            case .foodTourType:
                if let item = listDetail[indexPath.row] as? FoodTour{
                    if let name = item.name{
                        cell.name.text = name
                    }
                    
                    if let urlStr = item.image{
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
                    
                    if let review = item.numReview{
                        cell.Review.text = "Review: " + "\(review)"
                    }
                }
                break
            case .cityTourType:
                if let item = listDetail[indexPath.row] as? CityTour{
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
                break
            default:
                break
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = listDetailCollectionView.frame.width / 2 - 10
        let height = listDetailCollectionView.frame.height / 2
        
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.type = typeCatagory
        if let items = self.listDetail{
            vc.item = items[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

