//
//  HeaderZeroForDetail.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/24/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

class HeaderZeroForDetail: BaseView {
    
    @IBOutlet weak var listImageCollectionview: UICollectionView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var imageBackgroud: UIImageView!
    
    var listImage: [String] = []
    var scrollingTimer = Timer()
    
    var endList = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        listImageCollectionview.delegate = self
        listImageCollectionview.dataSource = self
        listImageCollectionview.register(UINib.init(nibName: "HeaderZeroCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderZeroDetail")
        
        setTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
    }
    
    func setTimer() {
        scrollingTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(HeaderZeroForDetail.autoScroll), userInfo: nil, repeats: true)
    }

    var x = 1

    @objc func autoScroll() {
        if listImage.count > 0{
            
            if !endList{
                if self.x < self.listImage.count {
                    let indexPath = IndexPath(item: x, section: 0)
                    self.listImageCollectionview.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    self.x = self.x + 1
                    if self.x == self.listImage.count{
                        endList = true
                    }
                }
            }else{
                
                self.x = self.x - 1
                let indexPath = IndexPath(item: x, section: 0)
                    self.listImageCollectionview.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                if self.x == 0{
                    endList = false
                }
                
            }
         
        }
    }
}

extension HeaderZeroForDetail: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderZeroDetail", for: indexPath) as! HeaderZeroCollectionViewCell
        let urlStr = listImage[indexPath.row]
        let url = URL(string: urlStr)
        let dafautImg = UIImage(named: "default")
        cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.frame.width, height: cell.image.frame.height)).withRenderingMode(.alwaysOriginal)
//        var rowIndex = indexPath.row
//        let numberOfRecords = self.listImage.count - 1
//        if rowIndex < numberOfRecords{
//            rowIndex = rowIndex + 1
//        }else{
//            rowIndex = 0
//        }
//        
//        scrollingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(HeaderZeroForDetail.startTimer(timer: )), userInfo: rowIndex, repeats: true)
        
        
        return cell
    }
    
//    @objc func startTimer(timer: Timer) {
//        UIView.animate(withDuration: 1.0,delay: 0, options: .curveEaseOut, animations: {
//            self.listImageCollectionview.scrollToItem(at: IndexPath(row: timer.userInfo! as! Int, section: 0), at: .centeredHorizontally, animated: true)
//        }, completion: nil)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: listImageCollectionview.frame.width, height: listImageCollectionview.frame.height)
    }
}
