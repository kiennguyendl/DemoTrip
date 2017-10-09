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
    case Tour
}

let textColorNormal: UIColor = UIColor.white
let backgroudColorNormal: UIColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
let viewColorNormal: UIColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)

let texColortScale: UIColor = UIColor.gray
let backgroudColorScale: UIColor = UIColor.white
let viewCorlorScale: UIColor = UIColor.white

class HomeViewController: BaseViewController {
    @IBOutlet weak var viewMenu: UIView!
    
    @IBOutlet weak var collectionViewCarousels: UICollectionView!
    @IBOutlet weak var collectionViewFriends: UICollectionView!
    @IBOutlet weak var tableViewCarousels: UITableView!
    @IBOutlet weak var collectionViewDetail: UICollectionView!

    @IBOutlet weak var heightOfViewMenu: NSLayoutConstraint!
    
    var catagory: [Catagory] = []
    var menuCatagory = ["For You"]
    var dataForHome: [AnyObject] = []
    var type: typeCatagoryForHome = .ForYou
    var indexPathSelected: IndexPath = []
    var isScaleMenuView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewDetail.isHidden = true
        navigationController?.isNavigationBarHidden = true
        //init home
        initCollectionView()
        initTableView()
        restDataForHome()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //select default cell for first time load data
//        let indexPath = IndexPath(item: 0, section: 0)
//        indexPathSelected = indexPath
//        let newCell = self.collectionViewCarousels.cellForItem(at: indexPath) as! CarouselsCollectionViewCell
//        newCell.viewColor.backgroundColor = UIColor.white
        //self.dataForHome = self.catagory
    }

    /// init and register cell for collection view
    func initCollectionView() {
        collectionViewCarousels.delegate = self
        collectionViewCarousels.dataSource = self
        collectionViewCarousels.register(UINib.init(nibName: "CarouselsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
        
        collectionViewFriends.delegate = self
        collectionViewFriends.dataSource = self
        collectionViewFriends.register(UINib.init(nibName: "ListCatagoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CatagoryCell")
        
        collectionViewDetail.delegate = self
        collectionViewDetail.dataSource = self
        collectionViewDetail.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
    }
    
    //init and register cell for tableview
    func initTableView() {
        tableViewCarousels.delegate = self
        tableViewCarousels.dataSource = self
        tableViewCarousels.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
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
                            strongSelf.menuCatagory.append(type)
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
            return menuCatagory.count
        }else if collectionView == self.collectionViewFriends{
            return catagory.count
        }else{
            return dataForHome.count
        }
        //return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewCarousels{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselsCollectionViewCell
            cell.backgroundColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
            if indexPath.item == 0{
                    cell.viewColor.backgroundColor = UIColor.white
                    indexPathSelected = indexPath
            }else{
                cell.viewColor.backgroundColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
            }
            cell.nameCarousel.text = menuCatagory[indexPath.row]
            
            return cell
        }else if collectionView == self.collectionViewFriends{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatagoryCell", for: indexPath) as! ListCatagoryCollectionViewCell
            //cell.nameCarousel.text = Carousels[indexPath.row]
            cell.avatar.layer.cornerRadius = cell.avatar.frame.width / 2
            cell.avatar.clipsToBounds = true
            cell.nameCatagory.text = catagory[indexPath.row].type
            
            let strURL = catagory[indexPath.row].avatar
            let url = URL(string: strURL!)
            cell.avatar.af_setImage(withURL: url!)
            
            switch catagory[indexPath.row].typeCatagory{
            case .hotelType:
                var sumReview = 0
                if let catagoryItems = catagory[indexPath.row].catagoryItems as? [Hotel]{
                    for index in 0 ..< catagoryItems.count{
                        if let numReview = catagoryItems[index].numPersonReview{
                            sumReview = sumReview + numReview
                        }
                    }
                }
                cell.numberLbl.text = ("\(sumReview)+")
            case .experienceType:
                var sumReview = 0
                if let catagoryItems = catagory[indexPath.row].catagoryItems as? [Experience]{
                    for index in 0 ..< catagoryItems.count{
                        if let numReview = catagoryItems[index].numPersonReview{
                            sumReview = sumReview + numReview
                        }
                    }
                }
                cell.numberLbl.text = ("\(sumReview)+")
            case .tourType:
                var sumReview = 0
                if let catagoryItems = catagory[indexPath.row].catagoryItems as? [Tour]{
                    for index in 0 ..< catagoryItems.count{
                        if let numReview = catagoryItems[index].numPersonReview{
                            sumReview = sumReview + numReview
                        }
                    }
                }
                cell.numberLbl.text = ("\(sumReview)+")
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
            case .Tour:
                if let item = self.dataForHome[indexPath.row] as? Tour{
                    if let nameTour = item.tour{
                        cell.name.text = nameTour
                    }
                    
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        
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
            }
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionViewCarousels{
            let width = collectionViewCarousels.frame.width / 4
            let height = collectionViewCarousels.frame.height
            
            return CGSize(width: width, height: height)
        }else if collectionView == self.collectionViewFriends{
            let width = collectionViewFriends.frame.width / 4
            let height = collectionViewFriends.frame.height
            
            return CGSize(width: width, height: height)
        }else{
            let width = collectionViewDetail.frame.width - 10
            return CGSize(width: width, height: width * 3 / 4)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewFriends{
            DispatchQueue.main.async {
                let index = IndexPath(item: 0, section: indexPath.row)
                self.tableViewCarousels.scrollToRow(at: index, at: .none, animated: true)
            }
        }
        if collectionView == self.collectionViewCarousels{
            
            if !indexPathSelected.isEmpty{
                let oldCell = collectionView.cellForItem(at: indexPathSelected) as! CarouselsCollectionViewCell
                if self.isScaleMenuView{
                    oldCell.viewColor.backgroundColor = UIColor.white
                    oldCell.nameCarousel.textColor = UIColor.gray
                }else{
                    oldCell.viewColor.backgroundColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
                }
                indexPathSelected = []
            }
            
            let newCell = collectionView.cellForItem(at: indexPath) as! CarouselsCollectionViewCell
            if self.isScaleMenuView{
                newCell.viewColor.backgroundColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
                newCell.nameCarousel.textColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
            }else{
                newCell.viewColor.backgroundColor = UIColor.white
            }
            indexPathSelected = indexPath
            collectionViewDetail.isHidden = false
            if indexPath.row > 0{
                dataForHome.removeAll()
                if let data = catagory[indexPath.row - 1].catagoryItems{
                    self.dataForHome = data
                    switch catagory[indexPath.row - 1].typeCatagory{
                    case .hotelType:
                        type = .Hotel
                    case .experienceType:
                        type = .Experience
                    case .tourType:
                        type = .Tour
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
        let currentSection = indexPath.section
        cell.collectionViewForCell.tag = currentSection
        cell.rowIndex = currentSection
        cell.catagoryItems = catagory[currentSection].catagoryItems
        switch catagory[currentSection].typeCatagory {
        case .hotelType:
            cell.type = .hotelType
        case .experienceType:
            cell.type = .experienceType
        case .tourType:
            cell.type = .tourType
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
        return view

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newPos = self.viewMenu.frame.height - collectionViewCarousels.frame.height + 10
        
        //handle when scroll up
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y >= 0{
            print("move down")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.view.frame.origin.y < 0{
                        
                        //move origin coordinates of main view to up
                        self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - newPos)
                        
                        //change color when scroll up
                        self.viewMenu.backgroundColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
                        for index in 0..<self.menuCatagory.count {
                            let indexPath = IndexPath(item: index, section: 0)
                            let cell = self.collectionViewCarousels.cellForItem(at: indexPath) as! CarouselsCollectionViewCell
                            if self.indexPathSelected == indexPath{
                                cell.viewColor.backgroundColor = UIColor.white
                            }else{
                                cell.viewColor.backgroundColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
                            }
                            cell.backgroundColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
                            cell.nameCarousel.textColor = UIColor.white
                        }
                        self.isScaleMenuView = false
                    }
                    
                })
            }
            
        }else{
            //handle when scroll down
            print("move up")
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5, animations: {
                    if self.view.frame.origin.y >= 0{
                        //move origin coordinates of main view to 0
                        self.view.frame = CGRect(x: self.view.frame.origin.x, y: -newPos, width: self.view.frame.size.width, height: self.view.frame.size.height + newPos)
                        
                        //change color when scroll down
                        self.viewMenu.backgroundColor = UIColor.white
                        for index in 0..<self.menuCatagory.count {
                            let indexPath = IndexPath(item: index, section: 0)
                            let cell = self.collectionViewCarousels.cellForItem(at: indexPath) as! CarouselsCollectionViewCell
                            if self.indexPathSelected == indexPath{
                                cell.viewColor.backgroundColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue:129.0/255.0, alpha: 1.0)
                                cell.nameCarousel.textColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
                            }else{
                                cell.viewColor.backgroundColor = UIColor.white
                                cell.nameCarousel.textColor = UIColor.gray
                            }
                            cell.backgroundColor = UIColor.white
                            
                        }
                        self.isScaleMenuView = true
                    }
                })
            }
            
        }
    }

}
