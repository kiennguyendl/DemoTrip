//
//  VideoForSlideShowCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 2/8/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import  AVFoundation

class VideoForSlideShowCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var playerView: UIView!
    var player: AVPlayer?
    var playerLayer:AVPlayerLayer?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        if playerLayer != nil{
//            player = nil
//            playerLayer = nil
//            playerLayer?.removeFromSuperlayer()
//        }
    }

//    func playVideo(url: URL)  {
//        player = AVPlayer(url: url as URL)
//        
//        playerLayer = AVPlayerLayer()
//        playerLayer?.player = player
//        playerLayer?.frame = self.playerView.frame
//        playerLayer?.backgroundColor = UIColor.white.cgColor
//        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        
//        self.playerView.layer.addSublayer(playerLayer!)
//        player?.play()
//    }
}
