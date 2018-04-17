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

    @IBOutlet weak var slideShowView: UIView!
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var slideShowViewParent: UIView!
    @IBOutlet weak var reloadBtn: UIButton!
    @IBOutlet weak var photoOrVideoBtn: UIButton!
    @IBOutlet weak var musicThemeBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timeDisplay: UILabel!
    
    var delegate: EditSlideShowProtocol?
    var delegateCoverSlideShow: EditCoverProtocol?
    var isShowingVideo = true
    var isEndSlideShow = true
    var timeInterval = 2.0
    var scrollingTimer: Timer? = nil
    var displayTimer: Timer? = nil
    
    var listImage: [UIImage] = []
    var listAssetPicked: [AsssetInfor] = []
    var listAsset: [AsssetInfor]?{
        didSet{
            if let listAsset = listAsset{
                for _asset in listAsset{
                    
                    if _asset.isPicked{
                        listAssetPicked.append(_asset)
                        if _asset.asset?.mediaType == .image{
                            totalTime += 3
                        }else{
                            totalTime += 15
                        }
                    }
                }
            }
        }
    }
    var lastContentOffset: CGFloat = 0
//    var selectedIndexPath = IndexPath(item: 0, section: 0)
    var isSellectAll = true
    var isRecording = false
    var totalTime = 0
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    var chooseImageView: ChooseImagesView!
    var musicThemeView: MusicThemeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupButton()
        setDisplayTime()
    }
    
    override func viewWillLayoutSubviews() {
        if chooseImageView != nil{
            chooseImageView.frame = contentView.bounds
        }
        if musicThemeView != nil{
            musicThemeView.frame = contentView.bounds
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notificationCenter.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDefaultColorForNavigation()
        self.navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
        initLeftRightButton(titleLeft: "Back", titleRight: "Done")
        self.title = "Edit SlideShow"
        addObserver()
    }

    func addObserver() {
        addObserverPlayMusicBackground()
        notificationCenter.addObserver(self, selector: #selector(updateListAsset(_:)), name: NSNotification.Name(rawValue: keyUpdateListAssetAfterSellectedOrUnsellected), object: nil)
        notificationCenter.addObserver(self, selector: #selector(updateMusicBackGround), name: NSNotification.Name(rawValue: keyUpdateMusicBackgroundEditSideShowScreen), object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(startRecording(_:)), name: NSNotification.Name(rawValue: keyStopBackgroundEditSlideShowScreen), object: nil)
        notificationCenter.addObserver(self, selector: #selector(finishedRecording(_:)), name: NSNotification.Name(rawValue: keyFinishedRecordEditSlideShowScreen), object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(cancelRecord(_:)), name: NSNotification.Name(rawValue: keyCancelRecoredEditSlideShowScreen), object: nil)
    }
    
    @objc func cancelRecord(_ notification: NSNotification){
        isRecording = false
        musicType = arrayMusic[0]
        reloadSlideShow()
    }
    @objc func finishedRecording(_ notification: NSNotification){
        if let recordFileName = notification.userInfo!["recordFileName"] as? String{
            musicType = recordFileName
            isRecording = false
            progressView.layer.removeAllAnimations()
            reloadSlideShow()
        }
    }
    @objc func startRecording(_ notification: NSNotification){
        if backgroundMusicPlayer != nil{
            backgroundMusicPlayer.pause()
        }
        isRecording = true
        progressView.layer.removeAllAnimations()
        reloadSlideShow()
//        slideShowCollectionView.reloadData()
    }
    
    @objc func updateMusicBackGround(_ notification: NSNotification){
        if let musicStr = notification.userInfo!["typeMusic"] as? String{
            musicType = musicStr
            reloadSlideShow()
        }
    }
    
    @objc func updateListAsset(_ notification: NSNotification) {
        let listAsset = notification.userInfo!["listAsset"] as! [AsssetInfor]
        listAssetPicked = listAsset
        totalTime = 0
        for asset in listAssetPicked{
            if asset.asset?.mediaType == .image{
                totalTime += 3
            }else{
                totalTime += 15
            }
        }
    }
    
    override func leftButton() {
        let data = ["isPlayMusic": false, "musicFile": self.musicType] as [String : Any]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
        delegateCoverSlideShow?.playSlideShow()
        VideoPlayerManager.shareInstance.removePLayerLayer()
        if chooseImageView != nil{
            chooseImageView.removeFromSuperview()
            chooseImageView = nil
        }
        if musicThemeView != nil{
            musicThemeView.removeFromSuperview()
            musicThemeView = nil
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func rightButton() {
        let data = ["isPlayMusic": false, "musicFile": self.musicType] as [String : Any]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
        delegateCoverSlideShow?.playSlideShow()
        navigationController?.popViewController(animated: true)
    }

    
    func setupLayout() {
        setupButton()
        setupCollectionView()
        setupChooseImageView()
        slideShowCollectionView.reloadData()
    }
    
    func setupCollectionView() {
        slideShowCollectionView.delegate = self
        slideShowCollectionView.dataSource = self
        slideShowCollectionView.register(UINib.init(nibName: "ImageForSlideShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageForSlideShow")
        slideShowCollectionView.register(UINib.init(nibName: "VideoForSlideShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCell")
      
    }
    
    func setupButton(){
        
        photoOrVideoBtn.setTitleColor(.black, for: .normal)

        musicThemeBtn.setTitleColor(.gray, for: .normal)
        
        let imgReload = UIImage(named: "reload")?.withRenderingMode(.alwaysTemplate)
        reloadBtn.setImage(imgReload, for: .normal)
        reloadBtn.tintColor = UIColor.white
        
        progressView.progress = 0.0
    }
    
    func setupChooseImageView() {
        chooseImageView = ChooseImagesView(frame: contentView.bounds, listAsset: listAsset!)
        contentView.addSubview(chooseImageView)
        chooseImageView.delegate = self
    }
    
    func setupMusicThemeView() {
        VideoManager.shareInstance.createFolder(nameFolder: "RecordTheme")
        musicThemeView = MusicThemeView(frame: contentView.bounds)
        contentView.addSubview(musicThemeView)
    }
    
    func addObserverForView() {
    
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

        VideoPlayerManager.shareInstance.removePLayerLayer()
        notificationCenter.removeObserver(self)
        
        delegate?.doneEditSlideShow(listAsset: listAssetPicked)
//        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
//    @IBAction func recordAudio(_ sender: Any) {
//
//        backgroundMusicPlayer.stop()
//        backgroundMusicPlayer = nil
//
//        UIView.animate(withDuration: 2, delay: 1, animations: {
//            self.topRecordViewContraint.constant = 0
//            self.bottomRecordViewContraint.constant = 0
//        })
//
//        self.view.bringSubview(toFront: self.recordView)
//        musicIconImageView.isHidden = true
//        closeRecordViewBtn.isHidden = false
//        chooseMusicCollectionView.isHidden = true
//
//    }
//
//    @IBAction func closeRecordView(_ sender: Any) {
//        UIView.animate(withDuration: 2, delay: 0, animations: {
//            self.topRecordViewContraint.constant = (self.recordView.frame.height)
//            self.bottomRecordViewContraint.constant = (self.recordView.frame.height)
//        })
//
//        self.view.bringSubview(toFront: self.recordView)
//        musicIconImageView.isHidden = false
//        closeRecordViewBtn.isHidden = true
//        chooseMusicCollectionView.isHidden = false
//
//        reloadSlideShow()
//    }
    
    
    func removeTimer() {
        scrollingTimer?.invalidate()
        if scrollingTimer != nil{
            scrollingTimer = nil
        }
    }
    func setTimer() {
        
        scrollingTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
    }
    
    func setDisplayTime() {
        displayTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(displayTime), userInfo: nil, repeats: true)
    }
    
    func removeDisplayTimer() {
        displayTimer?.invalidate()
        if displayTimer != nil{
            displayTimer = nil
        }
    }
    
    var countdown: Float = 0.0
    
    @objc func displayTime() {
       
        if isShowingVideo{
            if Int(self.countdown) < totalTime{
                countdown += 1.0
                UIView.animate(withDuration: 1, animations: {
                    self.timeDisplay.text = String(format: "%02d:%02d", ((lround(Double(self.countdown)) / 60) % 60), lround(Double(self.countdown)) % 60)
                })
                
                if Int(self.countdown) == totalTime{
                    if isRecording{
                        notificationCenter.post(name: NSNotification.Name(rawValue: keyStopRecordWhenTheEndTheSlideShow), object: nil)
                    }else{
                        notificationCenter.post(name: NSNotification.Name(rawValue: keyUpdateButtonPauseOrPlayRecord), object: nil)
                    }
                }
            }
        }
    }
    
    @objc func autoScroll(_ timer: Timer) {
        
        if isShowingVideo{
            if listAssetPicked.count > 0{
            let currentOffset = slideShowCollectionView.contentOffset
            let contentWidth = slideShowCollectionView.frame.width
            let totalContentWidthOfCV = contentWidth * CGFloat((listAssetPicked.count - 1))

            
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
                            notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
//                            self.removeTimer()
                            self.removeDisplayTimer()
                            self.timeDisplay.text = "00:00"
                            self.countdown = 0.0
                            self.progressView.progress = 0.0
                            self.isEndSlideShow = true
                            self.hiddenView.isHidden = true
                            self.hiddenView.alpha = 0
                            self.slideShowCollectionView.alpha = 1
                        }
                        
                    })
                    
                })
            }
            
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
            let currentOffset = slideShowCollectionView.contentOffset
            slideShowCollectionView.contentOffset = CGPoint(x: 0, y: currentOffset.y)
            progressView.progress = 0.0
            VideoPlayerManager.shareInstance.removePLayerLayer()
            if !isRecording{
                let data = ["isPlayMusic": false, "musicFile": self.musicType] as [String : Any]
                notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
            }
            removeDisplayTimer()
            countdown = 0.0
            timeDisplay.text = "00:00"
            setDisplayTime()
            slideShowCollectionView.contentOffset = CGPoint(x: 0, y: 0)
            slideShowCollectionView.reloadData()
        }else{
            isShowingVideo = true
            progressView.progress = 0.0
            VideoPlayerManager.shareInstance.removePLayerLayer()
            if !isRecording{
                let data = ["isPlayMusic": false, "musicFile": self.musicType] as [String : Any]
                notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
            }
            setDisplayTime()
            slideShowCollectionView.reloadData()
        }
    }
    
    @IBAction func reloadSlideshow(_ sender: Any) {
        
//        removeDisplayTimer()
//        timeDisplay.text = "00:00"
//        countdown = 0.0
        reloadSlideShow()
    }
    
    @IBAction func displayPhotosOrVideos(_ sender: Any) {
        photoOrVideoBtn.setTitleColor(.black, for: .normal)
        musicThemeBtn.setTitleColor(.gray, for: .normal)
        
        if musicThemeView != nil{
            musicThemeView.removeFromSuperview()
            musicThemeView = nil
            setupChooseImageView()
        }
    }
    
    @IBAction func changeMusicBackground(_ sender: Any) {
        photoOrVideoBtn.setTitleColor(.gray, for: .normal)
        musicThemeBtn.setTitleColor(.black, for: .normal)
        
        if chooseImageView != nil{
            chooseImageView.removeFromSuperview()
            chooseImageView = nil
            setupMusicThemeView()
        }
        
        
    }
    
//    @IBAction func selectOrUnSelectAllImage(_ sender: Any) {
//        if isSellectAll{
//            isSellectAll = false
//            sellectOrUnsellectBtn.setTitle("Sellect All",for: .normal)
//            for item in listAsset!{
//                item.isPicked = false
//                listAssetPicked.append(item)
//            }
//            listImageCollectionView.reloadData()
//
//        }else{
//            isSellectAll = true
//            sellectOrUnsellectBtn.setTitle("UnSellect All",for: .normal)
//            for item in listAsset!{
//                item.isPicked = true
//                listAssetPicked.append(item)
//            }
//            listImageCollectionView.reloadData()
//        }
//    }
    
//    func setupRecorder(){
//        let recordingSession = AVAudioSession.sharedInstance()
//        do {
//            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
//            try recordingSession.setActive(true)
//            recordingSession.requestRecordPermission() { [unowned self] allowed in
//                if allowed {
//                    print("Allow")
//                } else {
//                    print("Dont Allow")
//                }
//            }
//        } catch {
//            print("failed to record!")
//        }
//
//
//    }
    
    
    
    func getUrlRecording() -> URL {
        let manager = FileManager.default
        let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let url = documentDirectory?.appendingPathComponent("recording.m4a")
        return url!
    }
    
    
//    @IBAction func startRecordSound(_ sender: Any) {
//        if audioRecorder == nil{
//
//            let image = UIImage(named: "record")?.withRenderingMode(.alwaysTemplate)
//            recordVoiceBtn.setImage(image, for: .normal)
//            recordVoiceBtn.layer.borderColor = UIColor.red.cgColor
//            recordVoiceBtn.setImage(image, for: .normal)
//            recordVoiceBtn.tintColor = .red
//
//            startRecording()
//
//        }else{
//
//            let image = UIImage(named: "record")?.withRenderingMode(.alwaysTemplate)
//            recordVoiceBtn.setImage(image, for: .normal)
//            recordVoiceBtn.layer.borderColor = UIColor.blue.cgColor
//            recordVoiceBtn.setImage(image, for: .normal)
//            recordVoiceBtn.tintColor = .blue
//
//
//
//            finishRecording(success: true)
//
//            reloadSlideShow()
//        }
//    }
    
//    func startRecording() {
//        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
//        VideoManager.shareInstance.removeFileAtURLIfExists(url: audioFilename as NSURL)
//        musicType = "recording.m4a"
//        let settings = [
//            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//            AVSampleRateKey: 12000,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
//
//        do {
//            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
//            audioRecorder.delegate = self
//            audioRecorder.record()
//
//        } catch {
//            finishRecording(success: false)
//        }
//    }
//
//    func finishRecording(success: Bool) {
//        audioRecorder.stop()
//        audioRecorder = nil
//
//        UIView.animate(withDuration: 2, delay: 0, animations: {
//            self.topRecordViewContraint.constant = (self.recordView.frame.height)
//            self.bottomRecordViewContraint.constant = (self.recordView.frame.height)
//        })
//
//        self.view.bringSubview(toFront: self.recordView)
//        musicIconImageView.isHidden = false
//        closeRecordViewBtn.isHidden = true
//        chooseMusicCollectionView.isHidden = false
//
//        reloadSlideShow()
//    }
    
    
    deinit {
        print("deinit")
        notificationCenter.removeObserver(self)
    }
    
}

extension EditSlideShowViewController: ChooseImageViewProtocol{
    func addMorePhotosOrVideos() {
        let vc = AddMorImageOrVideoViewController()
        vc.listAsset = listAsset!
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    
}
extension EditSlideShowViewController: AddMoreImageOrVideoProtocol{
    func changeDataForSlideShow(listAsset: [AsssetInfor]) {
        self.listAsset = listAsset
        isShowingVideo = true
        totalTime = 0
        for asset in listAsset{
            if asset.asset?.mediaType == .image{
                totalTime += 3
            }else{
                totalTime += 15
            }
        }
        reloadSlideShow()
        chooseImageView.updateImagesPickedView(listAsset: self.listAsset!)
//        listImagesCollectionView.reloadData()
    }
}

//extension EditSlideShowViewController: AVAudioRecorderDelegate, AVAudioPlayerDelegate{
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if !flag {
//            finishRecording(success: false)
//        }
//    }
//}

