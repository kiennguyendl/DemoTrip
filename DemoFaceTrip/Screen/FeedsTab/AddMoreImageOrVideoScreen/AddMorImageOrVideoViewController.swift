//
//  AddMorImageOrVideoViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/10/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import Photos

protocol AddMoreImageOrVideoProtocol {
    func changeDataForSlideShow(listAsset: [AsssetInfor])
}

class AddMorImageOrVideoViewController: BaseViewController {

    @IBOutlet weak var listAssetCollectionView: UICollectionView!
    var listAsset: [AsssetInfor] = []
    var allAsset: [AsssetInfor] = []
    
//    var arrPlayer: [AVPlayer] = []
//    var arrPlayerLayer: [AVPlayerLayer] = []
//    var arrPlayerItem: [AVPlayerItem] = []
    
    var delegate: AddMoreImageOrVideoProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Pick Image or Video"
        setCollectionView()
        loadAllAsset()
        
    }

    func setCollectionView() {
        listAssetCollectionView.delegate = self
        listAssetCollectionView.dataSource = self
        listAssetCollectionView.register(UINib.init(nibName: "AddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddImageCell")
        listAssetCollectionView.register(UINib.init(nibName: "VideoItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoItemCell")
        
         listAssetCollectionView.register(UINib.init(nibName: "ImagePickerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pickerImageCell")
    }
    
    
    func loadAllAsset() {
        let imageManager = PHImageManager()
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType == %d || mediaType == %d",PHAssetMediaType.image.rawValue, PHAssetMediaType.video.rawValue)
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: fetchOptions)
        DispatchQueue.global(qos: .background).async{
//            print("fetchResult: \(fetchResult)")
            for i in 0..<fetchResult.count {
                let asset = fetchResult.object(at: i)
                let location = asset.location
                let createDate = asset.creationDate
                var isPicked = false
                
                for item in self.listAsset{
                    if asset == item.asset!{
                        isPicked = true
//                        print("i true: \(i)")
                        break
                    }
                    
                }
                if let _location = location{
                    let locationCoordinate = CLLocationCoordinate2D(latitude: (_location.coordinate.latitude), longitude: (_location.coordinate.longitude))
                    let assetInfor = AsssetInfor(location: locationCoordinate, createDate: createDate!, asset: asset, isPicked: isPicked)
                    self.allAsset.append(assetInfor)
                }else{
                    let assetInfor = AsssetInfor(location: nil, createDate: createDate!, asset: asset, isPicked: isPicked)
                    self.allAsset.append(assetInfor)
                }
                
            }
            self.allAsset.sort{ $0.createDate! > $1.createDate! }
            DispatchQueue.main.async {
                
                self.listAssetCollectionView.reloadData()
            }
        }
    }

    @IBAction func cancelPick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func donePick(_ sender: Any) {
        listAsset.sort{ $0.createDate! > $1.createDate!}
        delegate?.changeDataForSlideShow(listAsset: listAsset)
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddMorImageOrVideoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allAsset.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentItem = indexPath.row
        let asset = allAsset[currentItem].asset
        
        if asset?.mediaType == .image{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pickerImageCell", for: indexPath) as! ImagePickerCollectionViewCell
            cell.checkedImage.layer.cornerRadius = cell.checkedImage.frame.width / 2
            cell.checkedImage.layer.masksToBounds = true
            
            PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                cell.imageView.image = image
            })
            
            if allAsset[currentItem].isPicked{
                cell.checkedImage.image = #imageLiteral(resourceName: "check")
                cell.checkedImage.backgroundColor = .blue
            }else{
                cell.checkedImage.image = UIImage()
                cell.checkedImage.backgroundColor = .white
            }
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoItemCell", for: indexPath) as! VideoItemCollectionViewCell
            
            cell.checkerImage.layer.cornerRadius = cell.checkerImage.frame.width / 2
            cell.checkerImage.layer.masksToBounds = true
            PHImageManager.default().requestAVAsset(forVideo: asset!, options: nil, resultHandler: {[weak self] avAseet, audioMix, info in
                let duration = CMTimeGetSeconds((avAseet?.duration)!)
                print("duration: \(duration)")
                DispatchQueue.main.async {
                    cell.timeVideo.text = String(format: "%02d:%02d", ((lround(duration) / 60) % 60), lround(duration) % 60)
//                    cell.playVideo(avAsset: avAseet!)
                    
                    VideoManager.shareInstance.trimVideo(asset: avAseet!, fileName: "video\(indexPath.item)", time: 5.0, completionHandler: { url in
                        DispatchQueue.main.async {
//                            VideoPlayerManager.shareInstance.addPlayerLayer(view: cell.playerView, url: url)
//                            VideoPlayerManager.shareInstance.playVideo()
//                            let playerItem = AVPlayerItem(asset: avAseet!)
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
            
            if allAsset[currentItem].isPicked{
                cell.checkerImage.image = #imageLiteral(resourceName: "check")
                cell.checkerImage.backgroundColor = .blue
            }else{
                cell.checkerImage.image = UIImage()
                cell.checkerImage.backgroundColor = .white
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemAdd = allAsset[indexPath.row]
        let type = itemAdd.asset?.mediaType
        if type == .image{
            let cell = listAssetCollectionView.cellForItem(at: indexPath) as! ImagePickerCollectionViewCell
            
            if allAsset[indexPath.row].isPicked{
                allAsset[indexPath.row].isPicked = false
                cell.checkedImage.image = UIImage()
                cell.checkedImage.backgroundColor = .white
            }else{
                allAsset[indexPath.row].isPicked = true
                cell.checkedImage.image = #imageLiteral(resourceName: "check")
                cell.checkedImage.backgroundColor = .blue
                
            }
        }else{
            let cell = listAssetCollectionView.cellForItem(at: indexPath) as! VideoItemCollectionViewCell
            
            if allAsset[indexPath.row].isPicked{
                allAsset[indexPath.row].isPicked = false
                cell.checkerImage.image = UIImage()
                cell.checkerImage.backgroundColor = .white
            }else{
                allAsset[indexPath.row].isPicked = true
                cell.checkerImage.image = #imageLiteral(resourceName: "check")
                cell.checkerImage.backgroundColor = .blue
                
            }
        }
        
        
        for index in 0..<listAsset.count{
            print(index)
            if listAsset[index].asset == itemAdd.asset!{
                listAsset.remove(at: index)
                break
            }
        }
        
        if  itemAdd.isPicked {
            listAsset.append(itemAdd)
        }
        
    }
}
