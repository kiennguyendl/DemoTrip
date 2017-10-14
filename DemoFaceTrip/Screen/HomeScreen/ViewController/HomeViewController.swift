//
//  HomeViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import AlamofireImage

enum typeCatagoryForHome{
    case ForYou
    case Hotel
    case Experience
    case CityTour
    case FoodTour
    case LocalGuide
    case TravelAgency
    case Attraction
}

let color1: UIColor = UIColor(red: 226.0/255.0, green: 67.0/255.0, blue: 99.0/255.0, alpha: 1.0)
let color2: UIColor = UIColor(red: 236.0/255.0, green: 111.0/255.0, blue: 115.0/255.0, alpha: 1.0)
let color3: UIColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)

class HomeViewController: BaseViewController {
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var childViewMenu: UIView!
    
    @IBOutlet weak var collectionViewCarousels: UICollectionView!
    @IBOutlet weak var collectionViewFriends: UICollectionView!
    @IBOutlet weak var tableViewCarousels: UITableView!
    @IBOutlet weak var collectionViewDetail: UICollectionView!
    
    @IBOutlet weak var heightOfViewMenu: NSLayoutConstraint!
    
    var catagory: [Catagory] = []
    var menuCatagory1 = ["For You"]
    var menuCatagory2: [String] = []
    var dataForMenu1: [Catagory] = []
    var dataForMenu2: [Catagory] = []
    var dataForHome: [AnyObject] = []
    var type: typeCatagoryForHome = .ForYou
    var indexPathSelected: IndexPath = []
    var isScaleMenuView = false
    
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor(red: 226.0/255.0, green: 67.0/255.0, blue: 99.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 236.0/255.0, green: 111.0/255.0, blue: 115.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0).cgColor
        ]
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewDetail.isHidden = true
        
        
        initCollectionView()
        initTableView()
        restDataForHome()
        setColorForMenuView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //select default cell for first time load data
        //        let indexPath = IndexPath(item: 0, section: 0)
        //        indexPathSelected = indexPath
        //        let newCell = self.collectionViewCarousels.cellForItem(at: indexPath) as! CarouselsCollectionViewCell
        //        newCell.viewColor.backgroundColor = UIColor.white
        //self.dataForHome = self.catagory
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        //if tabBarController?.tabBar.isHidden == true{
            tabBarController?.tabBar.isHidden = false
        //}
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer.frame = self.viewMenu.bounds
    }
    /// init and register cell for collection view
    func initCollectionView() {
        collectionViewCarousels.delegate = self
        collectionViewCarousels.dataSource = self
        collectionViewCarousels.register(UINib.init(nibName: "CarouselsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
        collectionViewCarousels.backgroundColor = color3
        collectionViewCarousels.showsHorizontalScrollIndicator = false
        
        collectionViewFriends.delegate = self
        collectionViewFriends.dataSource = self
        collectionViewFriends.register(UINib.init(nibName: "ListCatagoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CatagoryCell")
        
        collectionViewDetail.delegate = self
        collectionViewDetail.dataSource = self
        collectionViewDetail.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
        collectionViewDetail.showsVerticalScrollIndicator = false
    }
    
    func setColorForMenuView() {
        self.viewMenu.layer.insertSublayer(gradientLayer, below: self.childViewMenu.layer)
        gradientLayer.frame = self.viewMenu.bounds
        self.childViewMenu.dropShadow(color: UIColor(red: 152.0/255.0, green: 91.0/255.0, blue: 86.0/255.0, alpha: 1.0), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
        self.childViewMenu.layer.cornerRadius = self.childViewMenu.frame.width / 97
    }
    
    //init and register cell for tableview
    func initTableView() {
        tableViewCarousels.delegate = self
        tableViewCarousels.dataSource = self
        tableViewCarousels.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        tableViewCarousels.showsHorizontalScrollIndicator = false
        tableViewCarousels.showsVerticalScrollIndicator = false
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
                    strongSelf.tableViewCarousels.reloadData()
                    strongSelf.collectionViewCarousels.reloadData()
                    strongSelf.collectionViewFriends.reloadData()
                    
                }
                print("success")
            }else{
                print("false")
            }
        })
    }
}

//CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewCarousels{
            return menuCatagory1.count
        }else if collectionView == self.collectionViewFriends{
            return dataForMenu2.count
        }else{
            return dataForHome.count
        }
        //return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewCarousels{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselsCollectionViewCell
            cell.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
            if indexPath.item == 0{
                cell.viewColor.backgroundColor = UIColor.white
                indexPathSelected = indexPath
            }else{
                cell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
            }
            
            cell.nameCarousel.text = menuCatagory1[indexPath.row]
            return cell
            
        }else if collectionView == self.collectionViewFriends{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatagoryCell", for: indexPath) as! ListCatagoryCollectionViewCell
            //cell.nameCarousel.text = Carousels[indexPath.row]
            cell.avatar.layer.cornerRadius = cell.avatar.frame.width / 2
            cell.viewBackGroud.layer.cornerRadius = cell.viewBackGroud.frame.width / 2
            cell.avatar.clipsToBounds = true
            cell.nameCatagory.text = dataForMenu2[indexPath.row].type
            
            let strURL = dataForMenu2[indexPath.row].avatar
            let url = URL(string: strURL!)
            cell.avatar.af_setImage(withURL: url!)
            
            switch dataForMenu2[indexPath.row].typeCatagory{
                
            case .attractionType:
                var sumReview = 0
                if let catagoryItems = dataForMenu2[indexPath.row].catagoryItems as? [Attraction]{
                    for index in 0 ..< catagoryItems.count{
                        if let numReview = catagoryItems[index].numReview{
                            sumReview = sumReview + numReview
                        }
                    }
                }
                cell.numberLbl.text = ("\(sumReview)+")
                break
            case .themParkType:
                var sumReview = 0
                if let catagoryItems = dataForMenu2[indexPath.row].catagoryItems as? [ThemeParks]{
                    for index in 0 ..< catagoryItems.count{
                        if let numReview = catagoryItems[index].numReview{
                            sumReview = sumReview + numReview
                        }
                    }
                }
                cell.numberLbl.text = ("\(sumReview)+")
                break
            case .cityTourType:
                var sumReview = 0
                if let catagoryItems = dataForMenu2[indexPath.row].catagoryItems as? [CityTour]{
                    for index in 0 ..< catagoryItems.count{
                        if let numReview = catagoryItems[index].numPersonReview{
                            sumReview = sumReview + numReview
                        }
                    }
                }
                cell.numberLbl.text = ("\(sumReview)+")
                break
            case .foodTourType:
                var sumReview = 0
                if let catagoryItems = dataForMenu2[indexPath.row].catagoryItems as? [FoodTour]{
                    for index in 0 ..< catagoryItems.count{
                        if let numReview = catagoryItems[index].numReview{
                            sumReview = sumReview + numReview
                        }
                    }
                }
                cell.numberLbl.text = ("\(sumReview)+")
                break
            default:
                print("")
            }
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
            switch type{
            case .ForYou:
                break
            case .Hotel:
                if let item = self.dataForHome[indexPath.row] as? Hotel{
                    if let nameHotel = item.nameHotel{
                        cell.name.text = nameHotel
                    }
                    
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.frame.width, height: cell.image.frame.height)).withRenderingMode(.alwaysOriginal)
                        
                    }
                    
                    if let place = item.place{
                        cell.place.text = place
                    }
                    
                    if let price = item.price{
                        print(price)
                        cell.price.text = "Price: " + "\(price)" + "$"
                    }
                    
                    if let review = item.numPersonReview{
                        cell.Review.text = "Review: " + "\(review)"
                        print(review)
                    }
                }
                break
            case .Experience:
                if let item = self.dataForHome[indexPath.row] as? Experience{
                    if let nameExp = item.experience{
                        cell.name.text = nameExp
                    }
                    
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.frame.width, height: cell.image.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let place = item.place{
                        cell.place.text = place
                    }
                    
                    if let price = item.price{
                        cell.price.text = "Price: " + "\(price)" + "$"
                    }
                    
                    if let review = item.numPersonReview{
                        cell.Review.text = "Review: " + "\(review)"
                    }
                }
                break
            case .CityTour:
                break
            case .FoodTour:
                break
            case .LocalGuide:
                if let item = dataForHome[indexPath.row] as? LocalGuide{
                    if let nameGuide = item.nameGuide{
                        cell.name.text = nameGuide
                    }
                    
                    if let urlStr = item.avatar{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.frame.width, height: cell.image.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let place = item.place{
                        cell.place.text = place
                    }
                    
                    if let price = item.price{
                        cell.price.text = "Price: " + "\(price)" + "$/Person"
                    }
                    
                    if let numLike = item.numLike{
                        cell.Review.text = "Like: " + "\(numLike)"
                    }
                }
                break
            case .TravelAgency:
                if let item = dataForHome[indexPath.row] as? TravelAgency{
                    if let name = item.name{
                        cell.name.text = name
                    }
                    
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.frame.width, height: cell.image.frame.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let place = item.place{
                        cell.place.text = place
                    }
                    
                    if let country = item.country{
                        cell.price.text = "Country: " + "\(country)"
                    }
                    
                    if let review = item.numReview{
                        cell.Review.text = "Review: " + "\(review)"
                    }
                }
                break
            case .Attraction:
                
                break
            }
            return cell
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewCarousels{
            var width: CGFloat = 0.0
            var height: CGFloat = 0.0
            if menuCatagory1.count > 1 {
                let size: CGSize = menuCatagory1[indexPath.row].size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)])
                
                width = size.width
                height = collectionViewCarousels.frame.height
                
            }else{
                width = collectionViewCarousels.frame.width
                height = collectionViewCarousels.frame.height
            }
            
            return CGSize(width: width, height: height)
        }else if collectionView == self.collectionViewFriends{
            let width = collectionViewFriends.frame.width / 4
            let height = collectionViewFriends.frame.height
            
            return CGSize(width: width, height: height)
        }else{
            let width = collectionViewDetail.frame.width / 2 - 10
            return CGSize(width: width, height: width + 20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewFriends{
            //            DispatchQueue.main.async {
            //                let index = IndexPath(item: 0, section: indexPath.row)
            //                self.tableViewCarousels.scrollToRow(at: index, at: .none, animated: true)
            //            }
            let vc = ListDetailCatagoryViewController()
            vc.typeCatagory = dataForMenu2[indexPath.row].typeCatagory
            vc.listDetail = dataForMenu2[indexPath.row].catagoryItems
            navigationController?.pushViewController(vc, animated: true)
        }
        if collectionView == self.collectionViewCarousels{
            
            if !indexPathSelected.isEmpty{
                let oldCell = collectionView.cellForItem(at: indexPathSelected) as! CarouselsCollectionViewCell
                if self.isScaleMenuView{
                    oldCell.viewColor.backgroundColor = UIColor.white
                    oldCell.nameCarousel.textColor = UIColor.gray
                }else{
                    oldCell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                }
                indexPathSelected = []
            }
            
            let newCell = collectionView.cellForItem(at: indexPath) as! CarouselsCollectionViewCell
            if self.isScaleMenuView{
                newCell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                newCell.nameCarousel.textColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
            }else{
                newCell.viewColor.backgroundColor = UIColor.white
            }
            indexPathSelected = indexPath
            collectionViewDetail.isHidden = false
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
                collectionViewDetail.reloadData()
                collectionViewDetail.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredVertically, animated: true)
            }else{
                dataForHome.removeAll()
                collectionViewDetail.isHidden = true
                type = .ForYou
                tableViewCarousels.reloadData()
            }
        }
    }
    
}

//// TableView
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return catagory.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableViewCell
        cell.delegate = self
        let currentSection = indexPath.section
        cell.collectionViewForCell.tag = currentSection
        cell.currentSection = currentSection
        cell.catagoryItems = catagory[currentSection].catagoryItems
        switch catagory[currentSection].typeCatagory {
        case .hotelType:
            cell.type = .hotelType
        case .experienceType:
            cell.type = .experienceType
        case .localGuideType:
            cell.type = .localGuideType
        case .attractionType:
            cell.type = .attractionType
        case .themParkType:
            cell.type = .themParkType
        case .cityTourType:
            cell.type = .cityTourType
        case .foodTourType:
            cell.type = .foodTourType
        case .travelAgencyType:
            cell.type = .travelAgencyType
        default:
            cell.type = .None
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.frame.height / 2.7
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //add custome view for header
        let view = HeaderView()
        view.backgroundColor = UIColor.white
        view.nameOfCarousel.text = catagory[section].type
        view.targetView.layer.cornerRadius = view.targetView.frame.width / 6
        return view
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // cần fix animation. tách thread
        if let _ = scrollView as? UITableView{
            let newPos = self.viewMenu.frame.height - collectionViewCarousels.frame.height + 5
            
            //handle when scroll up
            if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y >= 0{
                //print("move down")
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3, animations: {
                        if self.view.frame.origin.y < 0{
                            
                            //move origin coordinates of main view to up
                            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - newPos)
                            
                            self.setColorForMenuView()
                            
                            //change color when scroll up
                            self.viewMenu.backgroundColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
                            self.collectionViewCarousels.backgroundColor = color3
                            for index in 0..<self.menuCatagory1.count {
                                let indexPath = IndexPath(item: index, section: 0)
                                if let cell = self.collectionViewCarousels.cellForItem(at: indexPath) as? CarouselsCollectionViewCell{
                                    if self.indexPathSelected == indexPath{
                                        cell.viewColor.backgroundColor = UIColor.white
                                    }else{
                                        cell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                                    }
                                    cell.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                                    cell.nameCarousel.textColor = UIColor.white
                                }
                                
                            }
                            
                            
                            self.isScaleMenuView = false
                        }
                        
                    })
                }
                
            }else{
                //handle when scroll down
                //print("move up")
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.3, animations: {
                        if self.view.frame.origin.y >= 0{
                            //move origin coordinates of main view to 0
                            self.view.frame = CGRect(x: self.view.frame.origin.x, y: -newPos, width: self.view.frame.size.width, height: self.view.frame.size.height + newPos)
                            
                            //change color when scroll down
                            self.viewMenu.backgroundColor = UIColor.white
                            self.collectionViewCarousels.backgroundColor = UIColor.white
                            for index in 0..<self.menuCatagory1.count {
                                let indexPath = IndexPath(item: index, section: 0)
                                if let cell = self.collectionViewCarousels.cellForItem(at: indexPath) as? CarouselsCollectionViewCell{
                                    if self.indexPathSelected == indexPath{
                                        cell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                                        cell.nameCarousel.textColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                                    }else{
                                        cell.viewColor.backgroundColor = UIColor.white
                                        cell.nameCarousel.textColor = UIColor.gray
                                    }
                                    cell.backgroundColor = UIColor.white
                                }
                                
                                
                            }
                            if let view = self.viewMenu{
                                for layer in view.layer.sublayers!{
                                    if layer == self.gradientLayer{
                                        layer.removeFromSuperlayer()
                                    }
                                }
                            }
                            self.isScaleMenuView = true
                        }
                    })
                }
                
            }
        }
    }
}

extension HomeViewController: HomeCellDelegate{
    func didPressCell(currentSection: Int, index: Int, type: catagoryType) {
        let vc = DetailViewController()
        vc.type = type
        if let items = catagory[currentSection].catagoryItems   {
            switch type {
            case .attractionType:
                let item = items[index] as? Attraction
                vc.item = item
            case .themParkType:
                let item = items[index] as? ThemeParks
                vc.item = item
            case .localGuideType:
                let item = items[index] as? LocalGuide
                vc.item = item
            case .experienceType:
                let item = items[index] as? Experience
                vc.item = item
            case .cityTourType:
                let item = items[index] as? CityTour
                vc.item = item
            case .foodTourType:
                let item = items[index] as? FoodTour
                vc.item = item
            case .hotelType:
                let item = items[index] as? Hotel
                vc.item = item
            case .travelAgencyType:
                let item = items[index] as? TravelAgency
                vc.item = item
            default:
                print("")
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
