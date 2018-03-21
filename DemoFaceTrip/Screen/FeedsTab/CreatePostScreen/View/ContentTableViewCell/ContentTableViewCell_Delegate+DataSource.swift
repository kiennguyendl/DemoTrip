//
//  ContentTableViewCell_Delegate+DataSource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/7/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Photos
import GoogleMaps
import GooglePlaces

extension ContentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (listAsset?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentRow = indexPath.row
        
        if currentRow == 0{
            
            if isShowingVideo == true{
                let data = ["isPlayMusic": true, "musicFile": enspired] as [String : Any]
                notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotificationCreatePost), object: nil, userInfo: data)
            }
        }
        let asset = listAsset![currentRow].asset
        
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
            
            if currentRow == 0{
                cell.avartarImg.isHidden = true
                UIView.transition(with: cell.tilteMoments, duration: 2, options: [.curveEaseOut, .transitionFlipFromLeft], animations: {
                    cell.tilteMoments.isHidden = false
                }, completion: { finished in
                    UIView.transition(with: cell.tilteMoments, duration: 1, options: [.curveEaseIn, .transitionFlipFromLeft], animations: {
                        cell.tilteMoments.isHidden = true
                    }, completion: nil)
                    
                })
            }else if currentRow == (listAsset?.count)! - 1{
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
//                        strongSelf.playVideo(url: url, playerView: cell.playerView)
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
                    
            })
            removeTimer()
            timeInterval = 15.0
            setTimer()
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = slideShowCollectionView.frame.width
        let height = slideShowCollectionView.frame.height
        return CGSize(width: width, height: height)
    }
}

extension ContentTableViewCell: GMUClusterManagerDelegate, GMSMapViewDelegate, GMUClusterRendererDelegate{
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        
        return false
    }
    
    // MARK: - GMUMapViewDelegate
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        delgate?.showListImageInPossition(listAsset: listAsset!)
        return true
    }
    
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        
        //        if marker.userData is PointItem{
        let items = marker.userData as! PointItem
        let image = items.images[0]
        //        UIGraphicsBeginImageContextWithOptions(CGSize(width: 60, height: 60), true, 0)
        //        image.draw(in: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        //        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //        let textStyle = NSMutableParagraphStyle()
        //        textStyle.alignment = NSTextAlignment.center
        //        let textColor = UIColor.white
        //        let attributes=[
        //            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14),
        //            NSAttributedStringKey.paragraphStyle: textStyle,
        //            NSAttributedStringKey.foregroundColor: textColor,
        //            NSAttributedStringKey.backgroundColor: UIColor.blue] as [NSAttributedStringKey : Any]
        //        let text = "14"
        //
        //        let textH = UIFont.boldSystemFont(ofSize: 14).lineHeight
        //        let textY = ((newImage?.size.height)!-textH)/2
        //        let textRect = CGRect(x: 0, y: textY, width: (newImage?.size.width)!, height: textH)
        //        text.draw(in: textRect.integral, withAttributes: attributes)
        //        let result = UIGraphicsGetImageFromCurrentImageContext()
        //        UIGraphicsEndImageContext()
        
        let markerView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 100)))
        markerView.backgroundColor = .clear
        
        let markerImage = UIImageView(frame: CGRect(x: 25, y: 25, width: 60, height: 60))
        markerImage.image = UIImage(named: "infowindow")
        
        let imgInside = UIImageView(frame: CGRect(x: 30, y: 30, width: 50, height: 45))
        imgInside.image = image
        
        let label = UILabel(frame: CGRect(x: 65, y: 15, width: 20, height: 20))
        label.text = "32"
        label.font = UIFont.systemFont(ofSize: 10)
        label.backgroundColor = .blue
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = label.frame.width / 2
        label.layer.masksToBounds = true
        
        markerView.addSubview(markerImage)
        markerView.addSubview(imgInside)
        markerView.addSubview(label)
        
        UIGraphicsBeginImageContextWithOptions(markerView.frame.size, false, UIScreen.main.scale)
        markerView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageConverted: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //        UIGraphicsEndImageContext()
        marker.icon = imageConverted
        // Center the marker at the center of the image.
        marker.groundAnchor = CGPoint(x: 0.5, y: 1)
        
    }
}
