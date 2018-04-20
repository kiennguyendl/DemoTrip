//
//  ChooseImagesView.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 4/12/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Photos

protocol ChooseImageViewProtocol {
    func addMorePhotosOrVideos()
}

class ChooseImagesView: BaseView {
    @IBOutlet weak var listImagesCollectionView: UICollectionView!
    
    @IBOutlet weak var SellectOrUnsellectBtn: UIButton!
    @IBOutlet weak var numImageSellectedLbl: UILabel!
    
    var delegate: ChooseImageViewProtocol?
    var listAssetPicked: [AsssetInfor] = []
    var listAsset: [AsssetInfor] = []
//    var listAsset: [AsssetInfor]?{
//        didSet{
//            if let listAsset = listAsset{
//                for _asset in listAsset{
//
//                    if _asset.isPicked{
//                        listAssetPicked.append(_asset)
//                    }
//                }
//            }
//        }
//    }
    var isSellectAll = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(frame: CGRect, listAsset: [AsssetInfor]) {
        super.init(frame: frame)
        self.frame = frame
        //        listImagesCollectionView.frame = frame
        setupLayout()
        self.listAsset = listAsset
        DispatchQueue.main.async {
            self.listImagesCollectionView.reloadData()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("choose image view deinit")
    }
    
    
    func setupLayout() {
        listImagesCollectionView.delegate = self
        listImagesCollectionView.dataSource = self
        listImagesCollectionView.register(UINib.init(nibName: "ImagePickerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pickerImageCell")
        listImagesCollectionView.register(UINib.init(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCell")
        listImagesCollectionView.register(UINib.init(nibName: "VideoItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoItemCell")
    }
    
    @IBAction func SellectOrUnsellectImage(_ sender: Any) {
        listAssetPicked = []
        if isSellectAll{
            isSellectAll = false
            SellectOrUnsellectBtn.setTitle("Sellect All",for: .normal)
            for item in listAsset{
                item.isPicked = false
                listAssetPicked.append(item)
            }
            listImagesCollectionView.reloadData()
            
        }else{
            isSellectAll = true
            SellectOrUnsellectBtn.setTitle("UnSellect All",for: .normal)
            for item in listAsset{
                item.isPicked = true
                listAssetPicked.append(item)
            }
            listImagesCollectionView.reloadData()
        }
        let data = ["listAsset": listAssetPicked]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyUpdateListAssetAfterSellectedOrUnsellected), object: nil, userInfo: data)
    }
    
    func updateImagesPickedView(listAsset: [AsssetInfor]) {
        self.listAsset = listAsset
        listImagesCollectionView.reloadData()
    }
}

extension ChooseImagesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAsset.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentItem = indexPath.item
        
        if currentItem == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddImageCell", for: indexPath) as! AddImageCollectionViewCell
            cell.addMoreImageOrVide.addTarget(self, action: #selector(pickedImageOrVideo), for: .touchUpInside)
            let image = UIImage(named: "add")?.withRenderingMode(.alwaysTemplate)
            cell.addMoreImageOrVide.setImage(image, for: .normal)
            cell.addMoreImageOrVide.tintColor = .gray
            return cell
        }else{
            let asset = listAsset[currentItem - 1].asset
            
            if asset?.mediaType == .image{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pickerImageCell", for: indexPath) as! ImagePickerCollectionViewCell
                cell.checkedImage.layer.cornerRadius = cell.checkedImage.frame.width / 2
                cell.checkedImage.layer.masksToBounds = true
                
                PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                    cell.imageView.image = image?.cropImageForSlideShow(sizeView: cell.frame.size)
                })
                
                if listAsset[currentItem - 1].isPicked{
                    cell.checkedImage.image = #imageLiteral(resourceName: "check")
                    cell.checkedImage.backgroundColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
                    cell.checkedImage.layer.borderWidth = 1
                    cell.checkedImage.layer.borderColor = UIColor.white.cgColor
                }else{
                    cell.checkedImage.image = UIImage()
                    cell.checkedImage.backgroundColor = .white
                }
                
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoItemCell", for: indexPath) as! VideoItemCollectionViewCell
                PHImageManager.default().requestAVAsset(forVideo: asset!, options: nil, resultHandler: {avAseet, audioMix, info in
                    let duration = CMTimeGetSeconds((avAseet?.duration)!)
                    print("duration: \(duration)")
                    DispatchQueue.main.async {
                        cell.timeVideo.text = String(format: "%02d:%02d", ((lround(duration) / 60) % 60), lround(duration) % 60)
//                        cell.playVideo(avAsset: avAseet!)
                        VideoManager.shareInstance.trimVideo(asset: avAseet!, fileName: "video\(indexPath.item)", time: 5.0, completionHandler: { url in
                            DispatchQueue.main.async {
                                let player = AVPlayer(url: url)
                                let playerLayer = AVPlayerLayer()
                                playerLayer.player = player
                                playerLayer.frame = cell.playerView.frame
                                playerLayer.backgroundColor = UIColor.white.cgColor
                                playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                                
                                cell.playerView.layer.addSublayer(playerLayer)
                                player.volume = 0.0
                                player.play()
                            }
                        })
                    }
                    
                })
                
                cell.checkerImage.layer.cornerRadius = cell.checkerImage.frame.width / 2
                cell.checkerImage.layer.masksToBounds = true
                
                if listAsset[currentItem - 1].isPicked{
                    cell.checkerImage.image = #imageLiteral(resourceName: "check")
                    cell.checkerImage.backgroundColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
                    cell.checkerImage.layer.borderWidth = 1
                    cell.checkerImage.layer.borderColor = UIColor.white.cgColor
                }else{
                    cell.checkerImage.image = UIImage()
                    cell.checkerImage.backgroundColor = .white
                }
                return cell
            }
        }
    }
    
    @objc func pickedImageOrVideo() {
        print("add more images")
        delegate?.addMorePhotosOrVideos()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.frame.width / 3 - 1
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentItem = indexPath.item
        if currentItem != 0{
            let asset = listAsset[currentItem - 1].asset
            if asset?.mediaType == .image{
                let cell = listImagesCollectionView.cellForItem(at: indexPath) as! ImagePickerCollectionViewCell
                
                if listAsset[currentItem - 1].isPicked{
                    listAsset[currentItem - 1].isPicked = false
                    cell.checkedImage.image = UIImage()
                    cell.checkedImage.backgroundColor = .white
                }else{
                    listAsset[currentItem - 1].isPicked = true
                    cell.checkedImage.image = #imageLiteral(resourceName: "check")
                    cell.checkedImage.backgroundColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
                    cell.checkedImage.layer.borderWidth = 1
                    cell.checkedImage.layer.borderColor = UIColor.white.cgColor
                }
            }else{
                let cell = listImagesCollectionView.cellForItem(at: indexPath) as! VideoItemCollectionViewCell
                
                if listAsset[currentItem - 1].isPicked{
                    listAsset[currentItem - 1].isPicked = false
                    cell.checkerImage.image = UIImage()
                    cell.checkerImage.backgroundColor = .white
                }else{
                    listAsset[currentItem - 1].isPicked = true
                    cell.checkerImage.image = #imageLiteral(resourceName: "check")
                    cell.checkerImage.backgroundColor = UIColor(red: 48/255, green: 125/255, blue: 251/255, alpha: 1)
                    cell.checkerImage.layer.borderWidth = 1
                    cell.checkerImage.layer.borderColor = UIColor.white.cgColor
                }
            }
            listAssetPicked = []
            for _asset in listAsset{
                
                if _asset.isPicked{
                    listAssetPicked.append(_asset)
                }
            }
            
            let data = ["listAsset": listAssetPicked]
            notificationCenter.post(name: NSNotification.Name(rawValue: keyUpdateListAssetAfterSellectedOrUnsellected), object: nil, userInfo: data)
        }
    }
}
