//
//  EditSlideShowViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 2/6/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import Photos

class EditSlideShowViewController: UIViewController {

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var discardBtn: UIButton!
    @IBOutlet weak var doneBottomBtn: UIButton!
    
    @IBOutlet weak var slideShowView: UIView!
    
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    @IBOutlet weak var displayTimeLbl: UILabel!
//    @IBOutlet weak var pauseOrPlayBtn: UIButton!
//    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var hiddenView: UIView!
    
    @IBOutlet weak var musicView: UIView!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var chooseMusicCollectionView: UICollectionView!
    
    @IBOutlet weak var slideShowViewParent: UIView!
    
//    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var musicIconImageView: UIImageView!
    @IBOutlet weak var closeRecordViewBtn: UIButton!
    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var recordVoiceBtn: UIButton!
    @IBOutlet weak var bottomRecordViewContraint: NSLayoutConstraint!
    @IBOutlet weak var topRecordViewContraint: NSLayoutConstraint!
    
    @IBOutlet weak var numberPhotosLbl: UILabel!
    @IBOutlet weak var sellectOrUnsellectBtn: UIButton!
    
    @IBOutlet weak var topMenuViewContraint: NSLayoutConstraint!
    
    @IBOutlet weak var cancelView: UIView!
    
    @IBOutlet weak var listImageCollectionView: UICollectionView!
    
    var isShowingVideo = true
    var isEndSlideShow = true
    var timeInterval = 2.0
    var scrollingTimer: Timer? = nil
    var backgroundMusicPlayer: AVAudioPlayer!
    var player: AVPlayer?
    var playerLayer:AVPlayerLayer?
    
    var listImage: [UIImage] = []
    var listAsset: [AsssetInfor]?{
        didSet{
            if let listAsset = listAsset{
//                for _asset in listAsset{
//                    let asset = _asset.asset
//                    PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
//
//                        self.listImage.append(image!)
//                    })
//                }
                
//                slideShowCollectionView.reloadData()
            }
        }
    }
    var listMusic = ["Inspired", "Birthday", "Playful", "Epic", "Happy"]
    
    var lastContentOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        setupButton()
        setupCollectionView()
        slideShowCollectionView.reloadData()
    }
    
    func setupCollectionView() {
        slideShowCollectionView.delegate = self
        slideShowCollectionView.dataSource = self
        slideShowCollectionView.register(UINib.init(nibName: "ImageForSlideShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageForSlideShow")
        slideShowCollectionView.register(UINib.init(nibName: "VideoForSlideShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCell")
//        
        chooseMusicCollectionView.delegate = self
        chooseMusicCollectionView.dataSource = self
        chooseMusicCollectionView.register(UINib.init(nibName: "TypeMusicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TypeMusicCell")
            
        listImageCollectionView.delegate = self
        listImageCollectionView.dataSource = self
        listImageCollectionView.register(UINib.init(nibName: "ImagePickerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pickerImageCell")
        listImageCollectionView.register(UINib.init(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCell")
    }
    
    func setupButton(){
        discardBtn.layer.cornerRadius = 5
        discardBtn.layer.masksToBounds = true
        
        doneBottomBtn.layer.cornerRadius = 5
        doneBottomBtn.layer.masksToBounds = true
        
        recordBtn.layer.cornerRadius = recordBtn.frame.width / 2
        recordBtn.layer.masksToBounds = true
        let image = UIImage(named: "record")?.withRenderingMode(.alwaysTemplate)
        recordBtn.setImage(image, for: .normal)
        recordBtn.tintColor = UIColor.white
        
        recordVoiceBtn.layer.cornerRadius = recordVoiceBtn.frame.width / 2
        recordVoiceBtn.layer.masksToBounds = true
        recordVoiceBtn.layer.borderWidth = 1
        recordVoiceBtn.layer.borderColor = UIColor.blue.cgColor
        recordVoiceBtn.setImage(image, for: .normal)
        recordVoiceBtn.tintColor = .blue
        
        topRecordViewContraint.constant = (recordView.frame.height)
        bottomRecordViewContraint.constant = (recordView.frame.height)
        view.bringSubview(toFront: discardBtn)
        view.bringSubview(toFront: doneBottomBtn)
        
        closeRecordViewBtn.isHidden = true
    }

    @IBAction func cancelEdit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneEditTop(_ sender: Any) {
    }
    
    @IBAction func discardEdit(_ sender: Any) {
    }
    
    @IBAction func doneEditBottom(_ sender: Any) {
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        
        
        UIView.animate(withDuration: 2, delay: 1, animations: {
            self.topRecordViewContraint.constant = 0
            self.bottomRecordViewContraint.constant = 0
        })
        
        self.view.bringSubview(toFront: self.recordView)
        musicIconImageView.isHidden = true
        closeRecordViewBtn.isHidden = false
        chooseMusicCollectionView.isHidden = true
        
    }
    
    @IBAction func closeRecordView(_ sender: Any) {
        UIView.animate(withDuration: 2, delay: 0, animations: {
            self.topRecordViewContraint.constant = (self.recordView.frame.height)
            self.bottomRecordViewContraint.constant = (self.recordView.frame.height)
        })
        
        self.view.bringSubview(toFront: self.recordView)
        musicIconImageView.isHidden = false
        closeRecordViewBtn.isHidden = true
        chooseMusicCollectionView.isHidden = false
    }
    
    
    func playVideo(url: URL, playerView: UIView)  {
        if playerLayer != nil{
            player?.pause()
            player = nil
            playerLayer = nil
            playerLayer?.removeFromSuperlayer()
        }
        player = AVPlayer(url: url as URL)
        //        var playerItem: AVPlayerItem = AVPlayerItem(asset: avAsset)
        //        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer()
        playerLayer?.player = player
        playerLayer?.frame = playerView.frame
        playerLayer?.backgroundColor = UIColor.white.cgColor
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        playerView.layer.addSublayer(playerLayer!)
        if isShowingVideo{
            player?.play()
        }else{
            player?.pause()
        }
        player?.volume = 0.0
    }
    
    func removeTimer() {
        scrollingTimer?.invalidate()
        if scrollingTimer != nil{
            scrollingTimer = nil
        }
    }
    func setTimer() {
        
        scrollingTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func autoScroll(_ timer: Timer) {
        
        if isShowingVideo{
            
            let currentOffset = slideShowCollectionView.contentOffset
            let contentWidth = slideShowCollectionView.frame.width
            let totalContentWidthOfCV = contentWidth * CGFloat((listAsset?.count)!)
            
            //            if currentOffset.x >= 0 || currentOffset.x <= contentWidth{
            //                let data = ["isPlayMusic": true]
            //                notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
            //            }
            
            if currentOffset.x < totalContentWidthOfCV{
                let newOffsetX = currentOffset.x + contentWidth
                slideShowCollectionView.contentOffset = CGPoint(x: newOffsetX, y: currentOffset.y)
            }else{
                
                let newOffsetX = CGFloat(0.0)
                
                UIView.animate(withDuration: 2, animations: {
                    self.hiddenView.isHidden = false
                    self.hiddenView.alpha = 1
                    self.slideShowCollectionView.alpha = 0
                }, completion: { finished in
                    self.slideShowCollectionView.contentOffset = CGPoint(x: newOffsetX, y: currentOffset.y)
                    self.slideShowCollectionView.reloadData()
                    self.slideShowCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
                    UIView.animate(withDuration: 2, animations: {
                        DispatchQueue.main.async {
                            self.isShowingVideo = false
                            let data = ["isPlayMusic": false]
                            notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotificationCreatePost), object: nil, userInfo: data)
//                                                        self.player?.pause()
                            //                            self.changeImagePauseOrPlayBtn(isPlaying: self.isPlayingSlideShow)
                            //                            self.x = 0
                            self.isEndSlideShow = true
                            self.hiddenView.isHidden = true
                            self.hiddenView.alpha = 0
                            self.slideShowCollectionView.alpha = 1
                            //                                    self.player?.pause()
                        }
                        
                    })
                    
                })
            }
            
        }
        
    }
    
}


