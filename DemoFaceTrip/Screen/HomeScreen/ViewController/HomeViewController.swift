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
    @IBOutlet weak var collectionViewListing: UICollectionView!
    
    @IBOutlet weak var carouselsView: UIView!
    @IBOutlet weak var topContrailOfCarouselsView: NSLayoutConstraint!
    @IBOutlet weak var bottomContrailOfCarouselsView: NSLayoutConstraint!
    @IBOutlet weak var heightOfViewMenu: NSLayoutConstraint!
    var heightOfCarouselsView: CGFloat = 0
    
    //@IBOutlet weak var categoryMenuView: UIView!
    var tableViewCarousels: UITableView!
    var tableViewSubMenu: UITableView!
    var viewForHeaderZero: HeaderZeroView!
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
    
    //the value for home screen
    var listID: [ListInforMenu] = []
    var city: City!
    
    //check is menu button or back button
    var isBackBtn = false
    var isMenuBtn = true
    var isListSubMenuDisplay = false
    //fake the data for carousels collection view
    var listCarousel = ["For Your", "Local Guide", "Hotels", "Travel Agency"]
    
    //the value for listing collection view
    var listItemOfEachTypeMenu: AnyObject!
    var listItemOfEachSubMenu: AnyObject!
    var typeOfMenu: typeOfCategoryMenu = .None
    var typeOfSubMenu = ""
    var typeMenu = ""
    var listItem = 0
    var listNumSubMenu = 0
    //var listSubMenu: AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRedColorForStatusBar()
        collectionViewListing.isHidden = true
        self.heightOfViewBottomLineMenu.constant = 0
        initCollectionView()
        initTableView()
        carouselsView.backgroundColor = color3
        viewForHeaderZero  = HeaderZeroView()
        setColorForMenuView()
        //addSwipeForController()
        heightOfCarouselsView = carouselsView.frame.height
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

        collectionViewListing.delegate = self
        collectionViewListing.dataSource = self
        collectionViewListing.register(UINib.init(nibName: "NewHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewHomeCollectionCell")
        collectionViewListing.showsVerticalScrollIndicator = false
        collectionViewListing.tag = 1
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
        collectionViewListing.superview?.bringSubview(toFront: tableViewCarousels)
        tableViewCarousels.backgroundColor = UIColor.white
        
        tableViewSubMenu.delegate = self
        tableViewSubMenu.dataSource = self
        tableViewSubMenu.register(UINib.init(nibName: "SubMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SubMenuCell")
        tableViewSubMenu.showsHorizontalScrollIndicator = false
        tableViewSubMenu.showsVerticalScrollIndicator = false
        tableViewSubMenu.isHidden = false
        tableViewSubMenu.tag = 2
        //collectionViewListing.superview?.bringSubview(toFront: tableViewCarousels)
        tableViewSubMenu.backgroundColor = UIColor.white
    }

    func addContrailForTableView() {
        
        let frame = self.view.frame
        tableViewCarousels = UITableView(frame: frame, style: .grouped)
        tableViewSubMenu = UITableView(frame: frame, style: .grouped)
        
        self.view.addSubview(tableViewCarousels)
        self.view.addSubview(tableViewSubMenu)
        
        let topConstraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.carouselsView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        let leadingContraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.tableViewCarousels, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([topConstraint, leadingContraint, trailingConstraint, bottomConstraint])
        
        
        let topSubConstraint = NSLayoutConstraint(item: self.tableViewSubMenu, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.carouselsView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        let leadingSubContraint = NSLayoutConstraint(item: self.tableViewSubMenu, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        let trailingSubConstraint = NSLayoutConstraint(item: self.tableViewSubMenu, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        let bottomSubConstraint = NSLayoutConstraint(item: self.tableViewSubMenu, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([topSubConstraint, leadingSubContraint, trailingSubConstraint, bottomSubConstraint])
        
        
        tableViewCarousels.translatesAutoresizingMaskIntoConstraints = false
        tableViewCarousels.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableViewCarousels.separatorStyle = .none
        tableViewCarousels.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        tableViewSubMenu.translatesAutoresizingMaskIntoConstraints = false
        tableViewSubMenu.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableViewSubMenu.separatorStyle = .none
        tableViewSubMenu.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
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
                            self.collectionViewListing.isHidden = false
                            self.collectionViewListing.reloadData()
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
                                self.collectionViewListing.isHidden = true
                                self.tableViewCarousels.reloadData()
                            }else{
                                self.tableViewCarousels.isHidden = true
                                self.collectionViewListing.isHidden = false
                                self.collectionViewListing.reloadData()
                            }
                        })
                        
                    }
                default:
                    print("abc")
                }
            }
        })
    }
    @IBAction func pressMenuBtn(_ sender: Any) {
        if isMenuBtn{
            
        }
        if isBackBtn{
            if isListSubMenuDisplay{
                tableViewCarousels.isHidden = true
                collectionViewListing.isHidden = true
                tableViewSubMenu.isHidden = false
                isListSubMenuDisplay = false
                listItem = 0
                inputTextSearchTf.text = Settings.cityPicked! + " - " + typeMenu
                collectionViewListing.reloadData()
            }else{
                tableViewCarousels.isHidden = false
                collectionViewListing.isHidden = true
                tableViewSubMenu.isHidden = true
                
                inputTextSearchTf.text = Settings.cityPicked!
                menuBtn.setImage(#imageLiteral(resourceName: "search"), for: .normal)
                isMenuBtn = true
                listItem = 0
                listNumSubMenu = 0
                typeOfSubMenu = ""
                typeOfMenu = .None
                listItemOfEachTypeMenu = nil
                collectionViewListing.reloadData()
                tableViewSubMenu.reloadData()
                //tableViewCarousels.reloadData()
            }
        }
    }
    
    func moveUpCarouselsView() {
        if self.carouselsView.frame.origin.y > self.viewMenu.frame.height{
            self.carouselsView.frame.origin.y = self.carouselsView.frame.origin.y - self.heightOfCarouselsView
            self.topContrailOfCarouselsView.constant = -self.heightOfCarouselsView
            self.bottomContrailOfCarouselsView.constant = self.heightOfCarouselsView
            self.view.bringSubview(toFront: self.viewMenu)
            Settings.isScaleMenuView = true
        }
        
    }
    
    func moveDownCarouselsView() {
        if self.carouselsView.frame.origin.y < self.viewMenu.frame.height{
            self.carouselsView.frame.origin.y = self.carouselsView.frame.origin.y + self.heightOfCarouselsView
            self.topContrailOfCarouselsView.constant = 0
            self.bottomContrailOfCarouselsView.constant = 0
            self.view.bringSubview(toFront: self.viewMenu)
            Settings.isScaleMenuView = true
        }
        
    }
    
}




