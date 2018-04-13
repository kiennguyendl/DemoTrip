//
//  VideoItemCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/9/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import Photos

class VideoItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var timeVideo: UILabel!
    @IBOutlet weak var checkerImage: UIImageView!
    
    @IBOutlet weak var tilteMoments: UILabel!
    var timerAutoPlayVideo: Timer? = nil
    var player: AVPlayer?
    var playerLayer:AVPlayerLayer?
    var playerItem: AVPlayerItem?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    deinit {
        print("remove cell")
        for subLayer in playerView.layer.sublayers!{
            if let layer = subLayer as? AVPlayerLayer{
                layer.player?.pause()
                layer.removeFromSuperlayer()
            }
        }
    }
    
    func setTimer() {
        
        timerAutoPlayVideo = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(autoPlayeVideo), userInfo: nil, repeats: true)
    }

    @objc func autoPlayeVideo() {
        player?.seek(to: CMTime(value: 10, timescale: 1))
        player?.play()
    }
    
    func playVideo(avAsset: AVAsset) {
        playerItem = AVPlayerItem(asset: avAsset)
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer()
        playerLayer?.player = player
        playerLayer?.frame = playerView.frame
        playerLayer?.backgroundColor = UIColor.white.cgColor
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        playerView.layer.addSublayer(playerLayer!)
        player?.volume = 0.0
        
        setTimer()
    }
}
