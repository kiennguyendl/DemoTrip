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
                        
                    }
                    
                }else {
                    DispatchQueue.main.async {
                        if self.canSelect == true{
                            print("BBBBBBBBBBBBB")
                            self.borderView.backgroundColor = UIColor.white
                            self.dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
                            self.isChangedColor = false
                        }else{
                            self.dateLbl.textColor = UIColor.lightGray
                            self.borderView.backgroundColor = UIColor.white
                        }
                    }
                }
            case false:
                if canSelect == true && isChangedColor == true{
                    DispatchQueue.main.async {
                     
                        self.borderView.backgroundColor = UIColor.white
                        self.dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
                        self.isChangedColor = false
                        print("DDDDDDDDDDDD")
                    }
                }else{
                    DispatchQueue.main.async {
                        if self.canSelect{
                            print("EEEEEEEEEE")
                            self.dateLbl.textColor = UIColor(red: 44.0/255.0, green: 120.0/255.0, blue: 104.0/255.0, alpha: 1)
                            self.borderView.backgroundColor = UIColor.white
                        }else{
                            print("EEEEEEEEEE")
                            self.dateLbl.textColor = UIColor.lightGray
                            self.borderView.backgroundColor = UIColor.white
                        }
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
