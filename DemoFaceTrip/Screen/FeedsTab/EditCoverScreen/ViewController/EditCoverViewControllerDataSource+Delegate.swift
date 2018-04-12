//
//  EditCoverViewControllerDataSource+Delegate.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 4/2/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension EditCoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == listGradientLayerCollectionView{
            
            return arrGradient.count
        }else if collectionView == themesCollectionView{
            return listFrame.count
        }else if collectionView == friendsCollectionView{
            if listFriend.count > 0{
                return listFriend.count
            }else{
                return 1
            }
        }else{
            return listAsset.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == listGradientLayerCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gradientCell", for: indexPath) as! GradientCollectionViewCell
            
//            cell.gradientsColor = arrGradient[indexPath.item]
            var cgColors: [CGColor] = []
            for color in arrGradient[indexPath.item]{
                cgColors.append(color.cgColor)
            }
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame.size = cell.viewDisplayGradient.frame.size
            gradientLayer.colors = cgColors
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            cell.viewDisplayGradient.layer.addSublayer(gradientLayer)
            
            return cell
        }else if collectionView == themesCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
//            cell.backgroundColor = .gray
            cell.layer.cornerRadius = 5
            cell.clipsToBounds = true
            cell.imageView.image = UIImage(named: listFrame[indexPath.item])
            return cell
        }else if collectionView == friendsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagFriends", for: indexPath) as! TagFriendsCollectionViewCell
            cell.layer.cornerRadius = cell.frame.width / 2
            cell.layer.masksToBounds = true
            return cell
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
            let asset = listAsset[indexPath.item].asset
            PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                cell.imageView.image = image
            })
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        if collectionView == listGradientLayerCollectionView || collectionView == friendsCollectionView{
            
            height = collectionView.frame.height
            width = height
            return CGSize(width: width, height: height)
            
        }else if collectionView == themesCollectionView{
            
            height = collectionView.frame.height
            width = height * 3 / 4
            return CGSize(width: width, height: height)
            
        }else{
            widthItem = UIScreen.main.bounds.width - marginLeftRight * 2
            heightItem = collectionView.frame.height
            
            return CGSize(width: widthItem, height: heightItem)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == listGradientLayerCollectionView{
            let data = ["gradient": arrGradient[indexPath.item]]
            notificationCenter.post(name: NSNotification.Name(rawValue: keyChangeGradientNotificationEditCover), object: nil, userInfo: data)
        }else if collectionView == themesCollectionView{
            let data = ["theme": listFrame[indexPath.item]]
            notificationCenter.post(name: NSNotification.Name(rawValue: keyAddThemesNotificationEditCover), object: nil, userInfo: data)
        }
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        print("te te")
//        if scrollView == coverImagesCollectionView{
//            let pageWidth = Float(widthItem + itemSpacing)
//            let targetContentXOffset = Float(targetContentOffset.pointee.x)
//            let contentWidth = Float(coverImagesCollectionView.contentSize.width)
//            let currentOffset = coverImagesCollectionView.contentOffset
//            let currentPage = Int(currentOffset.x / (widthItem + itemSpacing))
//            print("currentPage: \(currentPage)")
//            var newPage:Float = 0
//            if velocity.x == 0{
//                newPage = floor((targetContentXOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1
//            }else{
//                print("abcdsasa")
//                if velocity.x > 0{
//                    newPage = Float(currentPage + 1)
//                }else{
//                    newPage = Float(currentPage)
//                }
//                
//                if newPage < 0{
//                    newPage = 0
//                }
//                if newPage > (contentWidth / pageWidth){
//                    newPage = ceil(contentWidth / pageWidth) - 1
//                }
//            }
//            let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
//            targetContentOffset.pointee = point
//        }
//    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == coverImagesCollectionView{
//            let currentOffset = scrollView.contentOffset
//            let cellWidth = scrollView.frame.width - 90
//            let totalCellWidth = cellWidth * CGFloat(listAsset.count)
//            let totalSpacingWidth = CGFloat(20 * (listAsset.count - 1))
//            let leftSpace: CGFloat = 20
//            let rightSpace: CGFloat = 20
//            
//            let totalWidthOfCollectionView = totalCellWidth + totalSpacingWidth + leftSpace + rightSpace
//            if currentOffset.x > self.lastContentOffset.x{
//                
//                if currentOffset.x <= self.coverImagesCollectionView.frame.width - 90{
//                    print("hihi")
////                    UIView.animate(withDuration: 0.1, animations: {
//                        self.leadingCoverCollectionView.constant = 20
////                    })
//                    
//                }else if self.lastContentOffset.x > self.coverImagesCollectionView.frame.width - 90{
////                    UIView.animate(withDuration: 0.1, animations: {
//                        self.leadingCoverCollectionView.constant = 0
////                    })
//                    
//                }
//            }else{
//                if currentOffset.x >= (totalWidthOfCollectionView - cellWidth) && currentOffset.x <= totalWidthOfCollectionView{
//                    trailingCoverCollectionView.constant = 20
//                }else{
//                    trailingCoverCollectionView.constant = 0
//                }
//            }
//            self.lastContentOffset = currentOffset
//        }
    }
}
