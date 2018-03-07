//
//  EditSlideShowDelegate+Datasource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 2/6/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension EditSlideShowViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch collectionView {
        case slideShowCollectionView:
            return (listAsset?.count)!
        case chooseMusicCollectionView:
            return listMusic.count
        case listImageCollectionView:
            return (listAsset?.count)! + 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentRow = indexPath.row
        
        if collectionView == slideShowCollectionView{
            print("afasfasfasfasfasf")
        }
        
        switch collectionView {
        case slideShowCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageForSlideShow", for: indexPath) as! ImageForSlideShowCollectionViewCell
            let asset = listAsset![indexPath.row].asset

            let currentRow = indexPath.row
            
            if currentRow == 0{
                let data = ["isPlayMusic": true]
                notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotificationCreatePost), object: nil, userInfo: data)
            }
            if asset?.mediaType == .image{
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageForSlideShow", for: indexPath) as! ImageForSlideShowCollectionViewCell
                
                PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                    
                    let thumnail = VideoManager.shareInstance.getThumnailImage(image: image!)
                    cell.imageBlurView.image = thumnail
                    if Float((image?.size.width)!) <= Float((image?.size.height)!){
                        cell.widthOfShowImageView.constant = cell.frame.width
                    }else{
                        cell.widthOfShowImageView.constant = cell.frame.width
                    }
                    cell.showImageView.image = thumnail
                    
                    
                    UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
                        cell.showImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    }, completion: { finished in
                        cell.showImageView.transform = CGAffineTransform.identity
                    })
                })
                removeTimer()
                timeInterval = 2.0
                setTimer()
                return cell
            }else if asset?.mediaType == .video{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoForSlideShowCollectionViewCell
                
                
                print("current item: \(currentRow)")
                
                PHImageManager.default().requestAVAsset(forVideo: asset!, options: nil
                    , resultHandler: {[weak self] avAsset,audiomix,info in
                        guard let strongSelf = self else{return}
                        VideoManager.shareInstance.trimVideo(asset: avAsset!, fileName: "video\(currentRow)", completionHandler: {[weak self] url in
                            guard let strongSelf = self else{return}
                            strongSelf.playVideo(url: url, playerView: cell.playerView)
                            
                        })
                        
                })
                removeTimer()
                timeInterval = 15.0
                setTimer()
                return cell
            }
            return UICollectionViewCell()
        case chooseMusicCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeMusicCell", for: indexPath) as! TypeMusicCollectionViewCell
            cell.typeMusicLbl.text = listMusic[indexPath.row]
            return cell
        case listImageCollectionView:
            let currentItem = indexPath.row
            if currentItem == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCell", for: indexPath) as! AddImageCollectionViewCell
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pickerImageCell", for: indexPath) as! ImagePickerCollectionViewCell
                cell.pickerBtn.layer.cornerRadius = cell.pickerBtn.frame.width / 2
                cell.pickerBtn.layer.masksToBounds = true
                
                let asset = listAsset![currentItem - 1].asset
                
                PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                    cell.imageView.image = image
                })
                
                return cell
            }

        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case slideShowCollectionView:
            let width = slideShowCollectionView.frame.width 
            let height = slideShowCollectionView.frame.height
            return CGSize(width: width, height: height)
        case chooseMusicCollectionView:
            let width = chooseMusicCollectionView.frame.width / 4
            let height = slideShowCollectionView.frame.height
            return CGSize(width: width, height: height)
        case listImageCollectionView:
            let width = listImageCollectionView.frame.width / 3 - 1
            let height = width
            return CGSize(width: width, height: height)
        default:
            return CGSize.zero
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let heigth = menuView.frame.height + slideShowViewParent.frame.height + musicView.frame.height
////        print("Height: \(heigth)")
////        print("offset y: \(scrollView.contentOffset.y)")
//        if scrollView == listImageCollectionView{
//            if (self.lastContentOffset < scrollView.contentOffset.y) {
//                // moved to top
//                print("move up")
//                DispatchQueue.main.async {
//                    UIView.animate(withDuration: 0.5, animations: {
//                        if scrollView.contentOffset.y > heigth{
//                            self.topMenuViewContraint.constant = -heigth
//                        }else{
//                            self.topMenuViewContraint.constant = -scrollView.contentOffset.y
//                        }
//                    })
//                }
//
//            } else if (self.lastContentOffset > scrollView.contentOffset.y) {
//                // moved to bottom
//                DispatchQueue.main.async {
//                    UIView.animate(withDuration: 0.5, animations: {
//                        if scrollView.contentOffset.y < 0{
//                            self.topMenuViewContraint.constant = 0
//                        }else{
//                            self.topMenuViewContraint.constant = -scrollView.contentOffset.y
//                        }
//                    })
//                }
//                print("move down")
//
//            } else {
//                // didn't move
//                print("dont move")
//            }
//        }
//    }
}
