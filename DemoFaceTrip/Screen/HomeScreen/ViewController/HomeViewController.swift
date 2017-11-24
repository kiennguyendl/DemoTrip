//
//  HomeViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import AlamofireImage
import GooglePlaces

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
    
    @IBOutlet weak var categoryMenuView: UIView!
    var tableViewCarousels: UITableView!
    var previousOffset: CGFloat = 0

    var indexPathSelected: IndexPath = IndexPath(item: 0, section: 0)
    static var verticalContentOffset: CGFloat!
    
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
    
    var listID: [ListInforMenu] = []
    //var data: AnyObject?
    var viewForHeaderZero: UIView!
    var city: City!
    
    var listCarousel = ["For Your", "Local Guide", "Hotels", "Travel Agency"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRedColorForStatusBar()
        collectionViewDetail.isHidden = true
        self.heightOfViewBottomLineMenu.constant = 0
        initCollectionView()
        initTableView()
        viewForHeaderZero  = HeaderZeroView()
        setColorForMenuView()
        //addSwipeForController()
        newPos = self.viewMenu.frame.height - (collectionViewCarousels.frame.height + 15)
        
        inputTextSearchTf.addTarget(self, action: #selector(presentChooseCityView(textField:)), for: .touchDown)
        
        if Settings.city == nil{
            let vc = ChooseCityViewController()
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }else{
            inputTextSearchTf.text = Settings.cityPicked
            city = NSKeyedUnarchiver.unarchiveObject(with: Settings.city!) as! City
            listID = city.listID!
            tableViewCarousels.reloadData()
//            restDataForHome()
        }
//        self.initIndicator()
//        self.view.bringSubview(toFront: activityIndicator)
//        self.displayIndicator()
    }
    
    @objc func presentChooseCityView(textField: UITextField) {
        let vc = ChooseCityViewController()
        self.view.endEditing(true)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableViewCarousels.contentOffset = CGPoint(x: 0, y: 0)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
        
        
        if Settings.isScaleMenuView!{
            
            setWhiteColorForStatusBar()
            self.viewMenu.frame.origin.y = self.viewMenu.frame.origin.y - newPos
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: -self.newPos, width: self.view.frame.size.width, height: self.view.frame.size.height + self.newPos)
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

//        collectionViewDetail.delegate = self
//        collectionViewDetail.dataSource = self
//        collectionViewDetail.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
//        collectionViewDetail.showsVerticalScrollIndicator = false
//        collectionViewDetail.tag = 1
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
        
        let topConstraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.viewMenu, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
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
//                            self.collectionViewCarousels.selectItem(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .centeredHorizontally)
//                            self.collectionView(self.collectionViewCarousels, didSelectItemAt: IndexPath(row: row + 1, section: 0))
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
//                            self.collectionViewCarousels.selectItem(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .centeredHorizontally)
//                            self.collectionView(self.collectionViewCarousels, didSelectItemAt: IndexPath(row: row - 1, section: 0))
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
    
    func restDataForCategory() {
        RestDataManager.shareInstance.restDataFollowTypeOfMenu(urlForHome,menu: "menu", action: "getlist", id: 01, idMenu: 1005, type: "Attractions", complertionHandler: {[weak self] (catagory: ShowAndAttrachtions?, error: NSError?) in
            guard let strongSelf = self else{return}
            print(strongSelf)
        })
    }
    
    
}




