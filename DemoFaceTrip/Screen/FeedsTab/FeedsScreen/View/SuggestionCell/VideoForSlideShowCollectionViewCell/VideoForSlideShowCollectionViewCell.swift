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
    @IBOutlet weak var tilteMoments: UILabel!
    @IBOutlet weak var avartarImg: UIImageView!
    
    var player: AVPlayer?
    var playerLayer:AVPlayerLayer?
    var scrollingTimer: Timer? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if playerLayer != nil{
            player = nil
            playerLayer = nil
            playerLayer?.removeFromSuperlayer()
        }
        
//        avartarImg.layer.cornerRadius = avartarImg.frame.width / 2
//        avartarImg.layer.masksToBounds = true
    }
    override func prepareForReuse() {
        player = nil
        playerLayer = nil
        playerLayer?.removeFromSuperlayer()
        
//        if playerLayer != nil{
//        DispatchQueue.main.async {
//            self.player?.play()
//        }
//        }
//        self.layer.sublayers = nil
        
//        print("==================>>>>> self.layer.sublayers.count \(self.layer.sublayers?.count)")
//        if let subView = self.viewWithTag(100){
//            subView.removeFromSuperview()
//        }
        
//        VideoPlayerManager.shareInstance.removeSubView(cell: self)
    }

    func playVideo(url: URL)  {
        if playerLayer != nil{
//            DispatchQueue.main.async {
                self.player?.play()
//            }
            
        }else{
            player = AVPlayer(url: url as URL)
            
            playerLayer = AVPlayerLayer()
            playerLayer?.player = player
            playerLayer?.frame = self.playerView.frame
            playerLayer?.backgroundColor = UIColor.white.cgColor
            playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            
            self.playerView.layer.addSublayer(playerLayer!)
//            DispatchQueue.main.async {
                self.player?.play()
//            }
        }
        
    }
}
