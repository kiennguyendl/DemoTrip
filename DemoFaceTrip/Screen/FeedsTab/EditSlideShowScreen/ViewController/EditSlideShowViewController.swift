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
    @IBOutlet weak var pauseOrPlayBtn: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var hiddenView: UIView!
    
    @IBOutlet weak var musicView: UIView!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var chooseMusicCollectionView: UICollectionView!
    
    @IBOutlet weak var slideShowViewParent: UIView!
    
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
    var listImage: [UIImage] = []
    var listAsset: [AsssetInfor]?{
        didSet{
            if let listAsset = listAsset{
                for _asset in listAsset{
                    let asset = _asset.asset
                    PHImageManager.default().requestImage(for: asset!, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: nil, resultHandler: { image, info in
                        
                        self.listImage.append(image!)
                    })
                }
                
                
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
    }
    
    func setupCollectionView() {
        slideShowCollectionView.delegate = self
        slideShowCollectionView.dataSource = self
        slideShowCollectionView.register(UINib.init(nibName: "ImageForSlideShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageForSlideShow")
        
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
    
}


