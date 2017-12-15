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
    
    @IBOutlet weak var tableViewSubMenu: UITableView!
    @IBOutlet weak var tableViewCarousels: UITableView!
    @IBOutlet weak var bottomViewLineMenu: UIView!
    @IBOutlet weak var heightOfViewBottomLineMenu: NSLayoutConstraint! 
    @IBOutlet weak var collectionViewCarousels: UICollectionView!
    @IBOutlet weak var collectionViewListing: UICollectionView!
    
    @IBOutlet weak var carouselsView: UIView!
    @IBOutlet weak var topContrailOfCarouselsView: NSLayoutConstraint!
    @IBOutlet weak var bottomContrailOfCarouselsView: NSLayoutConstraint!
    @IBOutlet weak var heightOfViewMenu: NSLayoutConstraint!
    
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var allDatesBtn: UIButton!
    @IBOutlet weak var numGuesBtn: UIButton!
    @IBOutlet weak var filtersBtn: UIButton!
    
    var heightOfCarouselsView: CGFloat = 0
    
    //@IBOutlet weak var categoryMenuView: UIView!
//    var tableViewCarousels: UITableView!
//    var tableViewSubMenu: UITableView!
    var viewForHeaderZero: HeaderZeroView!
    var previousOffset: CGFloat = 0

    var indexPathSelected: IndexPath = IndexPath(item: 0, section: 0)
    static var verticalContentOffset: CGFloat!
    
    //set color for menu view
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
    var listCarousel = ["For Your", "Experiences", "At a Glance", "Trip Daiary"]
    
    //the value for listing collection view
    var listItemOfEachTypeMenu: AnyObject!
    var listItemOfEachSubMenu: AnyObject!
    var typeOfMenu: typeOfCategoryMenu = .None
    var typeOfSubMenu = ""
    var typeMenu = ""
    var listItem = 0
    var listNumSubMenu = 0
    //
    
    // using for animation
    let imageExpandAnimationController = ImageExpandAnimationController()
    let imageShrinkAnimationController = ImageShrinkAnimationController()
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayer()
        
        
        
    }
    
    func setupLayer() {
        //setNonColorForStatusBar()
        //        setRedColorForStatusBar()
        collectionViewListing.isHidden = true
        self.heightOfViewBottomLineMenu.constant = 0
        initCollectionView()
        initTableView()
        //carouselsView.backgroundColor = color3
        viewForHeaderZero  = HeaderZeroView()
        
        //set color for menu view
        setColorForMenuView()
        
        filterView.isHidden = true
        
        setupButtonOnFilterView()
        
        //addSwipeForController()
        
        heightOfCarouselsView = carouselsView.frame.height
        newPos = self.viewMenu.frame.height - (collectionViewCarousels.frame.height + 15)
        
        //add target for textfield when user touch up
        inputTextSearchTf.addTarget(self, action: #selector(presentChooseCityView(textField:)), for: .touchDown)
        inputTextSearchTf.delegate = self
        //check city is existing or not
        if Settings.city == nil{
            let vc = ChooseCityViewController()
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }else{
            inputTextSearchTf.text = Settings.cityPicked
            city = NSKeyedUnarchiver.unarchiveObject(with: Settings.city!) as! City
            listID = city.listID!
            tableViewCarousels.reloadData()
        }
    }
    
    //present view for user choose city
    @objc func presentChooseCityView(textField: UITextField) {
        let vc = ChooseCityViewController()
        self.view.endEditing(true)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //set hide navigationbar
//        setRedColorForStatusBar()
        navigationController?.isNavigationBarHidden = true
        //setNonColorForStatusBar()
        //show tabbar controller
        tabBarController?.tabBar.isHidden = false
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //setWhiteColorForStatusBar()
        //navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //set frame for gradient layer of menu view
        //gradientLayer.frame = self.viewMenu.bounds
        
    }
    
    /// init and register cell for collection view
    func initCollectionView() {
        collectionViewCarousels.delegate = self
        collectionViewCarousels.dataSource = self
        collectionViewCarousels.register(UINib.init(nibName: "CarouselsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarouselCell")
        //collectionViewCarousels.backgroundColor = color3
        collectionViewCarousels.showsHorizontalScrollIndicator = false

        collectionViewListing.delegate = self
        collectionViewListing.dataSource = self
        collectionViewListing.register(UINib.init(nibName: "NewHomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewHomeCollectionCell")
        collectionViewListing.register(UINib.init(nibName: "HeaderForListingCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderViewForListing")
        collectionViewListing.showsVerticalScrollIndicator = false
        collectionViewListing.tag = 1
    }
    
    func showSubMenu() {
        childViewMenu.isHidden = false
        menuBtn.isHidden = false
        searchBtn.isHidden = false
        inputTextSearchTf.isHidden = false
        setColorForMenuView()
        self.childViewMenu.layer.shadowOpacity = 1
        self.heightOfViewBottomLineMenu.constant = 0
    }
    
    func hidenSubMenu() {
        childViewMenu.isHidden = true
        menuBtn.isHidden = true
        searchBtn.isHidden = true
        inputTextSearchTf.isHidden = true
        self.childViewMenu.layer.shadowOpacity = 0
        self.heightOfViewBottomLineMenu.constant = 1
        
    }
    
    func setNonColorForStatusBar(){
        statusBar.backgroundColor = .clear
        statusBar.tintColor = .white
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    func setColorForMenuView() {
//        if Settings.isScaleMenuView!{
//            print("abc")
//        }else{
            //self.viewMenu.layer.insertSublayer(gradientLayer, below: self.childViewMenu.layer)
            //gradientLayer.frame = self.viewMenu.bounds
//            self.childViewMenu.dropShadow(color: UIColor(red: 152.0/255.0, green: 91.0/255.0, blue: 86.0/255.0, alpha: 1.0), opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 5, scale: true)
        
        self.childViewMenu.layer.shadowColor = UIColor.black.cgColor
        self.childViewMenu.layer.shadowOpacity = 0.5
        self.childViewMenu.layer.shadowOffset = CGSize.zero
        self.childViewMenu.layer.shadowRadius = 5
            self.childViewMenu.layer.cornerRadius = self.childViewMenu.frame.width / 97
//        }
    }
    
    //init and register cell for tableview
    func initTableView() {
        
        tableViewCarousels.delegate = self
        tableViewCarousels.dataSource = self
        tableViewCarousels.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        tableViewCarousels.showsHorizontalScrollIndicator = false
        tableViewCarousels.showsVerticalScrollIndicator = false
        tableViewCarousels.isHidden = false
        tableViewCarousels.tag = 2
        collectionViewListing.superview?.bringSubview(toFront: tableViewCarousels)
        tableViewCarousels.backgroundColor = UIColor.white
        tableViewCarousels.translatesAutoresizingMaskIntoConstraints = false
        tableViewCarousels.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableViewCarousels.separatorStyle = .none
        tableViewCarousels.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        tableViewSubMenu.delegate = self
        tableViewSubMenu.dataSource = self
        tableViewSubMenu.register(UINib.init(nibName: "SubMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SubMenuCell")
        tableViewSubMenu.showsHorizontalScrollIndicator = false
        tableViewSubMenu.showsVerticalScrollIndicator = false
        tableViewSubMenu.isHidden = true
        tableViewSubMenu.tag = 2
        //collectionViewListing.superview?.bringSubview(toFront: tableViewCarousels)
        tableViewSubMenu.backgroundColor = UIColor.white
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
                filterView.isHidden = true
                collectionViewCarousels.isHidden = false
//                filterView.isHidden = false
//                collectionViewCarousels.isHidden = true
                isListSubMenuDisplay = false
                listItem = 0
                inputTextSearchTf.text = Settings.cityPicked! + " - " + typeMenu
                inputTextSearchTf.textAlignment = .left
                collectionViewListing.reloadData()
            }else{
                tableViewCarousels.isHidden = false
                collectionViewListing.isHidden = true
                tableViewSubMenu.isHidden = true
                filterView.isHidden = true
                collectionViewCarousels.isHidden = false
                
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
            }
        }
    }
    
    // action when scroll up tableview or collectionview
    func moveUpCarouselsView() {
        if self.carouselsView.frame.origin.y == self.viewMenu.frame.height{
            //self.carouselsView.frame.origin.y -= self.heightOfCarouselsView
            self.topContrailOfCarouselsView.constant = -(self.heightOfCarouselsView)
            self.bottomContrailOfCarouselsView.constant -= self.heightOfCarouselsView
            self.view.bringSubview(toFront: self.viewMenu)
            Settings.isScaleMenuView = true
        }
        
    }
    
    // action when scroll down tableview or collectionview
    func moveDownCarouselsView() {
        if self.carouselsView.frame.origin.y < self.viewMenu.frame.height{
            self.carouselsView.frame.origin.y = self.carouselsView.frame.origin.y + self.heightOfCarouselsView
            self.topContrailOfCarouselsView.constant = 0
            self.bottomContrailOfCarouselsView.constant = 0
            self.view.bringSubview(toFront: self.viewMenu)
            Settings.isScaleMenuView = false
        }
        
    }
    
    // above funtionalies using when present detail viewcontroller from home csreen
    func changeColorMenuViewWhenPresent() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.gradientLayer.removeFromSuperlayer()
                
                self.collectionViewCarousels.isHidden = true
                self.childViewMenu.isHidden = true
               
            })
            self.carouselsView.backgroundColor = UIColor.white
        }
        
    }
    
    func setColorMenuViewWhenDismiss() {
        self.setColorForMenuView()
        self.collectionViewCarousels.isHidden = false
        self.carouselsView.backgroundColor = color3
        self.childViewMenu.isHidden = false
    }
    
    func setupButtonOnFilterView() {
        allDatesBtn.layer.borderWidth = 0.5
        allDatesBtn.layer.borderColor = UIColor.gray.cgColor
        allDatesBtn.layer.cornerRadius = allDatesBtn.frame.width / 30
        
        numGuesBtn.layer.borderWidth = 0.5
        numGuesBtn.layer.borderColor = UIColor.gray.cgColor
        numGuesBtn.layer.cornerRadius = allDatesBtn.frame.width / 30
        
        filtersBtn.layer.borderWidth = 0.5
        filtersBtn.layer.borderColor = UIColor.gray.cgColor
        filtersBtn.layer.cornerRadius = allDatesBtn.frame.width / 30
        
//        self.viewContents.backgroundColor = UIColor.clear
//        self.viewContents.layer.borderWidth = 0.20
//        self.viewContents.layer.borderColor = UIColor.lightGray.cgColor
//        self.viewContents.layer.cornerRadius = self.frame.width / 60
    }
}




