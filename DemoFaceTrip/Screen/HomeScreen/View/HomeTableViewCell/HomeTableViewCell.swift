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
    
    var cache:NSCache<AnyObject, AnyObject>!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewForCell.dataSource = self
        collectionViewForCell.delegate = self
        collectionViewForCell.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
        collectionViewForCell.showsHorizontalScrollIndicator = false
        cache = NSCache()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //    func downloadImageForHome(url: String,key: IndexPath) -> UIImage {
    //        //if cache has images
    //        if self.cache.object(forKey: key as AnyObject) != nil {
    //            return self.cache.object(forKey: key as AnyObject) as! UIImage
    //        }else /*if cache haven't any thing*/{
    //            let urlImg = URL(string: url)
    //            var image: UIImage!
    //            DispatchQueue.global().async {
    //                let data = try? Data(contentsOf: urlImg!)
    //                //DispatchQueue.main.async {
    //                image = UIImage(data: data!)
    //                //save image to cache
    //                self.cache.setObject(image!, forKey: key as AnyObject)
    //                //}
    //            }
    //            return image
    //        }
    //    }
    
    func cropImage(image:UIImage)-> UIImage {
//        print("key: >>>>>>>>>>>>>>>\(key)")
//        if self.cache.object(forKey: key as AnyObject) != nil{
//            return self.cache.object(forKey: key as AnyObject) as! UIImage
//        }else{
            var centerPoint: CGPoint{
                return CGPoint(x: image.size.width / 2, y: image.size.height / 2)
            }
            
            guard let cgImage = image.cgImage?.cropping(to: CGRect(origin: CGPoint(x: centerPoint.x , y: centerPoint.y), size: CGSize(width: image.size.width * 2, height: image.size.height * 2))) else {return image}
            let img = UIImage(cgImage: cgImage)
            //self.cache.setObject(img, forKey: key as AnyObject)
            return img
        //}
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
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollectionViewCell
//
//        return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
        
        if let items = self.catagoryItems{
            switch self.type{
            case .hotelType:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numbooking")
                cell.img3.image = UIImage(named: "room")
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? Hotel{
                        if let nameHotel = item.nameHotel, let price = item.price{
                            cell.name.text = ("$\(price)USD - \(nameHotel)")
                        }

                        if let urlStr = item.urlImg{
                            DispatchQueue.main.async {
                                let url = URL(string: urlStr)
                                cell.image.af_setImage(withURL: url!, completion: { response in
                                    guard let image = response.result.value else{return}
                                    let img = self.cropImage(image: image)
                                    cell.image.image = img
//                                    cell.image.image = image.squaredImageForHome
//                                    cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                                })
                            }
                        }

                        if let place = item.place{
                            cell.lbl1.text = place
                        }

                        if let numbooking = item.numBook{
                            cell.lbl2.text = "\(numbooking) booked"
                        }

                        if let room = item.numRoom{
                            cell.lbl3.text = "\(room) room"
                        }
                    }
                }
                break
            case .experienceType:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numboking")
                cell.img3.image = UIImage(named: "time")
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? Experience{
                        if let nameExp = item.experience, let price = item.price{
                            cell.name.text = ("$\(price)USD - \(nameExp)")
                        }

                        if let urlStr = item.urlImg{
                            DispatchQueue.main.async {
                                let url = URL(string: urlStr)
                                cell.image.af_setImage(withURL: url!, completion: { response in
                                    guard let image = response.result.value else{return}
                                    let img = self.cropImage(image: image)
                                    cell.image.image = img
//                                    cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                                })
                            }
                            
                        }

                        if let place = item.place{
                            cell.lbl1.text = place
                        }

                        if let review = item.numPersonReview{
                            cell.lbl2.text = "\(review) review"
                        }

                        if let time = item.time{
                            cell.lbl3.text = time
                        }
                    }
                }
                break
            case .cityTourType:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numbooking")
                cell.img3.image = UIImage(named: "numbooking")

                for _ in 0..<4{
                    if let item = items[indexPath.row] as? CityTour{
                        if let nameTour = item.tour, let price = item.price{
                            cell.name.text = ("$\(price)USD - \(nameTour)")
                        }

                        if let urlStr = item.urlImg{
                            DispatchQueue.main.async {
                                let url = URL(string: urlStr)
                                cell.image.af_setImage(withURL: url!, completion: { response in
                                    guard let image = response.result.value else{return}
                                    let img = self.cropImage(image: image)
                                    cell.image.image = img
//                                    cell.image.image = image.squaredImageForHome
//                                    cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                                })
                            }
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
                }
                break
            case .foodTourType:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numbooking")
                cell.img3.image = UIImage(named: "numbooking")
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? FoodTour{
                        if let name = item.name, let price = item.price{
                            cell.name.text = ("$\(price)USD - \(name)")
                        }

                        if let urlStr = item.image{
                            DispatchQueue.main.async {
                                let url = URL(string: urlStr)
                                cell.image.af_setImage(withURL: url!, completion: { response in
                                    guard let image = response.result.value else{return}
                                    let img = self.cropImage(image: image)
                                    cell.image.image = img
//                                    cell.image.image = image.squaredImageForHome
//                                    cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                                })
                            }
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
                }
                break
            case .localGuideType:
                cell.hidingView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numlike")
                cell.img3.image = UIImage(named: "language")
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? LocalGuide{
                        if let nameGuide = item.nameGuide, let price = item.price{
                            cell.name.text = ("$\(price)USD - \(nameGuide)")
                        }

                        if let urlStr = item.avatar{
                            DispatchQueue.main.async {
                                let url = URL(string: urlStr)
                                cell.image.af_setImage(withURL: url!, completion: { response in
                                    guard let image = response.result.value else{return}
                                    let img = self.cropImage(image: image)
                                    cell.image.image = img
//                                    cell.image.image = image.squaredImageForHome
//                                    cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                                })
                            

                            }
                        }

                        if let place = item.place{
                            cell.lbl1.text = place
                        }


                        if let numLike = item.numLike{
                            cell.lbl2.text = "\(numLike)"
                        }

                        if let language = item.language{
                            cell.lbl3.text = language
                        }
                    }
                }
                break
            case .attractionType:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "opentime")
                cell.img3.image = UIImage(named: "numbooking")
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? Attraction{
                        if let name = item.name, let country = item.country{
                            cell.name.text = ("\(country) - \(name)")
                        }

                        if let urlStr = item.image{
                            DispatchQueue.main.async {
                                let url = URL(string: urlStr)
                                cell.image.af_setImage(withURL: url!, completion: { response in
                                    guard let image = response.result.value else{return}
                                    let img = self.cropImage(image: image)
                                    cell.image.image = img
//                                    cell.image.image = image.squaredImageForHome
//                                    cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                                })
                                

                            }
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
                }
                break
            case .travelAgencyType:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numbooking")
                cell.img3.image = UIImage(named: "numbooking")
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? TravelAgency{
                        if let name = item.name, let country = item.country{
                            cell.name.text = ("\(country) - \(name)")
                        }

                        if let urlStr = item.image{
                            DispatchQueue.main.async {
                                let url = URL(string: urlStr)
                                let dafautImg = UIImage(named: "default")
                                cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                                //cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                            }
                        }
                            

                        if let place = item.place{
                            cell.lbl1.text = place
                        }

                        if let numbook = item.numbook{
                            cell.lbl2.text = ("\(numbook) booked")
                        }
                        if let review = item.numReview{
                            cell.lbl3.text = "\(review) review"
                        }
                    }
                }
                break
            case .themParkType:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "opentime")
                cell.img3.image = UIImage(named: "numbooking")
                for _ in 0..<4 {
                    if let item = items[indexPath.row] as? ThemeParks{
                        if let name = item.name, let price = item.price{
                            cell.name.text = ("$\(price)USD - \(name)")
                        }

                        if let urlStr = item.image{
                            DispatchQueue.main.async {
                                let url = URL(string: urlStr)
                                cell.image.af_setImage(withURL: url!, completion: { response in
                                    guard let image = response.result.value else{return}
                                    let img = self.cropImage(image: image)
                                    cell.image.image = img
//                                    cell.image.image = image.squaredImageForHome
                                    //cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                                })
                            }
                            
                            
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
        return CGSize(width: witdh, height: height )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didPressCell(currentSection: currentSection, index: indexPath.row, type: type)
    }
}
