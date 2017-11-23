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
//        if collectionView == self.collectionViewCarousels{
//            if menuCatagory1.count > 1{
//                return menuCatagory1.count
//            }
//            return 0
//        }else{
//            return dataForHome.count
//        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == self.collectionViewCarousels{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselsCollectionViewCell
//            cell.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
//            if Settings.isScaleMenuView!{
//
//                if self.indexPathSelected == indexPath{
//                    cell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
//                    cell.nameCarousel.textColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
//                }else{
//                    cell.viewColor.backgroundColor = UIColor.white
//                    cell.nameCarousel.textColor = UIColor.gray
//                }
//                cell.backgroundColor = UIColor.white
//            }else{
//                if indexPath == indexPathSelected{
//                    cell.viewColor.backgroundColor = UIColor.white
//                    cell.nameCarousel.textColor = UIColor.white
//                    //self.collectionViewCarousels.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
//                }else{
//                    cell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
//                    cell.nameCarousel.textColor = color4
//                }
//                cell.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
//            }
//
//            cell.nameCarousel.text = menuCatagory1[indexPath.row].uppercased()
//            return cell
        
//        }else{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
//            switch type{
//            case .ForYou:
//                break
//            case .Hotel:
//                cell.displayView()
//                cell.img1.image = UIImage(named: "place")
//                cell.img2.image = UIImage(named: "numbooking")
//                cell.img3.image = UIImage(named: "room")
//
//                if let item = self.dataForHome[indexPath.row] as? Hotel{
//                    if let nameHotel = item.nameHotel, let price = item.price{
//                        cell.name.text = ("$\(price)USD - \(nameHotel)")
//                    }
//
//                    if let urlStr = item.urlImg{
//                        let url = URL(string: urlStr)
//                        cell.image.af_setImage(withURL: url!, completion: { response in
//                            guard let image = response.result.value else{return}
//                            cell.image.image = image.squaredImageForHome
//                        })
//                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
//
//                    }
//
//                    if let place = item.place{
//                        cell.lbl1.text = place
//                    }
//
//                    if let numbooking = item.numBook{
//                        cell.lbl2.text = "\(numbooking) booked"
//                    }
//
//                    if let room = item.numRoom{
//                        cell.lbl3.text = "\(room) room"
//                    }
//                }
//                break
//            case .Experience:
//                cell.displayView()
//                cell.img1.image = UIImage(named: "place")
//                cell.img2.image = UIImage(named: "numbooking")
//                cell.img3.image = UIImage(named: "time")
//                if let item = self.dataForHome[indexPath.row] as? Experience{
//                    if let nameExp = item.experience, let price = item.price{
//                        cell.name.text = ("$\(price)USD - \(nameExp)")
//                    }
//
//                    if let urlStr = item.urlImg{
//                        let url = URL(string: urlStr)
//                        cell.image.af_setImage(withURL: url!, completion: { response in
//                            guard let image = response.result.value else{return}
//                            cell.image.image = image.squaredImageForHome
//                        })
//                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
//                    }
//
//                    if let place = item.place{
//                        cell.lbl1.text = place
//                    }
//
//                    if let review = item.numPersonReview{
//                        cell.lbl2.text = "\(review) review"
//                    }
//
//                    if let time = item.time{
//                        cell.lbl3.text = time
//                    }
//                }
//                break
//            case .CityTour:
//                break
//            case .FoodTour:
//                break
//            case .LocalGuide:
//                cell.hidingView()
//                cell.img1.image = UIImage(named: "place")
//                cell.img2.image = UIImage(named: "numlike")
//                cell.img3.image = UIImage(named: "language")
//
//                if let item = dataForHome[indexPath.row] as? LocalGuide{
//                    if let nameGuide = item.nameGuide, let price = item.price{
//                        cell.name.text = ("$\(price)USD - \(nameGuide)")
//                    }
//
//                    if let urlStr = item.avatar{
//                        let url = URL(string: urlStr)
//                        cell.image.af_setImage(withURL: url!, completion: { response in
//                            guard let image = response.result.value else{return}
//                            cell.image.image = image.squaredImageForHome
//                        })
//                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
//                    }
//
//                    if let place = item.place{
//                        cell.lbl1.text = place
//                    }
//
//
//                    if let numLike = item.numLike{
//                        cell.lbl2.text = "\(numLike)"
//                    }
//
//                    if let language = item.language{
//                        cell.lbl3.text = language
//                    }
//                }
//                break
//            case .TravelAgency:
//                cell.displayView()
//                cell.img1.image = UIImage(named: "place")
//                cell.img2.image = UIImage(named: "numbooking")
//                cell.img3.image = UIImage(named: "numbooking")
//
//                if let item = dataForHome[indexPath.row] as? TravelAgency{
//                    if let name = item.name, let country = item.country{
//                        cell.name.text = ("\(country) - \(name)")
//                    }
//
//                    if let urlStr = item.image{
//                        let url = URL(string: urlStr)
//                        let dafautImg = UIImage(named: "default")
//                        cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
//                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
//                    }
//
//                    if let place = item.place{
//                        cell.lbl1.text = place
//                    }
//
//                    if let numbook = item.numbook{
//                        cell.lbl2.text = ("\(numbook) booked")
//                    }
//                    if let review = item.numReview{
//                        cell.lbl3.text = "\(review) review"
//                    }
//                }
//                break
//            case .Attraction:
//
//                break
//            }
//            return cell
//        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == self.collectionViewCarousels{
//            var width: CGFloat = 0.0
//            var height: CGFloat = 0.0
//            if menuCatagory1.count > 1 {
//                let size: CGSize = menuCatagory1[indexPath.row].size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)])
//
//                width = size.width
//                height = collectionViewCarousels.frame.height
//
//            }else{
//                width = collectionViewCarousels.frame.width
//                height = collectionViewCarousels.frame.height
//            }
//
//            return CGSize(width: width, height: height)
//        }else{
//            let width = collectionViewDetail.frame.width / 2 - 10
//            return CGSize(width: width, height: width * 1.5)
//        }
            return CGSize(width: 50, height: 5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionViewCarousels{
            
            indexPathSelected = []
            indexPathSelected = indexPath
            tableViewCarousels.isHidden = true
            collectionViewDetail.isHidden = false
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
