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
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "opentime")
                cell.img3.image = UIImage(named: "numbooking")
                
                if let item = listDetail[indexPath.row] as? Attraction{

                    if let name = item.name, let country = item.country{
                        cell.name.text = ("\(country) - \(name)")
                    }
                    
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        cell.image.af_setImage(withURL: url!, completion: { response in
                            guard let image = response.result.value else{return}
                            cell.image.image = image.squaredImageForHome
                        })
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let place = item.place{
                        cell.lbl1.text = place
                    }
                    
                    if let review = item.numReview{
                        cell.lbl2.text = "\(review) review"
                    }
                    
                    if let timeOpen = item.openTime{
                        cell.lbl3.text = timeOpen
                    }

                }
                break
            case .themParkType:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "opentime")
                cell.img3.image = UIImage(named: "numbooking")
                
                if let item = listDetail[indexPath.row] as? ThemeParks{
                    
                    if let name = item.name, let price = item.price{
                        cell.name.text = ("$\(price)USD - \(name)")
                    }
                    
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        cell.image.af_setImage(withURL: url!, completion: { response in
                            guard let image = response.result.value else{return}
                            cell.image.image = image.squaredImageForHome
                        })
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let place = item.place{
                        cell.lbl1.text = place
                    }
                    
                    if let opentime = item.openTime{
                        cell.lbl2.text = opentime
                    }
                    
                    if let review = item.numReview{
                        cell.lbl3.text = "\(review) review"
                    }
                }
                break
            case .foodTourType:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numbooking")
                cell.img3.image = UIImage(named: "numbooking")
                
                if let item = listDetail[indexPath.row] as? FoodTour{
                    
                    if let name = item.name, let price = item.price{
                        cell.name.text = ("$\(price)USD - \(name)")
                    }
                    
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        cell.image.af_setImage(withURL: url!, completion: { response in
                            guard let image = response.result.value else{return}
                            cell.image.image = image.squaredImageForHome
                        })
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let place = item.place{
                        cell.lbl1.text = place
                    }
                    
                    if let numbooking = item.numbook{
                        cell.lbl2.text = "\(numbooking) booked"
                    }
                    
                    if let review = item.numReview{
                        cell.lbl3.text = "\(review) review"
                    }
                    
                    
                }
                break
            case .cityTourType:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numbooking")
                cell.img3.image = UIImage(named: "numbooking")
                
                if let item = listDetail[indexPath.row] as? CityTour{
                    if let name = item.tour, let price = item.price{
                        cell.name.text = ("$\(price)USD - \(name)")
                    }
                    
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        cell.image.af_setImage(withURL: url!, completion: { response in
                            guard let image = response.result.value else{return}
                            cell.image.image = image.squaredImageForHome
                        })
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let place = item.place{
                        cell.lbl1.text = place
                    }
                    
                    if let numbooking = item.numbook{
                        cell.lbl2.text = "\(numbooking) booked"
                    }
                    
                    if let review = item.numPersonReview{
                        cell.lbl3.text = "\(review) review"
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
        //let height = listDetailCollectionView.frame.height / 2
        
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

