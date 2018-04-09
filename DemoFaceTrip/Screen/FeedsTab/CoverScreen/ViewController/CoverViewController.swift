//
//  CoverViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/22/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import Photos

class CoverViewController: BaseViewController {

    @IBOutlet weak var viewPickTag: UIView!
    @IBOutlet weak var imageViewPickTag: UIImageView!
    @IBOutlet weak var pickATagLbl: UILabel!
    @IBOutlet weak var detailMomentLbl: UILabel!
    @IBOutlet weak var editTitleLbl: UILabel!
    @IBOutlet weak var tagFriendBtn: UIButton!
    @IBOutlet weak var listTagFriendCollectionView: UICollectionView!
    @IBOutlet weak var showKeyBoardBtn: UIButton!
    @IBOutlet weak var editCoverBtn: UIButton!
    @IBOutlet weak var editSlideShow: UIButton!
    
//    @IBOutlet weak var pickATagBtn: UIButton!
    @IBOutlet weak var viewTagFriends: UIView!
    
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var editViewContent: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    var imageCover: UIImage = UIImage(named: "khanh-tien-001-090007177.jpg")!
    var totalTime = 0
    var listAsset: [AsssetInfor] = []{
        didSet{
            if listAsset.count > 0{
                for assetInfor in listAsset{
                    if let asset = assetInfor.asset{
                        if asset.mediaType == .image{
                            totalTime += 3
                        }else{
                            totalTime += 15
                        }
                    }
                }
            }
        }
    }
    var scrollingTimer: Timer? = nil
    var timeInterval = 2.0
    var playingSlideShow = true
    
    @IBOutlet weak var distanceOfShowKeyBoardToBottom: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        setUpCollectionView()
        addObserverPlayMusicBackground()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        setNoneColorForNavigation()
        initLeftRightButton(titleLeft: "Cancel", titleRight: "Next")
        self.title = "Edit Memories"
        
//        playingSlideShow = true
//        slideShowCollectionView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

//    func setNoneColorForNavigation() {
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
//        //        UIApplication.shared.statusBarStyle = .lightContent
//        self.navigationController?.navigationBar.barStyle = .black
//        self.navigationController?.navigationBar.tintColor = .white
//    }
//    
//    func setDefaultColorForNavigation() {
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.view.backgroundColor = .white
//        self.navigationController?.navigationBar.barStyle = .default
//        self.navigationController?.navigationBar.tintColor = UIColor.black
//    }
    
//    func initLeftRightButton() {
//        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelEditPost))
//        navigationItem.leftBarButtonItem = cancelButton
//
//        let postButton: UIBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextStep))
//        navigationItem.rightBarButtonItem = postButton
//    }
    
    override func leftButton() {
        navigationController?.popViewController(animated: true)
    }
    
    override func rightButton() {
        
    }
    
    @IBAction func editCover(_ sender: Any) {
        playingSlideShow = false
        let data = ["isPlayMusic": false, "musicFile": musicType] as [String : Any]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
        progressView.progress = 0.0
//        slideShowCollectionView.contentOffset = CGPoint(x: 0, y: 0)
        
        let vc = EditCoverViewController()
        vc.listAsset = listAsset
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpLayout() {
        
        // setup edit title label
//        let attributedString = NSMutableAttributedString(string: "Enter Type Title  Image Here  ")
//        let editAttachment = NSTextAttachment()
//        let image = UIImage(named: "edit1")!.withRenderingMode(.alwaysTemplate)
//        
//        editAttachment.image = image
//        
//        editAttachment.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
//        attributedString.append(NSAttributedString(attachment: editAttachment))
//        
//        editTitleLbl.attributedText = attributedString
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(editTitle))
//        editTitleLbl.isUserInteractionEnabled = true
//        editTitleLbl.addGestureRecognizer(tap)
        
//        let tapPickATag = UITapGestureRecognizer(target: self, action: #selector(showPickATagScreen))
//        pickATagLbl.isUserInteractionEnabled = true
//        pickATagLbl.addGestureRecognizer(tapPickATag)
        
        //set up tag friends button
//        let imageAddBtn = UIImage(named: "add")?.withRenderingMode(.alwaysTemplate)
//        tagFriendBtn.setImage(imageAddBtn, for: .normal)
//        tagFriendBtn.tintColor = .white
        
//        let viewBorder = CAShapeLayer()
//        viewBorder.path = UIBezierPath(roundedRect: tagFriendBtn.frame, cornerRadius: tagFriendBtn.frame.width / 2).cgPath
//        viewBorder.strokeColor = UIColor.white.cgColor
//        viewBorder.lineDashPattern = [1, 3]
//
//        viewBorder.frame = tagFriendBtn.frame
//        viewBorder.fillColor = UIColor.clear.cgColor
//        viewBorder.backgroundColor = UIColor.clear.cgColor
//        tagFriendBtn.layer.addSublayer(viewBorder)
        
        let imageShowKeyBoard = UIImage(named: "uparrow")?.withRenderingMode(.alwaysTemplate)
        showKeyBoardBtn.setImage(imageShowKeyBoard, for: .normal)
        showKeyBoardBtn.tintColor = .white
        

        editCoverBtn.setImage(UIImage(named: "editimage1"), for: .normal)
        editCoverBtn.setTitle("Edit Cover", for: .normal)
        editCoverBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        editCoverBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        editCoverBtn.contentHorizontalAlignment = .center
        editCoverBtn.tintColor = .white
        
        editSlideShow.setImage(UIImage(named: "editvideo1"), for: .normal)
        editSlideShow.setTitle("Edit SlideShow", for: .normal)
        editSlideShow.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        editSlideShow.imageEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        editSlideShow.contentHorizontalAlignment = .center
        editSlideShow.tintColor = .white
    }
    
    func setUpCollectionView() {
        slideShowCollectionView.delegate = self
        slideShowCollectionView.dataSource = self
        slideShowCollectionView.register(UINib.init(nibName: "ImageForSlideShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageForSlideShow")
        slideShowCollectionView.register(UINib.init(nibName: "VideoForSlideShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCell")
        
        listTagFriendCollectionView.delegate = self
        listTagFriendCollectionView.dataSource = self
        listTagFriendCollectionView.register(UINib.init(nibName: "TagFriendsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tagFriends")
    
        displayCoverImage()
    }
    
    private func displayCoverImage() {
        self.slideShowCollectionView.alpha = 0
        UIView.animate(withDuration: 5, animations: {
            self.coverImageView.alpha = 1
//            self.editViewContent.alpha = 1
//            self.slideShowCollectionView.alpha = 0
            let assetCover = self.listAsset[0].asset
            PHImageManager.default().requestImage(for: assetCover!, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: nil, resultHandler: { [weak self]image, info in
                guard let strongSelf = self else{return}
                strongSelf.coverImageView.image = image!
            })
        }, completion: {finished in
            self.coverImageView.alpha = 0
//            self.editViewContent.alpha = 0
            self.slideShowCollectionView.alpha = 1
            self.slideShowCollectionView.reloadData()
//            self.slideShowCollectionView.contentOffset = CGPoint(x: 0, y: 0)
        })

    }
    
    @objc func editTitle() {
        print("edit title")
    }
    
    @objc func showPickATagScreen(){
        
        let vc = PickATagViewController()
        present(vc, animated: true, completion: nil)
    }
    @IBAction func cancelEditCover(_ sender: Any) {
        let data = ["isPlayMusic": false, "musicFile": musicType] as [String : Any]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func drawLineOnMap(_ sender: Any) {
        let vc = DrawLineOnMapViewController()
        vc.listAsset = listAsset
        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true, completion: nil)
    }
    
    func setTimer() {
        scrollingTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll(){
        let currentOffset = slideShowCollectionView.contentOffset
        let contentWidth = slideShowCollectionView.frame.width
        let totalContentWidthOfCV = contentWidth * CGFloat(listAsset.count - 1)
//        print("currentOffset x:\(currentOffset.x) ------------- totalContentWidthOfCV: \(totalContentWidthOfCV)")
        if playingSlideShow{
            if currentOffset.x < totalContentWidthOfCV{
                let newOffsetX = currentOffset.x + contentWidth
                slideShowCollectionView.contentOffset = CGPoint(x: newOffsetX, y: currentOffset.y)
                //            UIView.animate(withDuration: TimeInterval(totalTime), animations: {
                //                self.progressView.setProgress(1.0, animated: true)
                //            })
            }else{
                let data = ["isPlayMusic": false, "musicFile": musicType] as [String : Any]
                notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
                self.progressView.progress = 0.0
                let offsetZero = CGPoint(x: 0, y: 0)
                slideShowCollectionView.contentOffset = offsetZero
                slideShowCollectionView.reloadData()
            }
        }
    }
    
    func removeTimer() {
        scrollingTimer?.invalidate()
        if scrollingTimer != nil{
            scrollingTimer = nil
        }
    }
}

extension CoverViewController: EditCoverProtocol{
    func playSlideShow() {
        playingSlideShow = true
//        let data = ["isPlayMusic": true, "musicFile": musicType] as [String : Any]
//        notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil, userInfo: data)
//        slideShowCollectionView.reloadData()
        displayCoverImage()
    }
}


