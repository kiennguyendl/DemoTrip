//
//  HomeViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeViewController: BaseViewController {
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var childViewMenu: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var inputTextSearchTf: UITextField!
    @IBOutlet weak var bottomViewLineMenu: UIView!
    @IBOutlet weak var heightOfViewBottomLineMenu: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var collectionViewCarousels: UICollectionView!
    @IBOutlet weak var collectionViewDetail: UICollectionView!
    
    @IBOutlet weak var heightOfViewMenu: NSLayoutConstraint!
    
    var tableViewCarousels: UITableView!
    
    var catagory: [Catagory] = []
    var menuCatagory1 = ["For You"]
    var menuCatagory2: [String] = []
    var dataForMenu1: [Catagory] = []
    var dataForMenu2: [Catagory] = []
    var dataForHome: [AnyObject] = []
    var type: typeCatagoryForHome = .ForYou
    var indexPathSelected: IndexPath = IndexPath(item: 0, section: 0)
    
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor(red: 226.0/255.0, green: 67.0/255.0, blue: 99.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 236.0/255.0, green: 111.0/255.0, blue: 115.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0).cgColor
        ]
        return layer
    }()
    
    var newPos: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRedColorForStatusBar()
        collectionViewDetail.isHidden = true
        self.heightOfViewBottomLineMenu.constant = 0
        initCollectionView()
        initTableView()
        restDataForHome()
        setColorForMenuView()
        addSwipeForController()
        newPos = self.viewMenu.frame.height - (collectionViewCarousels.frame.height + 15)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableViewCarousels.contentOffset = CGPoint(x: 0, y: 0)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        
        
        if Settings.isScaleMenuView!{
            
            //hidenSubMenu()
            setWhiteColorForStatusBar()
            self.viewMenu.frame.origin.y = self.viewMenu.frame.origin.y - newPos
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: -self.newPos, width: self.view.frame.size.width, height: self.view.frame.size.height + self.newPos)
            //self.viewMenu.backgroundColor = UIColor.blue
        }else{
            showSubMenu()
            collectionViewCarousels.backgroundColor = color3
            collectionViewCarousels.reloadData()
        }
        tableViewCarousels.isScrollEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setWhiteColorForStatusBar()
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false

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

        collectionViewDetail.delegate = self
        collectionViewDetail.dataSource = self
        collectionViewDetail.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
        collectionViewDetail.showsVerticalScrollIndicator = false
        collectionViewDetail.tag = 1
        
    }
    
    func showSubMenu() {
        childViewMenu.isHidden = false
        menuBtn.isHidden = false
        searchBtn.isHidden = false
        inputTextSearchTf.isHidden = false
        setColorForMenuView()
        self.childViewMenu.dropShadow(color: UIColor(red: 152.0/255.0, green: 91.0/255.0, blue: 86.0/255.0, alpha: 1.0), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
        self.heightOfViewBottomLineMenu.constant = 0
    }
    
    func hidenSubMenu() {
        childViewMenu.isHidden = true
        menuBtn.isHidden = true
        searchBtn.isHidden = true
        inputTextSearchTf.isHidden = true
        self.childViewMenu.dropShadow(color: UIColor(red: 152.0/255.0, green: 91.0/255.0, blue: 86.0/255.0, alpha: 0), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
        self.heightOfViewBottomLineMenu.constant = 1
        
    }
    
    func setColorForMenuView() {
        if Settings.isScaleMenuView!{
            print("abc")
        }else{
            self.viewMenu.layer.insertSublayer(gradientLayer, below: self.childViewMenu.layer)
            gradientLayer.frame = self.viewMenu.bounds
            self.childViewMenu.dropShadow(color: UIColor(red: 152.0/255.0, green: 91.0/255.0, blue: 86.0/255.0, alpha: 1.0), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
            self.childViewMenu.layer.cornerRadius = self.childViewMenu.frame.width / 97
        }
    }
    
    //init and register cell for tableview
    func initTableView() {
        addContrailForTableView()
        tableViewCarousels.delegate = self
        tableViewCarousels.dataSource = self
        tableViewCarousels.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        tableViewCarousels.showsHorizontalScrollIndicator = false
        tableViewCarousels.showsVerticalScrollIndicator = false
        tableViewCarousels.isHidden = false
        tableViewCarousels.tag = 2
        collectionViewDetail.superview?.bringSubview(toFront: tableViewCarousels)
        tableViewCarousels.backgroundColor = UIColor.white
    }

    func addContrailForTableView() {
        
        let frame = self.view.frame
        tableViewCarousels = UITableView(frame: frame, style: .grouped)
        
        self.view.addSubview(tableViewCarousels)
        
        let topConstraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.collectionViewDetail, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
        let leadingContraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([topConstraint, leadingContraint, trailingConstraint, bottomConstraint])
        
        
        
        tableViewCarousels.translatesAutoresizingMaskIntoConstraints = false
        tableViewCarousels.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableViewCarousels.separatorStyle = .none
        tableViewCarousels.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    // add swipe
    func addSwipeForController() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeAction(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeAction(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipeAction(gesture: UIGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            
            if let swipeGesture = gesture as? UISwipeGestureRecognizer{
                switch swipeGesture.direction{
                case .left:
                    let row = self.indexPathSelected.row
                    if row < 4{
                        UIView.animate(withDuration: 0.5, animations: {
                            self.collectionViewCarousels.selectItem(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                            self.collectionView(self.collectionViewCarousels, didSelectItemAt: IndexPath(row: row + 1, section: 0))
                            self.tableViewCarousels.isHidden = true
                            self.collectionViewDetail.isHidden = false
                            self.collectionViewDetail.reloadData()
                        })
                        
                    }
                    break
                case .right:
                    let row = self.indexPathSelected.row
                    if row > 0{
                        UIView.animate(withDuration: 0.8, animations: {
                            self.collectionViewCarousels.selectItem(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                            self.collectionView(self.collectionViewCarousels, didSelectItemAt: IndexPath(row: row - 1, section: 0))
                            if row == 1{
                                self.tableViewCarousels.isHidden = false
                                self.collectionViewDetail.isHidden = true
                                self.tableViewCarousels.reloadData()
                            }else{
                                self.tableViewCarousels.isHidden = true
                                self.collectionViewDetail.isHidden = false
                                self.collectionViewDetail.reloadData()
                            }
                        })
                        
                    }
                default:
                    print("abc")
                }
            }
        })
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
                    //strongSelf.collectionViewFriends.reloadData()
                    
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
            if menuCatagory1.count > 1{
                return menuCatagory1.count
            }
            return 0
        }else{
            
//        } if collectionView == self.collectionViewFriends{
//            return dataForMenu2.count
//        }else{
            return dataForHome.count
        }
        //return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewCarousels{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselsCollectionViewCell
            cell.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
            if Settings.isScaleMenuView!{
                
                if self.indexPathSelected == indexPath{
                    cell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                    cell.nameCarousel.textColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                }else{
                    cell.viewColor.backgroundColor = UIColor.white
                    cell.nameCarousel.textColor = UIColor.gray
                }
                cell.backgroundColor = UIColor.white
            }else{
                if indexPath == indexPathSelected{
                    cell.viewColor.backgroundColor = UIColor.white
                    cell.nameCarousel.textColor = UIColor.white
                    self.collectionViewCarousels.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
                }else{
                    cell.viewColor.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
                    cell.nameCarousel.textColor = color4
                }
                cell.backgroundColor = UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)
            }

            cell.nameCarousel.text = menuCatagory1[indexPath.row].uppercased()
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionViewCell
            switch type{
            case .ForYou:
                break
            case .Hotel:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numbooking")
                cell.img3.image = UIImage(named: "room")
                
                if let item = self.dataForHome[indexPath.row] as? Hotel{
                    if let nameHotel = item.nameHotel, let price = item.price{
                        cell.name.text = ("$\(price)USD - \(nameHotel)")
                    }
                    
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        cell.image.af_setImage(withURL: url!, completion: { response in
                            guard let image = response.result.value else{return}
                            cell.image.image = image.squaredImageForHome
                        })
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                        
                    }
                    
                    if let place = item.place{
                        cell.lbl1.text = place
                    }
                    
                    if let numbooking = item.numBook{
                        cell.lbl2.text = "\(numbooking) booked"
                    }
                    
                    if let room = item.numRoom{
                        cell.lbl3.text = "\(room) room"
                    }
                }
                break
            case .Experience:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numbooking")
                cell.img3.image = UIImage(named: "time")
                if let item = self.dataForHome[indexPath.row] as? Experience{
                    if let nameExp = item.experience, let price = item.price{
                        cell.name.text = ("$\(price)USD - \(nameExp)")
                    }
                    
                    if let urlStr = item.urlImg{
                        let url = URL(string: urlStr)
                        cell.image.af_setImage(withURL: url!, completion: { response in
                            guard let image = response.result.value else{return}
                            cell.image.image = image.squaredImageForHome
                        })
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let place = item.place{
                        cell.lbl1.text = place
                    }
                    
                    if let review = item.numPersonReview{
                        cell.lbl2.text = "\(review) review"
                    }
                    
                    if let time = item.time{
                        cell.lbl3.text = time
                    }
                }
                break
            case .CityTour:
                break
            case .FoodTour:
                break
            case .LocalGuide:
                cell.hidingView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numlike")
                cell.img3.image = UIImage(named: "language")
                
                if let item = dataForHome[indexPath.row] as? LocalGuide{
                    if let nameGuide = item.nameGuide, let price = item.price{
                        cell.name.text = ("$\(price)USD - \(nameGuide)")
                    }
                    
                    if let urlStr = item.avatar{
                        let url = URL(string: urlStr)
                        cell.image.af_setImage(withURL: url!, completion: { response in
                            guard let image = response.result.value else{return}
                            cell.image.image = image.squaredImageForHome
                        })
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let place = item.place{
                        cell.lbl1.text = place
                    }
                    
                    
                    if let numLike = item.numLike{
                        cell.lbl2.text = "\(numLike)"
                    }
                    
                    if let language = item.language{
                        cell.lbl3.text = language
                    }
                }
                break
            case .TravelAgency:
                cell.displayView()
                cell.img1.image = UIImage(named: "place")
                cell.img2.image = UIImage(named: "numbooking")
                cell.img3.image = UIImage(named: "numbooking")
                
                if let item = dataForHome[indexPath.row] as? TravelAgency{
                    if let name = item.name, let country = item.country{
                        cell.name.text = ("\(country) - \(name)")
                    }
                    
                    if let urlStr = item.image{
                        let url = URL(string: urlStr)
                        let dafautImg = UIImage(named: "default")
                        cell.image.af_setImage(withURL: url!, placeholderImage: dafautImg)
                        cell.image.image?.af_imageAspectScaled(toFit: CGSize(width: cell.image.bounds.width, height: cell.image.bounds.height)).withRenderingMode(.alwaysOriginal)
                    }
                    
                    if let place = item.place{
                        cell.lbl1.text = place
                    }
                    
                    if let numbook = item.numbook{
                        cell.lbl2.text = ("\(numbook) booked")
                    }
                    if let review = item.numReview{
                        cell.lbl3.text = "\(review) review"
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
//        }else if collectionView == self.collectionViewFriends{
//            let width = collectionViewFriends.frame.width / 4
//            let height = collectionViewFriends.frame.height
//
//            return CGSize(width: width, height: height)
        }else{
            let width = collectionViewDetail.frame.width / 2 - 10
            return CGSize(width: width, height: width * 1.5)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == self.collectionViewCarousels{
            
            indexPathSelected = []
            indexPathSelected = indexPath
            tableViewCarousels.isHidden = true
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
                collectionViewCarousels.reloadData()
                collectionViewCarousels.scrollToItem(at: indexPathSelected, at: .centeredHorizontally, animated: true)
                collectionViewDetail.reloadData()
                collectionViewDetail.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredVertically, animated: true)
            }else{
                dataForHome.removeAll()
                tableViewCarousels.isHidden = false
                collectionViewDetail.isHidden = true
                type = .ForYou
                collectionViewCarousels.reloadData()
                collectionViewCarousels.scrollToItem(at: indexPathSelected, at: .centeredHorizontally, animated: true)
                tableViewCarousels.reloadData()
            }
            collectionViewCarousels.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }else if collectionView == collectionViewDetail{
            
            let vc = DetailViewController()
            let data = dataForMenu1[self.indexPathSelected.row - 1]
            vc.type = data.typeCatagory
            if let item = data.catagoryItems?[indexPath.row]{
                vc.item = item
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}

//// TableView
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return catagory.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section != 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableViewCell

            cell.delegate = self
            let currentSection = indexPath.section - 1
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
        return UITableViewCell(style: .default, reuseIdentifier: "HomeTableCell")
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
//
//            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let height = self.view.frame.height / 2.7
        if indexPath.section == 0{
            return 0
        }
        if Settings.isScaleMenuView!{
            return ((tableViewCarousels.frame.size.height * 4) / 9 + 10)
        }else{
            return (tableViewCarousels.frame.size.height * 4) / 8 + 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 140
        }else{
            return 50
        }
    }
    @objc func showAllItem(sender: UIButton) {
        let section = sender.tag
        switch catagory[section].typeCatagory {
            
        case .localGuideType, .travelAgencyType, .hotelType, .experienceType:
            
            let typeMenu1 = catagory[section].typeCatagory
            
            for index in 0..<dataForMenu1.count{
                if typeMenu1 == dataForMenu1[index].typeCatagory{
                    
                    self.collectionViewCarousels.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                    self.collectionView(collectionViewCarousels, didSelectItemAt: IndexPath(row: index + 1, section: 0))
                    self.collectionViewDetail.isHidden = false
                    self.collectionViewDetail.reloadData()
                }
            }
            
        case .attractionType, .themParkType, .cityTourType, .foodTourType:
            
            let vc = ListDetailCatagoryViewController()
            let dataMenu2 = catagory[section]
            vc.typeCatagory = dataMenu2.typeCatagory
            if let item = dataMenu2.catagoryItems{
                vc.listDetail = item
            }
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            print("")
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //add custome view for header
        if section == 0{
            let view = HeaderZeroView()
            view.dataForMenu2 = dataForMenu2
            view.delegate = self
            return view
        }else{
            let view = HeaderView()
            view.backgroundColor = UIColor.clear
            view.nameOfCarousel.text = catagory[section - 1].type
            view.targetView.layer.cornerRadius = view.targetView.frame.width / 6
            view.seeAllBtn.tag = section
            view.seeAllBtn.addTarget(self, action: #selector(showAllItem(sender:)), for: .touchUpInside)
        return view
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // cần fix animation. tách thread
        if scrollView.tag == 1 || scrollView.tag == 2{
            
            
            //handle when scroll up
            if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y >= 0{
                //print("move down")
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2, animations: {
                        if self.view.frame.origin.y < 0{
                            //move origin coordinates of main view to up
                            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - self.newPos)
                            
                            Settings.isScaleMenuView = false
                            print("Settings.isScaleMenuView: \(Settings.isScaleMenuView)")
                        }

                    })
                    self.setColorForMenuView()
                    self.collectionViewCarousels.reloadData()
                    
                    self.setRedColorForStatusBar()
                    self.showSubMenu()
                    //change color when scroll up
                    self.viewMenu.backgroundColor = UIColor(red: 253.0/255.0, green: 137.0/255.0, blue: 129.0/255.0, alpha: 1.0)
                    self.collectionViewCarousels.backgroundColor = color3
                    
                    
                }
                
            }else if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y < 0{
                //handle when scroll down
                ///print("move up")
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2, animations: {
                        if self.view.frame.origin.y >= 0{
                            self.setWhiteColorForStatusBar()
                            //move origin coordinates of main view to 0
                            self.view.frame = CGRect(x: self.view.frame.origin.x, y: -self.newPos, width: self.view.frame.size.width, height: self.view.frame.size.height + self.newPos)
                            Settings.isScaleMenuView = true
                            print("Settings.isScaleMenuView: \(Settings.isScaleMenuView)")
                        }
                    })
                    self.collectionViewCarousels.reloadData()
                    
                    self.hidenSubMenu()
                    //change color when scroll down
                    self.viewMenu.backgroundColor = UIColor.white
                    self.collectionViewCarousels.backgroundColor = UIColor.white

                    if let view = self.viewMenu{
                        for layer in view.layer.sublayers!{
                            if layer == self.gradientLayer{
                                layer.removeFromSuperlayer()
                            }
                        }
                    }
                   
                }
                
//            }else{
//                if Settings.isScaleMenuView!{
//                     //self.view.frame = CGRect(x: self.view.frame.origin.x, y: -self.newPos, width: self.view.frame.size.width, height: self.view.frame.size.height + self.newPos)
//                }
            }
        }
    }

}

extension HomeViewController: HomeCellDelegate{
    func didPressCell(currentSection: Int, index: Int, type: catagoryType) {
        let vc = DetailViewController()
        vc.type = type
        //self.setColorForMenuView()
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
        self.setWhiteColorForStatusBar()
        //Settings.isScaleMenuView = false
        self.tableViewCarousels.isScrollEnabled = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: HeaderZeroProtocol{
    func didPressOnCellHeaderZero(index: Int, type: catagoryType) {
        let vc = ListDetailCatagoryViewController()
        vc.typeCatagory = type
        vc.listDetail = dataForMenu2[index].catagoryItems
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
