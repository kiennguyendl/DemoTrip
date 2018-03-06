//
//  SuggestionTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/24/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import ReadMoreTextView
import Photos
import CoreLocation
import AddressBook
import Contacts



class SuggestionTableViewCell: UITableViewCell {

    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var suggestionBtn: UIButton!
    @IBOutlet weak var textView: ReadMoreTextView!
    
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var slideShowView: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    
    @IBOutlet weak var pauseOrPlayBtn: UIButton!
    @IBOutlet weak var expandBtn: UIButton!
    @IBOutlet weak var speakerBtn: UIButton!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var heightOfImageCollectionView: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var hiddenView: UIView!
    
    @IBOutlet weak var timeViewPlay: UIView!
//    @IBOutlet weak var progressTimeView: UIView!
//    @IBOutlet weak var processTimeContraint: NSLayoutConstraint!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var displayTimeLbl: UILabel!
    var dateFormater: DateFormatter?
    //var listImageHasLocation: [ImagesCreateByDate] = []
    var listImageCreateDate = [ImagesCreateByDate]()
    var listAsset = [AsssetInfor]()
    var assets: [PHAsset] = []
    var listAssetInfor: [AsssetInfor] = []
    var listImage: [UIImage] = []
    var listURLVideo: [URL] = []
    
    var endList = false
    var scrollingTimer: Timer? = nil
    var displayTimer: Timer? = nil
    var isPlayingSlideShow = true
    var isEndSlideShow = false
    
    let notificationCenter = NotificationCenter.default
    var backgroundMusicPlayer: AVAudioPlayer!
    var timeObserver: AnyObject!
    var timePlay = 3
    var currentTimePlay: TimeInterval = 0.0
    var delegate: FeedProtocol?
    
//    let videoUrl : NSURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Viet-Nam-Da-LAB", ofType: "mp4")!)
//    var outputURL: URL?
    var player: AVPlayer?
    var playerLayer:AVPlayerLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateFormater = DateFormatter()
        dateFormater?.dateFormat = "MM-dd-yyyy"
        setupLayout()
//        addObserverForView()
        
        //test ip 8+ and real device
//        fetchImageFromDateToDate(startDate: dateFormater?.date(from: "02-10-2017") as! NSDate, endDate: dateFormater?.date(from: "02-29-2017") as! NSDate)
        
        // test ip 6+
        fetchImageFromDateToDate(startDate: dateFormater?.date(from: "12-26-2017") as! NSDate, endDate: dateFormater?.date(from: "02-27-2018") as! NSDate)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        heightOfImageCollectionView.constant = imageCollectionView.frame.width / 3 - 1
    }
    func addObserverForView() {
        notificationCenter.addObserver(self, selector: #selector(playBackgroundMusic), name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil)
        let data = ["isPlayMusic": true]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
        
    }
    
    
    func setupLayout() {
        
//        self.processTimeContraint.constant = 0
        setUpIcon()
        setupButton()
        setUpAvartar()
        setupCollectionView()
        heightOfImageCollectionView.constant = imageCollectionView.frame.width / 3 - 1
        progressView.progress = 0.0
//        setTimerDisplay()
//        trimVideo(videoUrl: videoUrl as URL)
    }
    
    func setUpIcon() {
        let imageUser = UIImage(named: "user")?.withRenderingMode(.alwaysTemplate)
        imageViewUser.image = imageUser
        imageViewUser.tintColor = .white
        
        let imgPhoto = UIImage(named: "galleryIcon")?.withRenderingMode(.alwaysTemplate)
        imagePhoto.image = imgPhoto
        imagePhoto.tintColor = .white
        
        let image = UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate)
        pauseOrPlayBtn.setImage(image, for: .normal)
        pauseOrPlayBtn.tintColor = UIColor.white
        
        
//        let image = UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate)
//        playPauseBtn.setImage(image, for: .normal)
//        playPauseBtn.tintColor = UIColor.white
//
//        let imgSpeaker = UIImage(named: "speakers")?.withRenderingMode(.alwaysTemplate)
//        speakerBtn.setImage(imgSpeaker, for: .normal)
//        speakerBtn.tintColor = UIColor.white
//
//        let imgExpand = UIImage(named: "expand")?.withRenderingMode(.alwaysTemplate)
//        expandBtn.setImage(imgExpand, for: .normal)
//        expandBtn.tintColor = UIColor.white
    }
    
    func setupCollectionView() {
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(UINib.init(nibName: "ImageOfSuggestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageOfSuggestion")
        
        slideShowCollectionView.delegate = self
        slideShowCollectionView.dataSource = self
        slideShowCollectionView.register(UINib.init(nibName: "ImageForSlideShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageForSlideShow")
        slideShowCollectionView.register(UINib.init(nibName: "VideoForSlideShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCell")
    }
    
    func setupButton() {
        suggestionBtn.layer.cornerRadius = suggestionBtn.frame.height / 2
        suggestionBtn.layer.masksToBounds = true
        suggestionBtn.layer.borderWidth = 2.0
        suggestionBtn.layer.borderColor = UIColor.init(red: 88/255, green: 207/255, blue: 144/255, alpha: 1).cgColor
        
        createBtn.layer.cornerRadius = createBtn.frame.height / 10
        createBtn.layer.masksToBounds = true
    }
    func setUpAvartar() {
        avatarView.clipsToBounds = false
        
        avatarView.layer.shadowColor = UIColor.black.cgColor
        avatarView.layer.shadowOpacity = 0.5
        avatarView.layer.shadowOffset = CGSize(width: 0.0,height: 1.0)
        avatarView.layer.shadowRadius = 3
        avatarView.layer.shadowPath = UIBezierPath(roundedRect: avatarView.bounds, cornerRadius: avatarView.frame.width / 2).cgPath
        avatarView.backgroundColor = .clear
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        
    }
    
    func setupPlayer() {
        if playerLayer != nil{
            player = nil
            playerLayer = nil
            playerLayer?.removeFromSuperlayer()
        }
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
//        player?.play()
        player?.volume = 0.0
    }
    
    @objc func sliderValueChange(slider: UISlider) {
    }
    
    @objc func playBackgroundMusic(_ notification: NSNotification) {
        if let isPlayMusic = notification.userInfo!["isPlayMusic"] as? Bool{
            
            let audioUrl : NSURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "01 The Moment", ofType: "mp3")!)
            
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
                backgroundMusicPlayer.stop()
                backgroundMusicPlayer = nil
            }
        }
    }
    
    @objc func runProgressBar() {
        UIView.animate(withDuration: TimeInterval(listAsset.count * 2), animations: {
            self.progressView.setProgress(1.0, animated: true)
        })
    }
    
    func fetchImageFromDateToDate(startDate: NSDate, endDate: NSDate) {
        let imageManager = PHImageManager()
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
//        requestOption.deliveryMode = .fastFpoormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "creationDate >= %@ AND creationDate <= %@ AND mediaType == %d || mediaType == %d", startDate, endDate, PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: fetchOptions)
        DispatchQueue.global(qos: .background).async{
            if fetchResult.count > 0 {
                print("num photo: \(fetchResult.count)")
                
                for i in 0..<fetchResult.count {
                    let asset = fetchResult.object(at: i)
                    let location = asset.location
                    let createDate = asset.creationDate
                    let assetInfor = AsssetInfor(location: location, createDate: createDate!, asset: asset)
                    self.listAssetInfor.append(assetInfor)
                }
                
                self.classifyImageByCreateDate(listImage: self.listAssetInfor, completionHanler: {[weak self] data in
                    guard let strongSelf = self else{return}
                    //strongSelf.listImageCreateDate = data
                    let arrayInfor = strongSelf.convertDictToArray(dict: data)
                    strongSelf.listImageCreateDate = strongSelf.sortListPhoto(listImage: arrayInfor)
                    
                    strongSelf.listAsset = []
                    for index in strongSelf.listImageCreateDate{
//                        strongSelf.listAsset
                        if let listAssetInfor = index.imagesCreateByDate{
                            strongSelf.listAsset += listAssetInfor
                        }
                    }
                    
                    DispatchQueue.main.async {
                        
                        if strongSelf.listAsset.count == fetchResult.count{
                            strongSelf.slideShowCollectionView.reloadData()
                            strongSelf.imageCollectionView.reloadData()
                        }
                        
                    }
                    
                })
            }
        }
        
    }
    
    func getAddressFromLocation(location: CLLocation) -> String{
        let geocoder = CLGeocoder()
        var place = "kaka"
        geocoder.reverseGeocodeLocation(location) { (data, error) -> Void in
            
            //get address and extract city and state
            let address = data![0].postalAddress!
            let city = address.city
            let detailAddress = address.street + ", " + address.subAdministrativeArea + ", " + address.subLocality
            place = city + ", " + detailAddress
            
        }
        return place
    }
    
    func convertDictToArray(dict: [String: [AsssetInfor]]) -> [ImagesCreateByDate]{
        var dictArr = [ImagesCreateByDate]()
        for (key, value) in dict{
            let imgCreateByDate = ImagesCreateByDate(createDate: key, imagesCreateByDate: value)
            dictArr.append(imgCreateByDate)
        }
        
        
        return dictArr
    }
    
    func sortListPhoto(listImage: [ImagesCreateByDate]) -> [ImagesCreateByDate] {
        return listImage.sorted (by: {$0.imagesCreateByDate![0].createDate! > $1.imagesCreateByDate![0].createDate!})
    }
    func classifyImageByCreateDate(listImage: [AsssetInfor], completionHanler: @escaping([String: [AsssetInfor]]) -> Void){
        var listDictImageCreateDate = [String: [AsssetInfor]]()
        //    print("number image: \(listImage.count)")
        for img in listImage{
            
            if let createDate = img.createDate{
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "MM-dd-yyyy"
                let createDateStr = dateFormater.string(from: createDate)
                
                if let location = img.location{
                    let geocoder = CLGeocoder()
                    
                    geocoder.reverseGeocodeLocation(location) { (data, error) -> Void in
                        
                        //get address and extract city and state
                        guard let data = data else {return}
                        let address = data[0].postalAddress!
                        let city = address.city
                        var detailAddress = ""
                        if address.subLocality != ""{
                            detailAddress += address.subLocality
                        }
                        if address.subAdministrativeArea != ""{
                            detailAddress += " ," + address.subAdministrativeArea
                        }
                        var place = city
                        if detailAddress != ""{
                            place += ", " + detailAddress
                        }
                        
                        let key = createDateStr + "\n" + place
                        
                        if listDictImageCreateDate.count > 0{
                            
                            if listDictImageCreateDate.keys.contains(key){
                                listDictImageCreateDate[key]?.append(img)
                            }else{
                                
                                listDictImageCreateDate[key] = [AsssetInfor]()
                                listDictImageCreateDate[key]?.append(img)
                            }
                        }else{
                            listDictImageCreateDate[key] = [AsssetInfor]()
                            listDictImageCreateDate[key]?.append(img)
                            print("ahihi")
                        }
                        completionHanler(listDictImageCreateDate)
                    }
                    
                }else{
                    if listDictImageCreateDate.count > 0{
                        if listDictImageCreateDate.keys.contains(createDateStr){
                            listDictImageCreateDate[createDateStr]?.append(img)
                        }else{
                            
                            listDictImageCreateDate[createDateStr] = [AsssetInfor]()
                            listDictImageCreateDate[createDateStr]?.append(img)
                        }
                    }else{
                        listDictImageCreateDate[createDateStr] = [AsssetInfor]()
                        listDictImageCreateDate[createDateStr]?.append(img)
                    }
                }
                
            }
            completionHanler(listDictImageCreateDate)
        }
    }
    var timeInterval = 2.0
    func setTimer() {
        
        scrollingTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)

        
    }
    
    //dispay time on label
    
    func setTimerDisplay() {
        displayTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(displayTime), userInfo: nil, repeats: true)
    }
    var countdown: Float = 0.0
    
    @objc func displayTime() {
        let maxTime = listAsset.count * 2 + 15
//        if isPlayingSlideShow{
        if listAsset.count > 0{
            if Int(self.countdown) < maxTime{
                countdown += 1.0
            UIView.animate(withDuration: 1, animations: {
                self.displayTimeLbl.text = String(format: "%02d:%02d", ((lround(Double(self.countdown)) / 60) % 60), lround(Double(self.countdown)) % 60)
            })
            
            }
        }
//        }
    }
    //////////////////////////////
    
    var x = 0
    
    @objc func autoScroll(_ timer: Timer) {
        
        let dict = timer.userInfo as! [String: Any]
        let indexRow = dict["indexRow"] as! Int
        let typeCell = dict["typeCell"] as! String
        let cell = dict["cell"]
//
//
//            print(indexItem)
//            if (indexItem + 1) != self.listAsset.count{
//                let currentIndexPath = IndexPath(row: indexItem, section: 0)
//
////                if typeCell == "Image"{
////                    let currentCell = self.slideShowCollectionView.cellForItem(at: currentIndexPath) as! ImageForSlideShowCollectionViewCell
////                    currentCell.scrollingTimer?.invalidate()
////                }else{
////                    let currentCell = self.slideShowCollectionView.cellForItem(at: currentIndexPath) as! VideoForSlideShowCollectionViewCell
////                    currentCell.scrollingTimer?.invalidate()
////                }
//
//
//                let nextCellIndexPath = IndexPath(row: indexItem + 1, section: 0)
//                self.slideShowCollectionView.scrollToItem(at: nextCellIndexPath, at: .centeredHorizontally, animated: true)
//
//
////                let contentOffset: CGPoint = {
////                    let item = (indexItem+1) % self.listAsset.count
////                    return self.slideShowCollectionView.contentOffset
////                }()
////                self.slideShowCollectionView.setContentOffset(contentOffset, animated: true)
//
//
//            }else{
//                UIView.animate(withDuration: 2, animations: {
//                    self.hiddenView.isHidden = false
//                    self.hiddenView.alpha = 1
//                    self.slideShowCollectionView.alpha = 0
//                }, completion: { finished in
//                    self.slideShowCollectionView.reloadData()
//                    self.slideShowCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
//                    UIView.animate(withDuration: 2, animations: {
//                        DispatchQueue.main.async {
//                            self.isPlayingSlideShow = false
//                            self.isEndSlideShow = true
//                            self.hiddenView.isHidden = true
//                            self.hiddenView.alpha = 0
//                            self.slideShowCollectionView.alpha = 1
//                        }
//
//                    })
//
//                })
//            }
        
        
        
        
        
        
        if isPlayingSlideShow{
            if listAsset.count > 0{

                if self.x < self.listAsset.count {
                    print("x: \(x)")
//                    UIView.animate(withDuration: TimeInterval(Float(self.listAsset.count * 2)), delay: 0,  animations: {
//                        self.progressView.setProgress(1.0, animated: true)
////                        self.sliderBar.setValue(self.sliderBar.maximumValue, animated: true)
//
//                    })

//                    UIView.animate(withDuration: timeInterval, animations: {
//                        if self.x == 0{
////                            let cell = slideShowCollectionView.cellForItem(at: )
//                            self.player?.play()
//                            let value1 = Float(15.0) / Float(self.listAsset.count - 1 + 15)
////                            print("value: \(value1)")
//                            self.progressView.setProgress(value1, animated: true)
//                        }else{
//                            let value1 = Float(15 + self.x) / Float(self.listAsset.count - 1 + 15)
////                            print("value: \(value1)")
//                            self.progressView.setProgress(value1, animated: true)
//                        }
//
//                    })


                    let newIndexPath = IndexPath(item: x, section: 0)

                    self.slideShowCollectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
                    
//                    if x > 0{
                        let currentPath = IndexPath(item: x - 1, section: 0)
                        
                        if typeCell == "image"{
                            if let cell = cell as? ImageForSlideShowCollectionViewCell{
                                print("image")
                                cell.showImageView.transform = CGAffineTransform.identity
                                UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
                                    
                                    cell.showImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                }, completion: { finished in
//                                    cell.showImageView.transform = CGAffineTransform.identity
                                })

                            }
                            
                        }else{
                            if let cell = cell as? VideoForSlideShowCollectionViewCell{
//                                player?.play()
                                print("video")
//                                UIView.animate(withDuration: 15.0, delay: 0, options: [], animations: {
                                
//                                }, completion: { finished in
//
//                                })
                            }
                            
                        }
                        
//                    }
                    

                    //                     let cell = self.slideShowCollectionView.cellForItem(at: newIndexPath) as!ImageForSlideShowCollectionViewCell

                    //                    UIView.animate(withDuration: 2, animations: {
                    //                        cell.showImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    //                    }, completion: {fineshed in
                    //                        cell.showImageView.transform = CGAffineTransform.identity
                    //                    })

                    self.x = self.x + 1

                    if self.x == self.listAsset.count{
                        UIView.animate(withDuration: 2, animations: {
                            self.hiddenView.isHidden = false
                            self.hiddenView.alpha = 1
                            self.slideShowCollectionView.alpha = 0
                        }, completion: { finished in
                            self.slideShowCollectionView.reloadData()
                            self.slideShowCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
                            UIView.animate(withDuration: 2, animations: {
                                DispatchQueue.main.async {
                                    self.isPlayingSlideShow = false
                                    self.changeImagePauseOrPlayBtn(isPlaying: self.isPlayingSlideShow)
                                    self.x = 0
//                                    self.countdown = 0.0
                                    self.isEndSlideShow = true
//                                    let data = ["isPlayMusic": false]
//                                    self.notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
                                    self.hiddenView.isHidden = true
                                    self.hiddenView.alpha = 0
                                    self.slideShowCollectionView.alpha = 1
//                                    self.progressView.progress = 0.0
//                                    self.displayTimeLbl.text = "00:00"
//                                    let image = UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
//                                    self.playPauseBtn.setImage(image, for: .normal)
//                                    self.playPauseBtn.tintColor = UIColor.white
//                                    self.player?.pause()
                                }

                            })

                        })
                    }
                }

            }
        }
        
    }
    
    
    
    
    @IBAction func pauseOrPlayVideo(_ sender: Any) {
//        if isPlayingSlideShow{
//            isPlayingSlideShow = false
//            changeImagePauseOrPlayBtn(isPlaying: isPlayingSlideShow)
//            backgroundMusicPlayer.pause()
//            player?.pause()
//        }else{
//            isPlayingSlideShow = true
//            changeImagePauseOrPlayBtn(isPlaying: isPlayingSlideShow)
//            if isEndSlideShow{
//                let data = ["isPlayMusic": true]
//                notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
//                player?.play()
//            }else{
//                backgroundMusicPlayer.play()
//                player?.play()
//            }
//
//        }
        
    }
    
    @IBAction func pauseOrPlayAction(_ sender: Any) {
        if isPlayingSlideShow{
            isPlayingSlideShow = false
            changeImagePauseOrPlayBtn(isPlaying: isPlayingSlideShow)
        }else{
            isPlayingSlideShow = true
            changeImagePauseOrPlayBtn(isPlaying: isPlayingSlideShow)
        }
    }
    
    
    func changeImagePauseOrPlayBtn(isPlaying: Bool) {
        if isPlaying{
            let image = UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate)
            self.pauseOrPlayBtn.setImage(image, for: .normal)
            self.pauseOrPlayBtn.tintColor = UIColor.white
        }else{
            let image = UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
            self.pauseOrPlayBtn.setImage(image, for: .normal)
            self.pauseOrPlayBtn.tintColor = UIColor.white
        }
        
    }
    
    @IBAction func createPost(_ sender: Any) {
        if isPlayingSlideShow{
            isPlayingSlideShow = false
//            backgroundMusicPlayer.pause()
//            currentTimePlay = backgroundMusicPlayer.currentTime
//            player?.pause()
            changeImagePauseOrPlayBtn(isPlaying: isPlayingSlideShow)
            removeTimer()
        }
        delegate?.createPost(listAsset: listAsset)
    }
    
    func removeTimer() {
        scrollingTimer?.invalidate()
        if scrollingTimer != nil{
            scrollingTimer = nil
        }
    }
    
    
    
    
}


