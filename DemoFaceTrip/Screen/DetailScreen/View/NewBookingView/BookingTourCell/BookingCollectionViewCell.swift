//
//  BookingCollectionViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/3/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit



class BookingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var slashImg: UIImageView!
    
    
    var delegate: DateCollectionViewCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    override var isSelected: Bool{
        didSet{
            switch isSelected {
            case true:
                if canSelect == true && isChangedColor == false{
                    DispatchQueue.main.async {
                        self.borderView.backgroundColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
                        self.dateLbl.textColor = UIColor.white
                        self.isChangedColor = true
                        print("AAAAAAAAAAAAA")
                        //self.delegate?.presentBottomView()
                        
                    }
                    
                    //self.delegate?.presentBottomView()
                    
                }else if canSelect == false && isChangedColor == false{
                    DispatchQueue.main.async {
//                        if self.indexPathSelected != nil{
//                            self.borderView.backgroundColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
//                            self.dateLbl.textColor = UIColor.white
//                            self.isChangedColor = true
//                            self.delegate?.presentBottomView()
//                        }else{
                        print("BBBBBBBBBBBBB")
                        self.borderView.backgroundColor = UIColor.white
                        self.dateLbl.textColor = UIColor.lightGray
                        self.isChangedColor = false
                        
                        //self.delegate?.dismissBottomView()
//                        }
                    }
                }else{
                    print("BBBBBBBBBBBBB")
                    self.borderView.backgroundColor = UIColor.white
                    self.dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
                    self.isChangedColor = false
                }
            case false:
                if canSelect == true && isChangedColor == true{
                    DispatchQueue.main.async {
                     
                        self.borderView.backgroundColor = UIColor.white
                        self.dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
                        self.isChangedColor = false
                        print("DDDDDDDDDDDD")
                    //self.delegate?.dismissBottomView()
                    }
                }else{
                    DispatchQueue.main.async {
                        print("EEEEEEEEEE")
                        self.dateLbl.textColor = UIColor.lightGray
                        self.borderView.backgroundColor = UIColor.white
                        //self.delegate?.dismissBottomView()
                    }
                   
                }
            }
        }
    }
    
    var isChangedColor = false
    var isShowing = false
    var indexPathSelected: IndexPath?

    var canSelect : Bool = false 
    
    override func prepareForReuse() {
        //super.prepareForReuse()
        dateLbl.text = ""
        borderView.layer.borderColor = UIColor.clear.cgColor
        //dateLbl.textColor = UIColor.black
    }

}
