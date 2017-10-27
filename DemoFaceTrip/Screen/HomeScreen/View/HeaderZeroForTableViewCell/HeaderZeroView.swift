//
//  HeaderZeroView.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/21/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

protocol HeaderZeroProtocol {
    func didPressOnCellHeaderZero(index: Int, type: catagoryType)
    func scrollCustomIndicator()
}

class HeaderZeroView: BaseView {

    @IBOutlet weak var collectionViewFriends: UICollectionView!
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var leadingOfLineView: NSLayoutConstraint!
    @IBOutlet weak var widthOfLineView: NSLayoutConstraint!
    var dataForMenu2: [Catagory] = []
    var delegate: HeaderZeroProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionViewFriends.delegate = self
        collectionViewFriends.dataSource = self
        collectionViewFriends.register(UINib.init(nibName: "ListCatagoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CatagoryCell")
        collectionViewFriends.tag = 4
        
        widthOfLineView.constant = collectionViewFriends.frame.width - 20
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
        dataForMenu2.removeAll()
    }
}

extension HeaderZeroView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataForMenu2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatagoryCell", for: indexPath) as! ListCatagoryCollectionViewCell
        //cell.nameCarousel.text = Carousels[indexPath.row]
        cell.avatar.layer.cornerRadius = cell.avatar.frame.width / 2
        cell.viewBackGroud.layer.cornerRadius = cell.viewBackGroud.frame.width / 2
        cell.avatar.clipsToBounds = true
        cell.nameCatagory.text = dataForMenu2[indexPath.row].type
        
        let strURL = dataForMenu2[indexPath.row].avatar
        let url = URL(string: strURL!)
        cell.avatar.af_setImage(withURL: url!)
        
        switch dataForMenu2[indexPath.row].typeCatagory{
            
        case .attractionType:
            var sumReview = 0
            if let catagoryItems = dataForMenu2[indexPath.row].catagoryItems as? [Attraction]{
                for index in 0 ..< catagoryItems.count{
                    if let numReview = catagoryItems[index].numReview{
                        sumReview = sumReview + numReview
                    }
                }
            }
            cell.numberLbl.text = ("\(sumReview)+")
            break
        case .themParkType:
            var sumReview = 0
            if let catagoryItems = dataForMenu2[indexPath.row].catagoryItems as? [ThemeParks]{
                for index in 0 ..< catagoryItems.count{
                    if let numReview = catagoryItems[index].numReview{
                        sumReview = sumReview + numReview
                    }
                }
            }
            cell.numberLbl.text = ("\(sumReview)+")
            break
        case .cityTourType:
            var sumReview = 0
            if let catagoryItems = dataForMenu2[indexPath.row].catagoryItems as? [CityTour]{
                for index in 0 ..< catagoryItems.count{
                    if let numReview = catagoryItems[index].numPersonReview{
                        sumReview = sumReview + numReview
                    }
                }
            }
            cell.numberLbl.text = ("\(sumReview)+")
            break
        case .foodTourType:
            var sumReview = 0
            if let catagoryItems = dataForMenu2[indexPath.row].catagoryItems as? [FoodTour]{
                for index in 0 ..< catagoryItems.count{
                    if let numReview = catagoryItems[index].numReview{
                        sumReview = sumReview + numReview
                    }
                }
            }
            cell.numberLbl.text = ("\(sumReview)+")
            break
        default:
            print("")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionViewFriends.frame.width / 4
        let height = collectionViewFriends.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = ListDetailCatagoryViewController()
//        vc.typeCatagory = dataForMenu2[indexPath.row].typeCatagory
//        vc.listDetail = dataForMenu2[indexPath.row].catagoryItems
//        navigationController?.pushViewController(vc, animated: true)
        let type = dataForMenu2[indexPath.row].typeCatagory
        delegate?.didPressOnCellHeaderZero(index: indexPath.row, type: type)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 4{
        DispatchQueue.main.async {
            let indicator = scrollView.subviews.last
            indicator?.isHidden = true
            self.leadingOfLineView.constant = (indicator?.frame.origin.x)!
            self.widthOfLineView.constant = (indicator?.frame.width)! - 10
//            print("-----------------------------")
//            print(self.widthOfLineView.constant)
//            print(self.indicatorView.frame.maxX)

            //print(self.collectionViewFriends.frame.maxX)
        }
        }
    }
}
