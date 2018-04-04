//
//  EditSlideShowViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 2/6/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

protocol EditSlideShowProtocol {
    func doneEditSlideShow(listAsset: [AsssetInfor])
}

class EditSlideShowViewController: BaseViewController {

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
    
    @IBOutlet weak var reloadBtn: UIButton!
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
    
    var delegate: EditSlideShowProtocol?
    var isShowingVideo = true
    var isEndSlideShow = true
    var timeInterval = 2.0
    var scrollingTimer: Timer? = nil
    var backgroundMusicPlayer: AVAudioPlayer!
    var player: AVPlayer?
    var playerLayer:AVPlayerLayer?
    
    var listImage: [UIImage] = []
    var listAssetPicked: [AsssetInfor] = []
    var listAsset: [AsssetInfor]?{
        didSet{
            if let listAsset = listAsset{
                for _asset in listAsset{
//                    let asset = _asset.asset
//                    PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
//
//                        self.listImage.append(image!)
//                    })
                    
                    if _asset.isPicked{
                        listAssetPicked.append(_asset)
                    }
                }
                
//                slideShowCollectionView.reloadData()
                
            }
        }
    }
    var listMusic = ["Inspired", "Birthday", "Playful", "Epic", "Happy"]
    var musicType = arrayMusic[0]
    var lastContentOffset: CGFloat = 0
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var isSellectAll = true
    var isRecording = false
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
//        recordVoiceBtn.addGestureRecognizer(longGesture)
        
        setupLayout()
        setupRecorder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if backgroundMusicPlayer != nil{
            if playerLayer != nil{
                player?.pause()
                player = nil
                playerLayer = nil
            }
            backgroundMusicPlayer = nil
        }
        notificationCenter.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
        initLeftRightButton(titleLeft: "Cancel", titleRight: "Post")
        self.title = "Edit SlideShow"
        addObserverForView()
    }

    
    override func initLeftRightButton(titleLeft: String, titleRight: String) {
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: titleLeft, style: .done, target: self, action: #selector(leftButton))
        navigationItem.leftBarButtonItem = cancelButton
        
        let postButton: UIBarButtonItem = UIBarButtonItem(title: titleRight, style: .done, target: self, action: #selector(rightButton))
        navigationItem.rightBarButtonItem = postButton
    }
    
    override func leftButton() {
        //        delegate?.cancelCreatePost()
        //        let data = ["isPlayMusic": false]
        //        notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotificationCreatePost), object: nil, userInfo: data)
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
        VideoPlayerManager.shareInstance.removePLayerLayer()
        navigationController?.popViewController(animated: true)
    }
    
    override func rightButton() {
        
    }

    
    func setupLayout() {
        setupButton()
        setupCollectionView()
        slideShowCollectionView.reloadData()
//        addObserverForView()
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
        listImageCollectionView.register(UINib.init(nibName: "VideoItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoItemCell")
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
        
        
        let imgReload = UIImage(named: "reload")?.withRenderingMode(.alwaysTemplate)
        reloadBtn.setImage(imgReload, for: .normal)
        reloadBtn.tintColor = UIColor.white
    }
    
    func addObserverForView() {
        
        notificationCenter.addObserver(self, selector: #selector(playBackgroundMusic(_:)), name: NSNotification.Name(rawValue: keyPlaymusicNotificationEditPost), object: nil)
        
    }
    
    @objc func playBackgroundMusic(_ notification: NSNotification) {
        if let isPlayMusic = notification.userInfo!["isPlayMusic"] as? Bool, let musicFile = notification.userInfo!["musicFile"] as? String{
            let fileManager = FileManager.default
//            let audioUrl: NSURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: musicFile, ofType: "mp3")!)
           
            var audioUrl = getDocumentsDirectory().appendingPathComponent(musicFile)
            
            if !fileManager.fileExists(atPath: audioUrl.path){
                audioUrl = NSURL(fileURLWithPath: Bundle.main.path(forResource: musicFile, ofType: "mp3")!) as URL
            }
            
            do{
                if backgroundMusicPlayer == nil{
                    backgroundMusicPlayer = try AVAudioPlayer(contentsOf: audioUrl)
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

//    @IBAction func cancelEdit(_ sender: Any) {
//        VideoPlayerManager.shareInstance.removePLayerLayer()
//
//        if backgroundMusicPlayer != nil{
//
//            backgroundMusicPlayer.pause()
//            backgroundMusicPlayer = nil
//            isShowingVideo = false
//        }
//
//        notificationCenter.removeObserver(self)
//        dismiss(animated: true, completion: nil)
//    }
//    
//    @IBAction func doneEditTop(_ sender: Any) {
//    }
    
    @IBAction func discardEdit(_ sender: Any) {
    }
    
    @IBAction func doneEditBottom(_ sender: Any) {
        listAssetPicked.removeAll()
        for item in listAsset!{
            if item.isPicked{
                listAssetPicked.append(item)
            }
        }
        
        if backgroundMusicPlayer != nil{
            backgroundMusicPlayer.pause()
            backgroundMusicPlayer = nil
            isShowingVideo = false
        }
        
//        if playerLayer != nil{
//            player?.pause()
//            player = nil
//            playerLayer = nil
//            playerLayer?.removeFromSuperlayer()
//        }
        
        VideoPlayerManager.shareInstance.removePLayerLayer()
        notificationCenter.removeObserver(self)
        
        delegate?.doneEditSlideShow(listAsset: listAssetPicked)
//        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        
        backgroundMusicPlayer.stop()
        backgroundMusicPlayer = nil
        
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
        
        reloadSlideShow()
    }
    
    
    func playVideo(url: URL, playerView: UIView)  {
        DispatchQueue.main.async {
            if self.playerLayer != nil{
                self.player?.pause()
                self.player = nil
                self.playerLayer = nil
                self.playerLayer?.removeFromSuperlayer()
                playerView.layer.sublayers = nil
            }
            self.player = AVPlayer(url: url as URL)
            //        var playerItem: AVPlayerItem = AVPlayerItem(asset: avAsset)
            //        player = AVPlayer(playerItem: playerItem)
            self.playerLayer = AVPlayerLayer()
            self.playerLayer?.player = self.player
            self.playerLayer?.frame = playerView.frame
            self.playerLayer?.backgroundColor = UIColor.white.cgColor
            self.playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            
            playerView.layer.addSublayer(self.playerLayer!)
            if self.isShowingVideo{
                self.player?.play()
            }else{
                self.player?.pause()
            }
            self.player?.volume = 0.0
        }
        
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
            let totalContentWidthOfCV = contentWidth * CGFloat((listAssetPicked.count))
            
            //            if currentOffset.x >= 0 || currentOffset.x <= contentWidth{
            //                let data = ["isPlayMusic": true]
            //                notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
            //            }
            
            if currentOffset.x < totalContentWidthOfCV{
                let newOffsetX = currentOffset.x + contentWidth
                slideShowCollectionView.contentOffset = CGPoint(x: newOffsetX, y: currentOffset.y)
            }else{
                
                let newOffsetX = CGFloat(0.0)
                
                UIView.animate(withDuration: 3, animations: {
                    self.hiddenView.isHidden = false
                    self.hiddenView.alpha = 1
                    self.slideShowCollectionView.alpha = 0
                }, completion: { finished in
                    self.slideShowCollectionView.contentOffset = CGPoint(x: newOffsetX, y: currentOffset.y)
                    self.slideShowCollectionView.reloadData()
                    self.slideShowCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
                    UIView.animate(withDuration: 3, animations: {
                        DispatchQueue.main.async {
                            self.isShowingVideo = false
                            let data = ["isPlayMusic": false, "musicFile": self.musicType] as [String : Any]
                            notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotificationEditPost), object: nil, userInfo: data)
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
    
    func reloadSlideShow() {
        listAssetPicked = []
        for item in listAsset!{
            if item.isPicked{
                listAssetPicked.append(item)
            }
        }
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
    
    @IBAction func reloadSlideshow(_ sender: Any) {
        
        reloadSlideShow()
    }
    
    @IBAction func selectOrUnSelectAllImage(_ sender: Any) {
        if isSellectAll{
            isSellectAll = false
            sellectOrUnsellectBtn.setTitle("Sellect All",for: .normal)
            for item in listAsset!{
                item.isPicked = false
                listAssetPicked.append(item)
            }
            listImageCollectionView.reloadData()
            
        }else{
            isSellectAll = true
            sellectOrUnsellectBtn.setTitle("UnSellect All",for: .normal)
            for item in listAsset!{
                item.isPicked = true
                listAssetPicked.append(item)
            }
            listImageCollectionView.reloadData()
        }
    }
    
    func setupRecorder(){
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                if allowed {
                    print("Allow")
                } else {
                    print("Dont Allow")
                }
            }
        } catch {
            print("failed to record!")
        }
        
        
    }
    
    
    
    func getUrlRecording() -> URL {
        let manager = FileManager.default
        let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let url = documentDirectory?.appendingPathComponent("recording.m4a")
        return url!
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @IBAction func startRecordSound(_ sender: Any) {
        if audioRecorder == nil{
            
            let image = UIImage(named: "record")?.withRenderingMode(.alwaysTemplate)
            recordVoiceBtn.setImage(image, for: .normal)
            recordVoiceBtn.layer.borderColor = UIColor.red.cgColor
            recordVoiceBtn.setImage(image, for: .normal)
            recordVoiceBtn.tintColor = .red
            
            startRecording()
            
        }else{
            
            let image = UIImage(named: "record")?.withRenderingMode(.alwaysTemplate)
            recordVoiceBtn.setImage(image, for: .normal)
            recordVoiceBtn.layer.borderColor = UIColor.blue.cgColor
            recordVoiceBtn.setImage(image, for: .normal)
            recordVoiceBtn.tintColor = .blue
            
            
            
            finishRecording(success: true)
            
            reloadSlideShow()
        }
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        VideoManager.shareInstance.removeFileAtURLIfExists(url: audioFilename as NSURL)
        musicType = "recording.m4a"
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        UIView.animate(withDuration: 2, delay: 0, animations: {
            self.topRecordViewContraint.constant = (self.recordView.frame.height)
            self.bottomRecordViewContraint.constant = (self.recordView.frame.height)
        })
        
        self.view.bringSubview(toFront: self.recordView)
        musicIconImageView.isHidden = false
        closeRecordViewBtn.isHidden = true
        chooseMusicCollectionView.isHidden = false
        
        reloadSlideShow()
    }
    
    
    deinit {
        print("deinit")
        notificationCenter.removeObserver(self)
    }
    
}

extension EditSlideShowViewController: AddMoreImageOrVideoProtocol{
    func changeDataForSlideShow(listAsset: [AsssetInfor]) {
        self.listAsset = listAsset
//        listAssetPicked = listAsset
        isShowingVideo = true
        reloadSlideShow()
        listImageCollectionView.reloadData()
    }
    
    
}

extension EditSlideShowViewController: AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}

