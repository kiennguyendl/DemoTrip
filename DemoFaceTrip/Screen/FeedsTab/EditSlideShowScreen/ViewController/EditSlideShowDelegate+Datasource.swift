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

//        switch collectionView {
//        case slideShowCollectionView:
//            var numItem = 0
//            for item in listAsset!{
//                if item.isPicked{
//                    numItem += 1
//                }
//            }
//            return numItem
            return (listAssetPicked.count)
//        case chooseMusicCollectionView:
//            return listMusic.count
//        case listImageCollectionView:
//            return (listAsset?.count)! + 1
//        default:
//            return 0
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentRow = indexPath.item
        
        
//        switch collectionView {
//        case slideShowCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageForSlideShow", for: indexPath) as! ImageForSlideShowCollectionViewCell
            let asset = listAssetPicked[indexPath.row].asset

//            let currentRow = indexPath.row
        
            if currentRow == 0{
                if isShowingVideo{
                    let data = ["isPlayMusic": true, "musicFile": musicType] as [String : Any]
                    notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
                    
                    UIView.animate(withDuration: TimeInterval(self.totalTime), animations: {
                        self.progressView.setProgress(1.0, animated: true)
                    })
                }
            }
            if asset?.mediaType == .image{
                
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageForSlideShow", for: indexPath) as! ImageForSlideShowCollectionViewCell
                
                cell.bringSubview(toFront: cell.tilteMoments)
                cell.showImageView.transform = CGAffineTransform.identity
                PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                    
                    let thumnail = VideoManager.shareInstance.getThumnailImage(image: image!)
                    cell.imageBlurView.image = thumnail
                    if Float((image?.size.width)!) <= Float((image?.size.height)!){
                        cell.widthOfShowImageView.constant = cell.frame.width
                    }else{
                        cell.widthOfShowImageView.constant = cell.frame.width
                    }
                    cell.showImageView.image = thumnail
                    
//                    if self.isShowingVideo{
//                        UIView.animate(withDuration: 3, delay: 0, options: [], animations: {
//                            cell.showImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//                        }, completion: { finished in
//                            cell.showImageView.transform = CGAffineTransform.identity
//                        })
//                    }

                    
                })
                
                if self.isShowingVideo{
                    UIView.animate(withDuration: 3, delay: 0, options: [], animations: {
                        cell.showImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    }, completion: { finished in
//                        cell.showImageView.transform = CGAffineTransform.identity
                    })
                }

                
                if currentRow == 0{
                    cell.avartarImg.isHidden = true
                    UIView.transition(with: cell.tilteMoments, duration: 2, options: [.curveEaseOut, .transitionFlipFromLeft], animations: {
                        cell.tilteMoments.isHidden = false
                    }, completion: { finished in
                        UIView.transition(with: cell.tilteMoments, duration: 1, options: [.curveEaseIn, .transitionFlipFromLeft], animations: {
                            cell.tilteMoments.isHidden = true
                        }, completion: nil)
                        
                    })
                }else if currentRow == (listAssetPicked.count) - 1{
                    cell.tilteMoments.isHidden = true
                    cell.avartarImg.isHidden = false
                    cell.avartarImg.image = #imageLiteral(resourceName: "avatar.jpg")
                    cell.avartarImg.layer.cornerRadius = cell.avartarImg.frame.width / 2
                    cell.avartarImg.layer.masksToBounds = true
                }else{
                    cell.tilteMoments.isHidden = true
                    cell.avartarImg.isHidden = true
                }
                
                
                removeTimer()
                timeInterval = 3.0
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
                            VideoManager.shareInstance.trimVideo(asset: avAsset!, fileName: "video\(currentRow)", time: 15.0, completionHandler: {[weak self] url in
                                guard let strongSelf = self else{return}
                                DispatchQueue.main.async {
                                    VideoPlayerManager.shareInstance.addPlayerLayer(view: cell.playerView, url: url)
                                    if strongSelf.isShowingVideo{
                                        VideoPlayerManager.shareInstance.playVideo()
                                        if currentRow == 0{
                                            UIView.transition(with: cell.tilteMoments, duration: 3.0, options: [.curveEaseOut, .transitionFlipFromLeft], animations: {
                                                cell.tilteMoments.isHidden = false
                                            }, completion: { finished in
                                                UIView.transition(with: cell.tilteMoments, duration: 1, options: [.curveEaseIn, .transitionFlipFromLeft], animations: {
                                                    cell.tilteMoments.isHidden = true
                                                }, completion: nil)

                                            })
                                        }else{
                                            cell.tilteMoments.isHidden = true
                                        }
                                    }
                                }
                                
                            })
                        }
                        
                })
                
//                if currentRow == 0{
//                    UIView.transition(with: cell.tilteMoments, duration: 3.0, options: [.curveEaseOut, .transitionFlipFromLeft], animations: {
//                        cell.tilteMoments.isHidden = false
//                    }, completion: { finished in
//                        cell.tilteMoments.isHidden = true
//                    })
//                }else{
//                    cell.tilteMoments.isHidden = true
//                }
                
                removeTimer()
                timeInterval = 15.0
                setTimer()
                return cell
            }
//            return UICollectionViewCell()
//        case chooseMusicCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeMusicCell", for: indexPath) as! TypeMusicCollectionViewCell
//            cell.typeMusicLbl.text = listMusic[indexPath.row]
//            if selectedIndexPath == indexPath{
//                cell.typeMusicLbl.textColor = .blue
//            }else{
//                cell.typeMusicLbl.textColor = .gray
//            }
//            return cell
//        case listImageCollectionView:
//            let currentItem = indexPath.row
//            if currentItem == 0{
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCell", for: indexPath) as! AddImageCollectionViewCell
//                cell.addMoreImageOrVide.addTarget(self, action: #selector(pickedImageOrVideo), for: .touchUpInside)
//                return cell
//            }else{
//                 let asset = listAsset![currentItem - 1].asset
//
//                if asset?.mediaType == .image{
//                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pickerImageCell", for: indexPath) as! ImagePickerCollectionViewCell
//                    //                cell.pickerBtn.layer.cornerRadius = cell.pickerBtn.frame.width / 2
//                    //                cell.pickerBtn.layer.masksToBounds = true
//                    cell.checkedImage.layer.cornerRadius = cell.checkedImage.frame.width / 2
//                    cell.checkedImage.layer.masksToBounds = true
//
//                    PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
//                        cell.imageView.image = image
//                    })
//
//                    if listAsset![currentItem - 1].isPicked{
//                        cell.checkedImage.image = #imageLiteral(resourceName: "check")
//                        cell.checkedImage.backgroundColor = .blue
//                        //                    cell.isPicked = true
//                    }else{
//                        cell.checkedImage.image = UIImage()
//                        cell.checkedImage.backgroundColor = .white
//                        //                    cell.isPicked = false
//                    }
//
//                    return cell
//                }else{
//                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoItemCell", for: indexPath) as! VideoItemCollectionViewCell
//                    PHImageManager.default().requestAVAsset(forVideo: asset!, options: nil, resultHandler: {[weak self] avAseet, audioMix, info in
//                        let duration = CMTimeGetSeconds((avAseet?.duration)!)
//                        print("duration: \(duration)")
//                        DispatchQueue.main.async {
//                            cell.timeVideo.text = String(format: "%02d:%02d", ((lround(duration) / 60) % 60), lround(duration) % 60)
//                            cell.playVideo(avAsset: avAseet!)
//                        }
//
//                    })
//
//                    cell.checkerImage.layer.cornerRadius = cell.checkerImage.frame.width / 2
//                    cell.checkerImage.layer.masksToBounds = true
//
//                    if listAsset![currentItem - 1].isPicked{
//                        cell.checkerImage.image = #imageLiteral(resourceName: "check")
//                        cell.checkerImage.backgroundColor = .blue
//                        //                    cell.isPicked = true
//                    }else{
//                        cell.checkerImage.image = UIImage()
//                        cell.checkerImage.backgroundColor = .white
//                        //                    cell.isPicked = false
//                    }
//                    return cell
//                }
//
//
//
//            }

//        default:
            return UICollectionViewCell()
//        }
    }
    
//    @objc func pickedImageOrVideo() {
//        isShowingVideo = false
//        VideoPlayerManager.shareInstance.pauseVideo()
//        if backgroundMusicPlayer != nil{
//            if playerLayer != nil{
//                player?.pause()
//                player = nil
//                playerLayer = nil
//            }
//            backgroundMusicPlayer.pause()
//            backgroundMusicPlayer = nil
//        }
//        let vc = AddMorImageOrVideoViewController()
//        vc.listAsset = listAsset!
//        vc.delegate = self
//
//        present(vc, animated: true, completion: nil)
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch collectionView {
//        case slideShowCollectionView:
            let width = slideShowCollectionView.frame.width
            let height = slideShowCollectionView.frame.height
            return CGSize(width: width, height: height)
//        case chooseMusicCollectionView:
//            let width = chooseMusicCollectionView.frame.width / 4
//            let height = slideShowCollectionView.frame.height
//            return CGSize(width: width, height: height)
//        case listImageCollectionView:
//            let width = listImageCollectionView.frame.width / 3 - 1
//            let height = width
//            return CGSize(width: width, height: height)
//        default:
//            return CGSize.zero
//        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentItem = indexPath.row
//        if collectionView == chooseMusicCollectionView{
//            musicType = arrayMusic[indexPath.row]
//            let oldIndexPath = selectedIndexPath
//            let oldCell = chooseMusicCollectionView.cellForItem(at: oldIndexPath) as! TypeMusicCollectionViewCell
//            oldCell.typeMusicLbl.textColor = .gray
//
//            selectedIndexPath = indexPath
//            let newCell = chooseMusicCollectionView.cellForItem(at: selectedIndexPath) as! TypeMusicCollectionViewCell
//            chooseMusicCollectionView.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
//            newCell.typeMusicLbl.textColor = .blue
//            reloadSlideShow()
//        }
//        if collectionView == listImageCollectionView{
//
//            if currentItem != 0{
//                let asset = listAsset![currentItem - 1].asset
//                if asset?.mediaType == .image{
//                    let cell = listImageCollectionView.cellForItem(at: indexPath) as! ImagePickerCollectionViewCell
//
//                    if listAsset![indexPath.row - 1].isPicked{
//                        listAsset![indexPath.row - 1].isPicked = false
//                        cell.checkedImage.image = UIImage()
//                        cell.checkedImage.backgroundColor = .white
//                    }else{
//                        listAsset![indexPath.row - 1].isPicked = true
//                        cell.checkedImage.image = #imageLiteral(resourceName: "check")
//                        cell.checkedImage.backgroundColor = .blue
//                    }
//                }else{
//                    let cell = listImageCollectionView.cellForItem(at: indexPath) as! VideoItemCollectionViewCell
//
//                    if listAsset![indexPath.row - 1].isPicked{
//                        listAsset![indexPath.row - 1].isPicked = false
//                        cell.checkerImage.image = UIImage()
//                        cell.checkerImage.backgroundColor = .white
//                    }else{
//                        listAsset![indexPath.row - 1].isPicked = true
//                        cell.checkerImage.image = #imageLiteral(resourceName: "check")
//                        cell.checkerImage.backgroundColor = .blue
//                    }
//                }
//
//            }
//        }
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

