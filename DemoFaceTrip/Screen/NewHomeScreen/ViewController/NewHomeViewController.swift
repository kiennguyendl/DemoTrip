//
//  NewHomeViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/20/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class NewHomeViewController: BaseViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var carouselsCollectionView: UICollectionView!
    
    @IBOutlet weak var subMenuView: UIView!
    @IBOutlet weak var contentsCollectionView: UICollectionView!
    
    var catagory: [Catagory] = []
    var menuCatagory1 = ["For You"]
    var menuCatagory2: [String] = []
    var dataForMenu1: [Catagory] = []
    var dataForMenu2: [Catagory] = []
    var dataForHome: [AnyObject] = []
    var type: typeCatagoryForHome = .ForYou
    var indexPathSelected: IndexPath = []
    var isScaleMenuView = false
    
    var newPos: CGFloat!
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            color1.cgColor,
            color2.cgColor,
            color3.cgColor
        ]
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restDataForHome()
        initCollectionView()
        setColorForMenuView()
        
        newPos = self.menuView.frame.height - self.carouselsCollectionView.frame.height
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer.frame = self.menuView.bounds
    }
    
    func initCollectionView() {
        carouselsCollectionView.delegate = self
        carouselsCollectionView.dataSource = self
        carouselsCollectionView.register(UINib.init(nibName: "CarouselsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
        carouselsCollectionView.backgroundColor = color3
        carouselsCollectionView.showsHorizontalScrollIndicator = false
        
        contentsCollectionView.delegate = self
        contentsCollectionView.dataSource = self
        contentsCollectionView.register(UINib.init(nibName: "CollectionViewForCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewContent")
        
        contentsCollectionView.register(UINib.init(nibName: "TableViewForCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TableViewContent")
    }
    
    func setColorForMenuView() {
        self.menuView.layer.insertSublayer(gradientLayer, below: self.subMenuView.layer)
        menuView.frame = self.menuView.bounds
        self.subMenuView.dropShadow(color: UIColor(red: 152.0/255.0, green: 91.0/255.0, blue: 86.0/255.0, alpha: 1.0), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
        self.subMenuView.layer.cornerRadius = self.subMenuView.frame.width / 97
    }
    
    // rest data from api for home
    func restDataForHome() {
        RestDataManager.shareInstance.restDataForHome(urlForHome, completionHandler: {[weak self] (catagory: [Catagory]?, error: NSError?) in
            guard let strongSelf = self else{return}
            if error == nil{
                if let catagory = catagory{
                    strongSelf.catagory = catagory
                    for index in catagory{
                        if let type = index.type{
                            if type == "Local Guide" || type == "Travel Agency" || type == "Hotel" || type == "Experience"{
                                strongSelf.menuCatagory1.append(type)
                                strongSelf.dataForMenu1.append(index)
                            }else{
                                strongSelf.menuCatagory2.append(type)
                                strongSelf.dataForMenu2.append(index)
                            }
                        }
                    }
                    //strongSelf.tableViewCarousels.reloadData()
                    strongSelf.carouselsCollectionView.reloadData()
                    //strongSelf.collectionViewFriends.reloadData()
                    
                }
                print("success")
            }else{
                print("false")
            }
        })
    }
    /// end rest
}

extension NewHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == carouselsCollectionView{
            if menuCatagory1.count > 1{
                return menuCatagory1.count
            }
            return 0
        }else if collectionView == contentsCollectionView{
            return 5
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == carouselsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselsCollectionViewCell
            cell.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
            if indexPath.item == 0{
                cell.viewColor.backgroundColor = UIColor.white
                cell.nameCarousel.textColor = UIColor.white
                indexPathSelected = indexPath
            }else{
                cell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                cell.nameCarousel.textColor = color4
            }
            
            cell.nameCarousel.text = menuCatagory1[indexPath.row].uppercased()
            return cell
        }else{
            if indexPath.row == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableViewContent", for: indexPath) as! TableViewForCollectionViewCell
                cell.backgroundColor = UIColor.red
                return cell
            }else{
                let cell = contentsCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewContent", for: indexPath) as! CollectionViewForCollectionViewCell
                cell.backgroundColor = UIColor.green
                return cell
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == carouselsCollectionView{
            var width: CGFloat = 0.0
            var height: CGFloat = 0.0
            if menuCatagory1.count > 1 {
                let size: CGSize = menuCatagory1[indexPath.row].size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)])
                
                width = size.width
                height = carouselsCollectionView.frame.height
                
            }else{
                width = carouselsCollectionView.frame.width
                height = carouselsCollectionView.frame.height
            }
            
            return CGSize(width: width, height: height)
        }else if collectionView == contentsCollectionView{
            return CGSize(width: self.contentsCollectionView.frame.width, height: self.contentsCollectionView.frame.height)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == carouselsCollectionView{
            if !indexPathSelected.isEmpty{
                let oldCell = collectionView.cellForItem(at: indexPathSelected) as! CarouselsCollectionViewCell
                if self.isScaleMenuView{
                    oldCell.viewColor.backgroundColor = UIColor.white
                    oldCell.nameCarousel.textColor = UIColor.gray
                }else{
                    oldCell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                    oldCell.nameCarousel.textColor = color4
                }
                indexPathSelected = []
            }
            
            let newCell = collectionView.cellForItem(at: indexPath) as! CarouselsCollectionViewCell
            if self.isScaleMenuView{
                newCell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                newCell.nameCarousel.textColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
            }else{
                newCell.viewColor.backgroundColor = UIColor.white
                newCell.nameCarousel.textColor = UIColor.white
            }
            indexPathSelected = indexPath
            //tableViewCarousels.isHidden = true
            //collectionViewDetail.isHidden = false
            if indexPath.row > 0{
                dataForHome.removeAll()
                if let data = dataForMenu1[indexPath.row - 1].catagoryItems{
                    self.dataForHome = data
                    switch dataForMenu1[indexPath.row - 1].typeCatagory{
                    case .localGuideType:
                        type = .LocalGuide
                    case .travelAgencyType:
                        type = .TravelAgency
                    case .hotelType:
                        type = .Hotel
                    case .experienceType:
                        type = .Experience
                    default:
                        print("abc")
                    }
                }
            }
            carouselsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}
