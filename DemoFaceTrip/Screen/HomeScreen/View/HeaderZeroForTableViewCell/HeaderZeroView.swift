//
//  HeaderZeroView.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/21/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

protocol HeaderZeroProtocol {
    func didPressOnCellHeaderZero(menu: CategoryMenu)
}

class HeaderZeroView: BaseView {

    @IBOutlet weak var collectionViewFriends: UICollectionView!
    
    @IBOutlet weak var parentIndicatorView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var leadingOfLineView: NSLayoutConstraint!
    @IBOutlet weak var trailingOfLineView: NSLayoutConstraint!
    @IBOutlet weak var widthOfLineView: NSLayoutConstraint!
    //var dataForMenu2: [Catagory] = []
    var delegate: HeaderZeroProtocol?

    var menu: [CategoryMenu] = []
    
    static var horizontalContentOffset: CGFloat = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionViewFriends.delegate = self
        collectionViewFriends.dataSource = self
        collectionViewFriends.register(UINib.init(nibName: "ListCatagoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CatagoryCell")
        collectionViewFriends.tag = 4

        let scrollBar = collectionViewFriends.subviews.last
        scrollBar?.isHidden = false

        restDataForMenuHeaderZero()
        DispatchQueue.main.async {
            self.collectionViewFriends.setContentOffset(CGPoint(x: 0,y:  HeaderZeroView.horizontalContentOffset), animated: false)
        }
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func restDataForMenuHeaderZero() {
        RestDataManager.shareInstance.restDataForHeaderZero(urlForHome, idCity: 01, type: "submenu", completionHandler: {[weak self](menu: [CategoryMenu]?,error: NSError?) in
            guard let strongSelf = self else{return}
            if error == nil{
                if let menu = menu{
                    strongSelf.menu = menu
                    strongSelf.collectionViewFriends.reloadData()
                    
                    //set width for indicator
                    let totalCell = strongSelf.menu.count
                    let withCollectionView = strongSelf.collectionViewFriends.frame.width
                    let widthCell = withCollectionView / 4
                    let numOutsideCell = totalCell - 4
                    let widthOfIndicator = withCollectionView - (widthCell * CGFloat(numOutsideCell))
                    strongSelf.indicatorView.frame = CGRect(x: 0, y: 0, width: widthOfIndicator, height: 1)
                    
                }
            }else{
                print("error")
            }
        })
    }
}

extension HeaderZeroView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return dataForMenu2.count
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatagoryCell", for: indexPath) as! ListCatagoryCollectionViewCell
        //cell.nameCarousel.text = Carousels[indexPath.row]
        cell.avatar.layer.cornerRadius = cell.avatar.frame.width / 2
        cell.viewBackGroud.layer.cornerRadius = cell.viewBackGroud.frame.width / 2
        cell.avatar.clipsToBounds = true
        //cell.nameCatagory.text = dataForMenu2[indexPath.row].type
        
        let strURL = menu[indexPath.row].avatar
        let url = URL(string: strURL!)
        cell.avatar.af_setImage(withURL: url!)
        cell.nameCatagory.text = menu[indexPath.row].type
        cell.numberLbl.isHidden = true
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionViewFriends.frame.width / 4
        let height = collectionViewFriends.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didPressOnCellHeaderZero(menu: menu[indexPath.row])
    }
    
    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView){
        print("hihi")
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 4{
            DispatchQueue.main.async {
                let indicator = scrollView.subviews.last
                indicator?.isHidden = true
                self.indicatorView.frame.origin.x = (indicator?.frame.origin.x)!
                self.leadingOfLineView.constant = (indicator?.frame.origin.x)!
                self.widthOfLineView.constant = (indicator?.frame.width)!
                
                if self.indicatorView.frame.origin.x < 0{
                    
                    self.indicatorView.frame.origin.x = 0
                    self.leadingOfLineView.constant = 0
                    
                } else if ((self.indicatorView.frame.origin.x + self.widthOfLineView.constant) > self.parentIndicatorView.frame.width) {
                    
                    self.indicatorView.frame.origin.x = self.parentIndicatorView.frame.width - self.widthOfLineView.constant
                    
                    self.leadingOfLineView.constant = self.parentIndicatorView.frame.width - self.widthOfLineView.constant
                }
                
            }
            HeaderZeroView.horizontalContentOffset = self.collectionViewFriends.contentOffset.x
            //print("contentOffset: \(self.collectionViewFriends.contentOffset.x)")
        }
    }
}
