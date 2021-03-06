//
//  SuggestionTableViewCell_Delegate+DataSource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 2/27/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import ReadMoreTextView
import Photos
import CoreLocation
import AddressBook
import Contacts

extension SuggestionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView{
            if listAsset.count > 2{
                return 3
            }
            return 0
            
        }else{
            if listAsset.count > 15{
                return 15
            }else{
                return listAsset.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentRow = indexPath.item

        if collectionView == slideShowCollectionView{

            let asset = listAsset[currentRow].asset
            
            if asset?.mediaType == .image{
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageForSlideShow", for: indexPath) as! ImageForSlideShowCollectionViewCell
                cell.showImageView.transform = CGAffineTransform.identity
                PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                
//                    let thumnail = VideoManager.shareInstance.getThumnailImage(image: image!)
                    let thumnail = image?.cropImageForSlideShow(sizeView: cell.frame.size)
                    cell.imageBlurView.image = thumnail
                    if Float((image?.size.width)!) <= Float((image?.size.height)!){
                        cell.widthOfShowImageView.constant = cell.frame.width
                    }else{
                        cell.widthOfShowImageView.constant = cell.frame.width
                    }
                    cell.showImageView.image = thumnail
                    

                    
                })
                if isPlayingSlideShow{
                    UIView.animate(withDuration: 3, delay: 0, options: [], animations: {
                        cell.showImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    }, completion: { finished in
                        //                    cell.showImageView.transform = CGAffineTransform.identity
                    })
                }
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
                        if avAsset == nil{
                            
                        }else{
                            DispatchQueue.global().async {
                                VideoManager.shareInstance.trimVideo(asset: avAsset!, fileName: "video\(currentRow)", time: 15.0, completionHandler: {[weak self] url in
                                    guard let strongSelf = self else{return}
                                    
                                    let imageThumnail = VideoManager.shareInstance.getThumnailVideo(asset: avAsset!)
                                    
//                                    VideoPlayerManager.shareInstance.addPlayerLayer(view: cell.playerView, url: url)
                                    DispatchQueue.main.async {
                                        //                                    VideoPlayerManager.shareInstance.addPlayerView(cell: cell, url: url, indexPath: indexPath)
                                        VideoPlayerManager.shareInstance.addPlayerLayer(view: cell.playerView, url: url)
                                        if strongSelf.isPlayingSlideShow{
                                            VideoPlayerManager.shareInstance.playVideo()
                                        }
                                        //                                    strongSelf.playVideo(url: url, playerView: cell.playerView)
                                    }
                                    
                                    //                                strongSelf.playVideo(url: url, playerView: cell.playerView)
                                    //                                cell.playVideo(url: url)
                                    
                                    
                                    //                                var player = AVPlayer(url: url as URL)
                                    //                                var playerLayer = AVPlayerLayer()
                                    //                                playerLayer.player = player
                                    //                                playerLayer.frame = cell.frame
                                    //                                playerLayer.backgroundColor = UIColor.white.cgColor
                                    //                                playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                                    //                                cell.layer.addSublayer(playerLayer)
                                    //                                player.volume = 0.0
                                    //                                player.play()
                                })
                            }
                            
                        }
                        
//                        }
                        
                        
//                        let image = VideoManager.shareInstance.getThumnailVideo(asset: avAsset!)
//                        DispatchQueue.main.async {
//                            cell.imageBlurView.image = image
//                            if Float((image.size.width)) <= Float((image.size.height)){
//                                cell.widthOfShowImageView.constant = cell.frame.width / 2
//                            }else{
//                                cell.widthOfShowImageView.constant = cell.frame.width
//                            }
//                            cell.showImageView.image = image
                            
//                            UIView.animate(withDuration: 2, delay: 2, options: [], animations: {
//                                cell.showImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//                            }, completion: { finished in
//                                cell.showImageView.transform = CGAffineTransform.identity
//                            })
//                        }
                        
                })
                removeTimer()
                timeInterval = 15.0
                setTimer()
                return cell
            }else{
                return UICollectionViewCell()
            }
            
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageOfSuggestion", for: indexPath) as! ImageOfSuggestionCollectionViewCell
            
            let asset = listAsset[indexPath.row].asset
            
            if asset?.mediaType == .image{
                PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                    
                    cell.imageView.image = image?.cropImageForSlideShow(sizeView: cell.frame.size)
                })
            }else{
                PHImageManager.default().requestAVAsset(forVideo: asset!, options: nil
                    , resultHandler: {[weak self] avAsset,audiomix,info in
                        guard let strongSelf = self else{return}
      
                        if avAsset == nil{
                            cell.imageView.image = UIImage()
                        }else{
                            let image = VideoManager.shareInstance.getThumnailVideo(asset: avAsset!)
                            DispatchQueue.main.async {
                                cell.imageView.image = image
                            }
                        }
                        
                        
                })
            }
            
            if indexPath.row == 2{
                cell.buttonView.isHidden = false
                cell.viewAllImgBtn.setTitle("\(listAsset.count - 2)", for: .normal)
                cell.blurEffectView.isHidden = false
                cell.listAsset = listAsset
            }else{
                cell.buttonView.isHidden = true
                cell.blurEffectView.isHidden = true
            }
            
            
            
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //        print("row willDisplay: \(indexPath.row)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("cell: \(cell.contentView)")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageCollectionView{
            let width = imageCollectionView.frame.width / 3 - 1
            let height = imageCollectionView.frame.height - 5
            
            return CGSize(width: width, height: height)
        }else{
            let width = slideShowCollectionView.frame.width - 1
            let height = slideShowCollectionView.frame.height
            return CGSize(width: width, height: height)
        }
    }
}
