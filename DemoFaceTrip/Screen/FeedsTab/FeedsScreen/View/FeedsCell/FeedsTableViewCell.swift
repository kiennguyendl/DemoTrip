//
//  FeedsTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/22/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import ReadMoreTextView
import Alamofire
class FeedsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var slideShowView: UIView!
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var textView: ReadMoreTextView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImg: UIImageView!
//    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var indicatorCollectionView: UICollectionView!
    var endList = false
    var scrollingTimer = Timer()
    var listURlImage = [
        "https://thumbnails.trvl-media.com/zYArJpwvmVE4TIdjlrrhJNhYNTU=/a.travel-assets.com/mediavault.le/media/cdc31518a23642b420331f57fdea5e7c9f1f6743.jpeg",
        "https://thumbnails.trvl-media.com/BoeQx4x653GBcEYF65EY5JZylwE=/a.travel-assets.com/mediavault.le/media/6c8008954a93e4917169a5588273bb7454c0d60f.jpeg",
        "https://thumbnails.trvl-media.com/mKPdvtrAZByzDDC7e_MvEf_1ikk=/a.travel-assets.com/mediavault.le/media/6db79719515a4e6209700b6b8b140df9570ea42c.jpeg",
        "https://thumbnails.trvl-media.com/l11gE0RedR0ANtXM4455V6PO6q0=/a.travel-assets.com/mediavault.le/media/a236a61d566b43df5b66a91c02494b1f8352d017.jpeg",
        "https://thumbnails.trvl-media.com/OB6ZyvubQAv2D-P4XnJLki0xVHg=/a.travel-assets.com/mediavault.le/media/c88a5da36d952852d64f1472d4082e1353e076c6.jpeg"
    ]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpControl()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpControl() {
        setUpButton()
        setUpAvartar()
        setupTextView()
        setupCollectionView()
//        setTimer()
    }
    
    func setUpButton() {
        followBtn.layer.cornerRadius = followBtn.frame.height / 2
        followBtn.layer.masksToBounds = true
        followBtn.layer.borderWidth = 2.0
        followBtn.layer.borderColor = UIColor.blue.cgColor
    }
    func setUpAvartar() {
//        avatarView.layer.cornerRadius = avatarView.frame.width / 2
        avatarView.clipsToBounds = false

        avatarView.layer.shadowColor = UIColor.black.cgColor
        avatarView.layer.shadowOpacity = 0.5
        avatarView.layer.shadowOffset = CGSize(width: 0.0,height: 1.0)
        avatarView.layer.shadowRadius = 3
        avatarView.layer.shadowPath = UIBezierPath(roundedRect: avatarView.bounds, cornerRadius: avatarView.frame.width / 2).cgPath
        avatarView.backgroundColor = .clear
        avatarImg.clipsToBounds = true
        avatarImg.layer.cornerRadius = avatarImg.frame.width / 2
//        avatarView.layer.masksToBounds = true
        
    }
    
    func setupCollectionView() {
        slideShowCollectionView.delegate = self
        slideShowCollectionView.dataSource = self
        slideShowCollectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        
        indicatorCollectionView.delegate = self
        indicatorCollectionView.dataSource = self
        indicatorCollectionView.register(UINib.init(nibName: "HeaderIndicatorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderIndicatorCollectionView")
//        pageControl.hidesForSinglePage = true
    }
    
    func setupTextView() {
        let readMoreTextAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: UIColor.lightGray,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]

        textView.attributedReadMoreText = NSAttributedString(string: textView.readMoreText!, attributes: readMoreTextAttributes)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = ""
        textView.onSizeChange = { _ in }
        textView.shouldTrim = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textView.sizeToFit()
    }
    
    func setTimer() {
        scrollingTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(HeaderZeroForDetail.autoScroll), userInfo: nil, repeats: true)
    }
    
    var x = 1
    
    @objc func autoScroll() {
        if listURlImage.count > 0{
            
            if !endList{
                if self.x < self.listURlImage.count {
                    if x > 0{
                        let oldIndexPath = IndexPath(item: x - 1, section: 0)
                        let oldCell = indicatorCollectionView.cellForItem(at: oldIndexPath) as! HeaderIndicatorCollectionViewCell
                        oldCell.bigView.isHidden = true
                        oldCell.smallView.isHidden = false
                    }
                    let newIndexPath = IndexPath(item: x, section: 0)
                    let newCell = indicatorCollectionView.cellForItem(at: newIndexPath) as! HeaderIndicatorCollectionViewCell
                    newCell.bigView.isHidden = false
                    newCell.smallView.isHidden = true
                    
                    self.slideShowCollectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
                    self.indicatorCollectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
                    self.x = self.x + 1
                    if self.x == self.listURlImage.count{
                        endList = true
                    }
                }
            }else{
                
                self.x = self.x - 1
                if (x + 1) < listURlImage.count{
                    let oldIndexPath = IndexPath(item: x + 1, section: 0)
                    let oldCell = indicatorCollectionView.cellForItem(at: oldIndexPath) as! HeaderIndicatorCollectionViewCell
                    oldCell.bigView.isHidden = true
                    oldCell.smallView.isHidden = false
                }
                let newIndexPath = IndexPath(item: x, section: 0)
                let newCell = indicatorCollectionView.cellForItem(at: newIndexPath) as! HeaderIndicatorCollectionViewCell
                newCell.bigView.isHidden = false
                newCell.smallView.isHidden = true
                
                //let indexPath = IndexPath(item: x, section: 0)
                self.slideShowCollectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
                self.indicatorCollectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
                if self.x == 0{
                    endList = false
                }
                
            }
            
        }
    }
}

extension FeedsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listURlImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == slideShowCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
            let urlImage = URL(string: listURlImage[indexPath.row])
            cell.imageView.af_setImage(withURL: urlImage!)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderIndicatorCollectionView", for: indexPath) as! HeaderIndicatorCollectionViewCell
            let currentItem = indexPath.row
            
            if currentItem == 0{
                cell.bigView.isHidden = false
                cell.smallView.isHidden = true
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == slideShowCollectionView{
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            
            return CGSize(width: width, height: height)
        }else{
            let width = indicatorCollectionView.frame.height
            let height = indicatorCollectionView.frame.height
            return CGSize(width: width, height: height)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
