//
//  extensionCollectionView.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/28/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

extension UICollectionView{
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
}
