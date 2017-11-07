//
//  DateCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/30/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

protocol DateCollectionViewCellProtocol {
    func presentBottomView()
    func dismissBottomView()
}

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var slashImg: UIImageView!
    
    var delegate: DateCollectionViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    var isToday : Bool = false {
//        didSet {
//            switch isToday {
//            case true:
//                self.borderView.backgroundColor =  UIColor.red
//            case false:
//                self.borderView.backgroundColor = UIColor.white
//            }
//        }
//    }
    
//    override var isSelected: Bool{
//        didSet{
//            switch isSelected {
//            case true:
//                if canSelect == true && isChangedColor == false{
//                    self.borderView.backgroundColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
//                    self.dateLbl.textColor = UIColor.white
//                    self.isChangedColor = true
//                    print("AAAAAAAAAAAAA")
//                    self.delegate?.presentBottomView()
//                    
//                }else{
//                    print("BBBBBBBBBBBBB")
//                    borderView.backgroundColor = UIColor.white
//                    dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
//                    isChangedColor = false
//                    self.delegate?.dismissBottomView()
//                }
//            case false:
//                if canSelect == true && isChangedColor == true{
//                    borderView.backgroundColor = UIColor.white
//                    dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
//                    isChangedColor = false
//                    print("DDDDDDDDDDDD")
//                    self.delegate?.dismissBottomView()
//                }else{
//                    print("EEEEEEEEEE")
//                    self.delegate?.dismissBottomView()
//                }
//            }
//        }
//    }
    
//    var isChangedColor = false
    
//    var isChangedColor = false{
//        didSet{
//            switch isChangedColor {
//            case true:
//                if canSelect == true{
//                    borderView.backgroundColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
//                    dateLbl.textColor = UIColor.white
//                }else{
//                    print("")
//                }
//            case false:
//                if canSelect == true{
//                    borderView.backgroundColor = UIColor.white
//                    dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
//                }else{
//                    print("")
//                }
//            }
//        }
//    }
    
//    var canSelect : Bool = false {
//        didSet{
//            switch canSelect {
//            case true:
//                print("")
//            case false:
//                print("")
//            }
//        }
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLbl.text = ""
        borderView.layer.borderColor = UIColor.clear.cgColor
        //dateLbl.textColor = UIColor.black
    }
}
