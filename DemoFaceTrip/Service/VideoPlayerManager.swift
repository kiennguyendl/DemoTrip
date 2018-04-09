//
//  VideoPlayerManager.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/16/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class VideoPlayerManager: NSObject{
    static let shareInstance = VideoPlayerManager()
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
//    func addPlayerView(cell: UICollectionViewCell, url: URL, indexPath: IndexPath) {
//        if playerLayer != nil{
//            player.pause()
//            player = nil
//            playerLayer.player = nil
//            playerLayer = nil
//        }
////        removeSubView(cell: cell)
//        let view = UIView()
//        if indexPath.item % 2 == 0{
//            view.tag = 50
//        }else{
//            view.tag = 100
//        }
//
//        view.frame = cell.frame
//        view.backgroundColor = UIColor.red
////        cell.addSubview(view)
//        player = AVPlayer(url: url)
//        playerLayer = AVPlayerLayer()
//        playerLayer.frame = view.frame
//        playerLayer.layoutIfNeeded()
//        playerLayer.player = player
//        view.layer.addSublayer(self.playerLayer)
//        cell.addSubview(view)
//        player.play()
//    }
    
    func addPlayerLayer(view: UIView, url: URL) {
        if playerLayer != nil{
            player.pause()
            player = nil
            playerLayer.player = nil
            playerLayer = nil
        }
        
        removePlayerLayer(view: view)
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer()
        playerLayer.frame = view.bounds
        playerLayer.layoutIfNeeded()
        playerLayer.player = player
        view.layer.addSublayer(self.playerLayer)
//        cell.addSubview(view)
//        player.play()
    }
    
//    func removeSubView(cell: UICollectionViewCell) {
//
//        if let subView = cell.viewWithTag(100){
//            print("kaka remove view")
//            if playerLayer != nil{
//                player.pause()
//                player = nil
////                playerLayer = nil
//                playerLayer.removeFromSuperlayer()
//                playerLayer = nil
//            }
//            subView.removeFromSuperview()
//        }else{
//            print("dont have view")
//        }
//    }

    func removePlayerLayer(view: UIView) {
        for subView in view.subviews{
            if subView.tag == 100{
                subView.removeFromSuperview()
            }
        }
    }
    
    func playVideo() {
        if playerLayer != nil{
            player.play()
        }
    }
    
    func pauseVideo() {
        if playerLayer != nil{
            player.pause()
        }
    }
    
    func removePLayerLayer() {
        if playerLayer != nil{
            player.pause()
            player = nil
            playerLayer = nil
//            playerLayer.removeFromSuperlayer()
        }
    }
    
}
