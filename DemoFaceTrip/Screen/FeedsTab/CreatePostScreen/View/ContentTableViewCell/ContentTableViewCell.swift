//
//  ContentTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/31/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import Photos
import GoogleMaps
import GooglePlaces

protocol HeightForTextView {
    func heightOfTextView(height: CGFloat)
    func editSlideShow(listAsset: [AsssetInfor])
}
class ContentTableViewCell: UITableViewCell, UITextViewDelegate {

    var delgate:HeightForTextView?
    
    @IBOutlet weak var contentTextPost: UITextView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var slideShowView: UIView!
    @IBOutlet weak var reloadBtn: UIButton!
    
//    @IBOutlet weak var showTimeLbl: UILabel!
//    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var playerView: UIView!
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var hiddenView: UIView!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var editMapBtn: UIButton!
//    @IBOutlet weak var pauseOrPlayBtn: UIButton!
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
//    @IBOutlet weak var heightOfSlideShowView: NSLayoutConstraint!
    
    var googleMapsView:GMSMapView!
    var locationManager = CLLocationManager()
    var clusterManager: GMUClusterManager!
    
    var scrollingTimer: Timer? = nil
    var displayTimer = Timer()
    var isShowingVideo = true
    var backgroundMusicPlayer: AVAudioPlayer!
    var isEndSlideShow = true
    var timeInterval = 2.0
    
    var listImageAsset: [AsssetInfor] = []
    var listVideoAsset: [AsssetInfor] = []
    
    var videoView: PlayVideoView?
    var player: AVPlayer?
    var playerLayer:AVPlayerLayer?
    
    var listAsset: [AsssetInfor]?{
        didSet{
            if let listAsset = listAsset{
//                slideShowCollectionView.reloadData()
                
//                let images = [UIImage]()
//                for asset in listAsset{
//                    PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
//
//                        self.images.append(image!)
//                    })
//                }
                
//                for asset in listAsset{
//                    if asset.asset?.mediaType == PHAssetMediaType.audio{
//                        listVideoAsset.append(asset)
//                    }
//
//                    if asset.asset?.mediaType == PHAssetMediaType.image{
//                        listImageAsset.append(asset)
//                    }
//                }
//
//                let listImage = getImageFromListAsset(listImageAsset: listImageAsset)
//
//                VideoManager.shareInstance.generateVideoFromListImage(listImage: listImage, viewSize: playerView, completionHandler: { [weak self] url in
//
//                    guard let strongSelf = self else{return}
//                    strongSelf.player = AVPlayer(url: url as URL)
//
//                    strongSelf.playerLayer = AVPlayerLayer()
//                    strongSelf.playerLayer?.player = strongSelf.player
//                    strongSelf.playerLayer?.frame = strongSelf.playerView.frame
//
//                    strongSelf.playerView.layer.addSublayer(strongSelf.playerLayer!)
//                    strongSelf.player?.play()
//                })
                
                slideShowCollectionView.reloadData()
//                layoutIfNeeded()
                
                DispatchQueue.main.async {
                    self.loadMap()
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextPost.delegate = self
        setupView()
        setupButton()
        setupAvatar()
        setupCollectionView()
        addObserverForView()
//        setTimer()
//        addPlayerView()
//        layoutIfNeeded()
    }
    
    
    deinit {
        print("deinit")
    }

    func setupView() {
        slideShowView.layer.cornerRadius = 10
        slideShowView.layer.masksToBounds = true
        
        playerView.layer.cornerRadius = 10
        playerView.layer.masksToBounds = true
        
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
        
//        heightOfSlideShowView.constant = slideShowView.frame.width * (3 / 4)
    }
    
    func addObserverForView() {
        
        notificationCenter.addObserver(self, selector: #selector(playBackgroundMusic(_:)), name: NSNotification.Name(rawValue: keyPlaymusicNotificationCreatePost), object: nil)
        
    }
    
    @objc func playBackgroundMusic(_ notification: NSNotification) {
        if let isPlayMusic = notification.userInfo!["isPlayMusic"] as? Bool, let musicFile = notification.userInfo!["musicFile"] as? String{

            let audioUrl : NSURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: musicFile, ofType: "mp3")!)

            do{
                if backgroundMusicPlayer == nil{
                    backgroundMusicPlayer = try AVAudioPlayer(contentsOf: audioUrl as URL)
                }
            }catch{
                print("can not play file")
            }
            if backgroundMusicPlayer == nil {
                print("Could not create audio player")
                return
            }
            if isPlayMusic{
                print("playing music")
                backgroundMusicPlayer.play()
            }else{
                print("the end play music")
                backgroundMusicPlayer.pause()
                backgroundMusicPlayer = nil
            }
        }
    }
    
    func setupButton() {
        editBtn.tintColor = UIColor.white
        editBtn.setImage(UIImage(named:"edit"), for: UIControlState.normal)
        editBtn.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 40)
        editBtn.titleEdgeInsets = UIEdgeInsets(top: 0,left: -30,bottom: 0,right: 0)
        editBtn.setTitle("Edit", for: UIControlState.normal)
        
        editMapBtn.tintColor = UIColor.white
        editMapBtn.setImage(UIImage(named:"edit"), for: UIControlState.normal)
        editMapBtn.imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 40)
        editMapBtn.titleEdgeInsets = UIEdgeInsets(top: 0,left: -30,bottom: 0,right: 0)
        editMapBtn.setTitle("Edit", for: UIControlState.normal)
        
//        changeImagePauseOrPlayBtn(isPlaying: isShowingVideo)
        
    }
    
    func setupCollectionView() {
        slideShowCollectionView.delegate = self
        slideShowCollectionView.dataSource = self
        slideShowCollectionView.register(UINib.init(nibName: "ImageForSlideShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageForSlideShow")
        slideShowCollectionView.register(UINib.init(nibName: "VideoForSlideShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCell")
    }
    
    func setupAvatar() {
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
        avatarImage.layer.masksToBounds = true
        //avatarImage.clipsToBounds = true
    }
    
    func loadMap() {
        let latitue = 10.958833
        let longtitue = 108.260929
        
//        let location = CLLocationCoordinate2D(latitude: latitue, longitude: longtitue)
        let camera = GMSCameraPosition.camera(withLatitude: latitue, longitude: longtitue, zoom: 12)
        self.googleMapsView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.map.frame.width, height: self.map.frame.height), camera: camera)
        self.googleMapsView.camera = camera
        self.map.addSubview(googleMapsView)
//        googleMapsView.isUserInteractionEnabled = false
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: googleMapsView, clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        clusterManager = GMUClusterManager(map: googleMapsView, algorithm: algorithm, renderer: renderer)
        createClusterItems()
        
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    func createClusterItems() {
        var images = [UIImage]()
        for asset in listAsset!{
            PHImageManager.default().requestImage(for: asset.asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                
                images.append(image!)
            })
        }
        let item = PointItem(position: CLLocationCoordinate2DMake(10.958833, 108.260929), images: images)
        
        let item2 = PointItem(position: CLLocationCoordinate2DMake(10.952448, 108.200280), images: images)
        
        clusterManager.add(item)
        clusterManager.add(item2)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if contentTextPost.text == ""{
            contentTextPost.textColor = .blue
            contentTextPost.text = "What's on your mind?"
        }
        contentTextPost.endEditing(true)
    }
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth: CGFloat = contentTextPost.frame.size.width
        let newSize: CGSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        if let iuDelegate = self.delgate {
            
            iuDelegate.heightOfTextView(height: newSize.height)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentTextPost.text == "What's on your mind?"{
            contentTextPost.text = ""
            contentTextPost.textColor = .black
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editContentSlideShow(_ sender: Any) {
        if backgroundMusicPlayer != nil{
            if playerLayer != nil{
                player?.pause()
                player = nil
                playerLayer = nil
            }
            backgroundMusicPlayer.pause()
            backgroundMusicPlayer = nil
            isShowingVideo = false
        }
        delgate?.editSlideShow(listAsset: listAsset!)
    }
    
    @IBAction func reloadContentSlideShow(_ sender: Any) {
        reloadSlideShow()
    }
    
    func reloadSlideShow() {
        if isShowingVideo{
            if backgroundMusicPlayer != nil{
                if playerLayer != nil{
                    player?.pause()
                    player = nil
                    playerLayer = nil
                }
                backgroundMusicPlayer.pause()
                backgroundMusicPlayer = nil
            }
            let currentOffset = slideShowCollectionView.contentOffset
            slideShowCollectionView.contentOffset = CGPoint(x: 0, y: currentOffset.y)
            slideShowCollectionView.reloadData()
        }else{
            isShowingVideo = true
            slideShowCollectionView.reloadData()
        }
    }
    
    func addPlayerView() {
        videoView = PlayVideoView()
        videoView?.frame = playerView.bounds
        playerView.addSubview(videoView!)
        layoutIfNeeded()
    }
    
    override func layoutSublayers(of layer: CALayer) {
//        videoView?.frame = playerView.bounds
        slideShowCollectionView.frame = playerView.bounds
        layoutIfNeeded()
    }
    
    
//    @IBAction func playSlideShow(_ sender: Any) {
//        if isShowingVideo{
//            isShowingVideo = false
//            changeImagePauseOrPlayBtn(isPlaying: isShowingVideo)
//            backgroundMusicPlayer.pause()
//        }else{
//            isShowingVideo = true
//            changeImagePauseOrPlayBtn(isPlaying: isShowingVideo)
//            if isEndSlideShow{
//                isEndSlideShow = false
//                let data = ["isPlayMusic": true]
//                notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotificationCreatePost), object: nil, userInfo: data)
//            }else{
//                backgroundMusicPlayer.play()
//            }
//
//        }
//    }
    
//    func changeImagePauseOrPlayBtn(isPlaying: Bool) {
//        if isPlaying{
//            let image = UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate)
//            self.pauseOrPlayBtn.setImage(image, for: .normal)
//            self.pauseOrPlayBtn.tintColor = UIColor.white
//        }else{
//            let image = UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
//            self.pauseOrPlayBtn.setImage(image, for: .normal)
//            self.pauseOrPlayBtn.tintColor = UIColor.white
//        }
//
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func generateVideoFromImages(listImageAsset: [AsssetInfor]) {
        
    }
    
    func getImageFromListAsset(listImageAsset: [AsssetInfor]) -> [UIImage] {
        var listImage: [UIImage] = []
        //get image from list asset
        for assetInfo in listImageAsset{
            let asset = assetInfo.asset
            PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                let thumnailImg = VideoManager.shareInstance.getThumnailImage(image: image!)
                listImage.append(thumnailImg)
            })
        }
        return listImage
    }
    
    func getListPathVideoFromListAsset(listVideoAsset: [AsssetInfor]) -> [URL] {
        
        return [URL(fileURLWithPath: "")]
    }
//    var x = 0
//    var countdown: Float = 0.0
    
//    func setTimer() {
//        scrollingTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
//
//        displayTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(displayTime), userInfo: nil, repeats: true)
//    }
    
//    @objc func displayTime() {
//
//        if isShowingVideo{
//            if let listAsset = listAsset{
//                let maxTime = listAsset.count * 2
//                if listAsset.count > 0{
//                    if Int(self.countdown) < maxTime{
//                        countdown += 1.0
//                        UIView.animate(withDuration: 1, animations: {
//                            self.showTimeLbl.text = String(format: "%02d:%02d", ((lround(Double(self.countdown)) / 60) % 60), lround(Double(self.countdown)) % 60)
//                        })
//
//                    }
//                }
//            }
//        }
//
//    }
    
    
//    @objc func autoScroll() {
//        if isShowingVideo{
//            if let listAsset = listAsset{
//                if listAsset.count > 0{
//
//                    if self.x < listAsset.count {
//                        //countdown += 1
//                        //showTimeLbl.text = "\(countdown)"
//
//                        //                    UIView.animate(withDuration: TimeInterval(listAsset.count * 2), animations: {
//                        //                        self.progressView.setProgress(1.0, animated: true)
//                        //                    })
//
//                        UIView.animate(withDuration: 2, animations: {
//                            let value1 = Float(self.x) / Float(listAsset.count - 1)
//                            self.progressView.setProgress(value1, animated: true)
//                        })
//
//                        let newIndexPath = IndexPath(item: x, section: 0)
//
//
//                        self.slideShowCollectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
//
//                        self.x = self.x + 1
//
//                        if self.x == listAsset.count{
//                            UIView.animate(withDuration: 2, animations: {
//                                self.hiddenView.isHidden = false
//                                self.hiddenView.alpha = 1
//                                self.slideShowCollectionView.alpha = 0
//                            }, completion: { finished in
//                                self.slideShowCollectionView.reloadData()
//                                self.slideShowCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
//                                UIView.animate(withDuration: 2, animations: {
//                                    DispatchQueue.main.async {
//                                        let data = ["isPlayMusic": false]
//                                        notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotificationCreatePost), object: nil, userInfo: data)
//                                        self.isShowingVideo = false
//                                        self.isEndSlideShow = true
//                                        self.x = 0
//                                        self.countdown = 0.0
//                                        notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
//                                        self.hiddenView.isHidden = true
//                                        self.hiddenView.alpha = 0
//                                        self.slideShowCollectionView.alpha = 1
//                                        self.progressView.progress = 0.0
//                                        self.showTimeLbl.text = "00:00"
//                                        let image = UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
//                                        self.pauseOrPlayBtn.setImage(image, for: .normal)
//                                        self.pauseOrPlayBtn.tintColor = UIColor.white
//                                    }
//
//                                })
//
//                            })
//                        }
//                    }
//
//                }
//            }
//        }
//
//
//    }
    
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
                            let data = ["isPlayMusic": false, "musicFile": enspired] as [String : Any]
                            notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotificationCreatePost), object: nil, userInfo: data)
//                            self.player?.pause()
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



