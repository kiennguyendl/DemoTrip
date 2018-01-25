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

    @IBOutlet weak var suggestionBtn: UIButton!
    @IBOutlet weak var textView: ReadMoreTextView!
    
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var slideShowView: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var heightOfImageCollectionView: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var imagePhoto: UIImageView!
    @IBOutlet weak var hiddenView: UIView!
    
    var dateFormater: DateFormatter?
    //var listImageHasLocation: [ImagesCreateByDate] = []
    var listImageCreateDate = [ImagesCreateByDate]()
    var listAsset = [AsssetInfor]()
    var assets: [PHAsset] = []
    var listAssetInfor: [AsssetInfor] = []
    
    var endList = false
    var scrollingTimer = Timer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        heightOfImageCollectionView.constant = imageCollectionView.frame.width / 3
        dateFormater = DateFormatter()
        dateFormater?.dateFormat = "MM-dd-yyyy"
        setupLayout()
        fetchImageFromDateToDate(startDate: dateFormater?.date(from: "12-26-2017") as! NSDate, endDate: dateFormater?.date(from: "12-29-2017") as! NSDate)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupLayout() {
        heightOfImageCollectionView.constant = imageCollectionView.bounds.width / 3
        setUpIcon()
        setupCollectionView()
        setTimer()
    }
    
    func setUpIcon() {
        let imageUser = UIImage(named: "user")?.withRenderingMode(.alwaysTemplate)
        imageViewUser.image = imageUser
        imageViewUser.tintColor = .white
        
        let imgPhoto = UIImage(named: "galleryIcon")?.withRenderingMode(.alwaysTemplate)
        imagePhoto.image = imgPhoto
        imagePhoto.tintColor = .white
    }
    
    func setupCollectionView() {
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(UINib.init(nibName: "ImageOfSuggestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageOfSuggestion")
        
        slideShowCollectionView.delegate = self
        slideShowCollectionView.dataSource = self
        slideShowCollectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
    }
    
    func fetchImageFromDateToDate(startDate: NSDate, endDate: NSDate) {
        let imageManager = PHImageManager()
        let requestOption = PHImageRequestOptions()
        requestOption.isSynchronous = true
//        requestOption.deliveryMode = .fastFpoormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "creationDate >= %@ AND creationDate <= %@", startDate, endDate)
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
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
                    //                    print(strongSelf.listImageCreateDate)
                    DispatchQueue.main.async {
//                        strongSelf.photosTableView.reloadData()
                        strongSelf.slideShowCollectionView.reloadData()
                        strongSelf.imageCollectionView.reloadData()
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
                        //                            if let subLocality = address.subLocality{
                        //                                detailAddress += subLocality
                        //                            }
                        //
                        //                            if let subAdministrativeArea = address.subAdministrativeArea{
                        //                                detailAddress += subAdministrativeArea
                        //                            }
                        if address.subLocality != ""{
                            detailAddress += address.subLocality
                        }
                        if address.subAdministrativeArea != ""{
                            detailAddress += " ," + address.subAdministrativeArea
                        }
                        //                            let detailAddress = address.subLocality + ", " + address.subAdministrativeArea
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
    
    func setTimer() {
        scrollingTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
    }
    
    var x = 1
    
    @objc func autoScroll() {
        if listAsset.count > 0{
            
            
                if self.x < self.listAsset.count {
                    let newIndexPath = IndexPath(item: x, section: 0)
                    
                    self.slideShowCollectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
                    self.x = self.x + 1
                    if self.x == self.listAsset.count{
                        UIView.animate(withDuration: 2, animations: {
                            self.hiddenView.isHidden = false
                            self.hiddenView.alpha = 1
                            self.slideShowCollectionView.alpha = 0
                            
                            self.slideShowCollectionView.contentOffset = CGPoint.zero
//                            self.x = 1
                        }, completion: { finished in
                            UIView.animate(withDuration: 2, animations: {
                                DispatchQueue.main.async {
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
}

extension SuggestionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView{
            if listAsset.count > 2{
                return 3
            }
            return 0
            
        }else{
            return listAsset.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == slideShowCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
            let asset = listAsset[indexPath.row].asset
            
            PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                
                cell.imageView.image = image
            })
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageOfSuggestion", for: indexPath) as! ImageOfSuggestionCollectionViewCell
            let asset = listAsset[indexPath.row].asset
            
            PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                
                cell.imageView.image = image
            })
            if indexPath.row == 2{
                cell.buttonView.isHidden = false
                cell.viewAllImgBtn.setTitle("\(listAsset.count - 1)", for: .normal)
                cell.blurEffectView.isHidden = false
            }else{
                cell.buttonView.isHidden = true
                cell.blurEffectView.isHidden = true
            }
            
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageCollectionView{
        let width = imageCollectionView.frame.width / 3 - 1
        let height = width
        
        return CGSize(width: width, height: height)
        }else{
            let width = slideShowCollectionView.frame.width - 1
            let height = slideShowCollectionView.frame.height
            return CGSize(width: width, height: height)
        }
    }
}
