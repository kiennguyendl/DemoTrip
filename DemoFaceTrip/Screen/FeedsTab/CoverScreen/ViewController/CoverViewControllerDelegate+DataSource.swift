//
//  CoverViewControllerDelegate+DataSource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 4/7/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import Photos
import UIKit
extension CoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == slideShowCollectionView{
            if listAsset.count > 15{
                return 15
            }else{
                return listAsset.count
            }
        }else{
            if listTaggedFriends.count > 0{
                return listTaggedFriends.count
            }else{
                return 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == slideShowCollectionView{
            if indexPath.item == 0{
                let data = ["isPlayMusic": true, "musicFile": musicType] as [String : Any]
                notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
                
//                UIView.animate(withDuration: TimeInterval(totalTime), animations: {
//                    self.progressView.setProgress(1.0, animated: true)
//                })
            }
            if let asset = listAsset[indexPath.item].asset{
                if asset.mediaType == .image{
                    timeInterval = 3.0
                    removeTimer()
                    setTimer()
                    
                    let cellImage = collectionView.dequeueReusableCell(withReuseIdentifier: "imageForSlideShow", for: indexPath) as! ImageForSlideShowCollectionViewCell
                    cellImage.showImageView.transform = CGAffineTransform.identity
                    cellImage.widthOfShowImageView.constant = slideShowCollectionView.frame.width
                    PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: nil, resultHandler: {image, info in
                        cellImage.showImageView.image = image?.cropImageForSlideShow(sizeView: cellImage.frame.size)
                        
                        
                    })
                    
                    UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
                        cellImage.showImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    }, completion: { finished in
//                        cellImage.showImageView.transform = CGAffineTransform.identity
                    })
                    
                    return cellImage
                }else{
                    let cellVideo = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoForSlideShowCollectionViewCell
                    
                    PHImageManager.default().requestAVAsset(forVideo: asset, options: nil
                        , resultHandler: {avAsset,audiomix,info in
                            if avAsset == nil{
                                
                            }else{
                                VideoManager.shareInstance.trimVideo(asset: avAsset!, fileName: "video\(indexPath.item)", time: 15.0, completionHandler: { url in
                                    DispatchQueue.main.async {
                                        VideoPlayerManager.shareInstance.addPlayerLayer(view: cellVideo.playerView, url: url)
                                            VideoPlayerManager.shareInstance.playVideo()
                                    }
                                })
                            }
                            
                    })
                    removeTimer()
                    timeInterval = 15.0
                    setTimer()
                    
                    return cellVideo
                }
            }else{
                return UICollectionViewCell()
            }
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagFriends", for: indexPath) as! TagFriendsCollectionViewCell
            cell.layer.cornerRadius = cell.frame.width / 2
            cell.layer.masksToBounds = true
            
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == slideShowCollectionView{
            let width = slideShowCollectionView.frame.width
            let height = slideShowCollectionView.frame.height
            return CGSize(width: width, height: height)
        }else{
            let height = collectionView.frame.height
            let width = height
            return CGSize(width: width, height: height)
        }
        
    }
}
