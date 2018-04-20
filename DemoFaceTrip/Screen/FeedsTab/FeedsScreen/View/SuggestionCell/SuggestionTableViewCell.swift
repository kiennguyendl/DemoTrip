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
    
    @IBOutlet weak var detailTripLbl: UILabel!
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
    weak var player: AVPlayer?
    weak var playerLayer:AVPlayerLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateFormater = DateFormatter()
        dateFormater?.dateFormat = "MM-dd-yyyy"
        setupLayout()
//        addObserverForView()
        
        //test ip 8+ and real device
//        fetchImageFromDateToDate(startDate: dateFormater?.date(from: "03-25-2018") as! NSDate, endDate: dateFormater?.date(from: "03-28-2018") as! NSDate)
        
        // test ip 6+
        fetchImageFromDateToDate(startDate: dateFormater?.date(from: "02-06-2017")! as! NSDate, endDate: dateFormater?.date(from: "02-28-2018") as! NSDate)
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
        
        let image = UIImage(named: "reload")?.withRenderingMode(.alwaysTemplate)
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
        
//        if playerLayer == nil{
//            player = AVPlayer(url: url as URL)
//            //        var playerItem: AVPlayerItem = AVPlayerItem(asset: avAsset)
//            //        player = AVPlayer(playerItem: playerItem)
//
//            playerLayer = AVPlayerLayer()
//            playerLayer?.player = player
//            playerLayer?.frame = playerView.frame
//            playerLayer?.backgroundColor = UIColor.white.cgColor
//            playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//
//            playerView.layer.addSublayer(playerLayer!)
//            player?.volume = 0.0
//            player?.play()
//        }else{
//            player = nil
//            player = AVPlayer(url: url as URL)
//            playerLayer?.player = nil
//            playerLayer?.player = player
//            player?.play()
//        }
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
        if self.isPlayingSlideShow{
            self.player?.play()
        }else{
            self.player?.pause()
        }
        self.player?.volume = 0.0
            
        }
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
        var count = 0
        let imageManager = PHImageManager()
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
//        requestOption.deliveryMode = .fastFpoormat
        
        let fetchOptions = PHFetchOptions()
        
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "(mediaType == %d || mediaType == %d)", PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)
        
//        fetchOptions.predicate = NSPredicate(format: "(creationDate >= %@ AND creationDate <= %@) AND (mediaType == %d || mediaType == %d)", startDate, endDate, PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: fetchOptions)
        DispatchQueue.global(qos: .background).async{
            if fetchResult.count > 0 {
                print("num photo: \(fetchResult.count)")
                
                for i in 0..<fetchResult.count {
                    let asset = fetchResult.object(at: i)
                    let location = asset.location
//                    print("location: \(location)")
                    if location != nil{
//                        print("location: \((location?.coordinate.latitude)!) + \((location?.coordinate.longitude)!)")
                        
                        let latitude = self.roundNum(a: (location?.coordinate.latitude)!)
                        let longitude = self.roundNum(a: (location?.coordinate.longitude)!)
                        
                        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        let createDate = asset.creationDate
                        let assetInfor = AsssetInfor(location: location, createDate: createDate!, asset: asset, isPicked: true)
                        self.listAssetInfor.append(assetInfor)
                        count += 1
                    }
                    
                    if count == 15{
                        break
                    }
//                    let createDate = asset.creationDate
//                    let assetInfor = AsssetInfor(location: location, createDate: createDate!, asset: asset, isPicked: true)
//                    self.listAssetInfor.append(assetInfor)
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
                        
                        if strongSelf.listAsset.count == count{
//                            let sortedDict = ImagesManager.shareInstance.groupdImagesByLocation(listAsset: strongSelf.listAsset)
                            
                            for list in strongSelf.listAsset{
                                print("\nlocal hihi: \((list.location)!)")
                            }
                            let numberLocation = strongSelf.groupdImagesByLocation(listAsset: strongSelf.listAsset).count
                            self?.detailTripLbl.text = "#4 Days, #\(strongSelf.listAsset.count) moments, #\(numberLocation) Locations, #6 Peoples"
                            
                            strongSelf.slideShowCollectionView.reloadData()
                            strongSelf.imageCollectionView.reloadData()
                        }
                        
                    }
                    
                })
            }
        }
        
    }
    
    func roundNum(a:Double)->Double{
        let mu = pow(10.0,2.0)
        let r = round(a*mu) / mu
        return r
    }
    
    func groupdImagesByLocation(listAsset: [AsssetInfor]) -> [CLLocationCoordinate2D: [AsssetInfor]] {
        var dictImageCreateByLocation = [CLLocationCoordinate2D: [AsssetInfor]]()
        
        for assetInfor in listAsset{
            
            if let key = assetInfor.location{
                print("\nlocation kaka: \(key)")
                if dictImageCreateByLocation.count > 0{
                    if dictImageCreateByLocation.keys.contains(key){
                        dictImageCreateByLocation[key]?.append(assetInfor)
                    }else{
                        dictImageCreateByLocation[key] = [AsssetInfor]()
                        dictImageCreateByLocation[key]?.append(assetInfor)
                    }
                }else{
                    dictImageCreateByLocation[key] = [AsssetInfor]()
                    dictImageCreateByLocation[key]?.append(assetInfor)
                }
            }
        }
        
        //        for (k,v) in (Array(dictImageCreateByLocation).sorted{$0.1[0].createDate! < $1.1[0].createDate!}){
        //            print("\(k): \(v)")
        //        }
        
        return dictImageCreateByLocation
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
                    let loca = CLLocation(latitude: location.latitude, longitude: location.longitude)
                    geocoder.reverseGeocodeLocation(loca) { (data, error) -> Void in
                        
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
    
//    var x = 0
    
    @objc func autoScroll(_ timer: Timer) {
  
        if isPlayingSlideShow{
            
            let currentOffset = slideShowCollectionView.contentOffset
            let contentWidth = slideShowCollectionView.frame.width
            let totalContentWidthOfCV = contentWidth * CGFloat(listAsset.count - 1)
            
            
            if currentOffset.x < totalContentWidthOfCV{
                let newOffsetX = currentOffset.x + contentWidth
                slideShowCollectionView.contentOffset = CGPoint(x: newOffsetX, y: currentOffset.y)
            }else{
                
                let newOffsetX = CGFloat(0.0)
                
                UIView.animate(withDuration: 2, animations: {
                    self.hiddenView.isHidden = false
                    self.hiddenView.alpha = 1
                    self.slideShowCollectionView.alpha = 0
//                    if self.backgroundMusicPlayer != nil{
//                        self.backgroundMusicPlayer.stop()
//                        self.backgroundMusicPlayer = nil
//                    }
//                    
//                    if self.playerLayer != nil{
//                        self.player?.pause()
//                        self.player = nil
//                        self.playerLayer = nil
//                    }
                }, completion: { finished in
                    self.slideShowCollectionView.contentOffset = CGPoint(x: newOffsetX, y: currentOffset.y)
                    self.slideShowCollectionView.reloadData()
                    self.slideShowCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
                    UIView.animate(withDuration: 2, animations: {
                        DispatchQueue.main.async {
                            self.isPlayingSlideShow = false
                            self.player?.pause()
                            self.changeImagePauseOrPlayBtn(isPlaying: self.isPlayingSlideShow)
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

            
            
//            if listAsset.count > 0{
//
//                if self.x < self.listAsset.count {
//                    print("x: \(x)")
//
//                    let newIndexPath = IndexPath(item: x, section: 0)
//
//                    self.slideShowCollectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
//
//
//                    let currentPath = IndexPath(item: x - 1, section: 0)
//
//                    self.x = self.x + 1
//
//                    if self.x == self.listAsset.count{
//                        UIView.animate(withDuration: 2, animations: {
//                            self.hiddenView.isHidden = false
//                            self.hiddenView.alpha = 1
//                            self.slideShowCollectionView.alpha = 0
//                        }, completion: { finished in
//                            self.slideShowCollectionView.reloadData()
//                            self.slideShowCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
//                            UIView.animate(withDuration: 2, animations: {
//                                DispatchQueue.main.async {
//                                    self.isPlayingSlideShow = false
//                                    self.changeImagePauseOrPlayBtn(isPlaying: self.isPlayingSlideShow)
//                                    self.x = 0
//                                    self.isEndSlideShow = true
//                                    self.hiddenView.isHidden = true
//                                    self.hiddenView.alpha = 0
//                                    self.slideShowCollectionView.alpha = 1
////                                    self.player?.pause()
//                                }
//
//                            })
//
//                        })
//                    }
//                }
//
//            }
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
            self.slideShowCollectionView.contentOffset = CGPoint(x: 0, y: slideShowCollectionView.contentOffset.y)
            slideShowCollectionView.reloadData()
//            isPlayingSlideShow = false
//            changeImagePauseOrPlayBtn(isPlaying: isPlayingSlideShow)
        }else{
            isPlayingSlideShow = true
//            changeImagePauseOrPlayBtn(isPlaying: isPlayingSlideShow)
            slideShowCollectionView.reloadData()
        }
    }
    
    
    func changeImagePauseOrPlayBtn(isPlaying: Bool) {
//        if isPlaying{
//            let image = UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate)
//            self.pauseOrPlayBtn.setImage(image, for: .normal)
//            self.pauseOrPlayBtn.tintColor = UIColor.white
//        }else{
//            let image = UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
//            self.pauseOrPlayBtn.setImage(image, for: .normal)
//            self.pauseOrPlayBtn.tintColor = UIColor.white
//        }
        
    }
    
    @IBAction func createPost(_ sender: Any) {
        if isPlayingSlideShow{
            isPlayingSlideShow = false
//            backgroundMusicPlayer.pause()
//            currentTimePlay = backgroundMusicPlayer.currentTime
//            player?.pause()
//            changeImagePauseOrPlayBtn(isPlaying: isPlayingSlideShow)
            removeTimer()
        }
        VideoPlayerManager.shareInstance.removePLayerLayer()
        delegate?.createPost(listAsset: listAsset)
    }
    
    func removeTimer() {
        scrollingTimer?.invalidate()
        if scrollingTimer != nil{
            scrollingTimer = nil
        }
    }
    
    
    
    
}


extension CLLocationCoordinate2D : Hashable
    
{
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return fabs(lhs.longitude - rhs.longitude) < .ulpOfOne &&  fabs(lhs.latitude - rhs.latitude) < .ulpOfOne
    }
    
    
    
    
    public var hashValue: Int {
        
        get {
            
            return Int(Int(Float(self.latitude)) << 32)|Int(Float(self.longitude))
            
        }
        
    }
    
    
    
}

