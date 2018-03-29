//
//  CoverViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/22/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class CoverViewController: BaseViewController {

    @IBOutlet weak var viewPickTag: UIView!
    @IBOutlet weak var imageViewPickTag: UIImageView!
    @IBOutlet weak var pickATagLbl: UILabel!
    @IBOutlet weak var detailMomentLbl: UILabel!
    @IBOutlet weak var editTitleLbl: UILabel!
    @IBOutlet weak var tagFriendBtn: UIButton!
    @IBOutlet weak var listTagFriendCollectionView: UICollectionView!
    @IBOutlet weak var showKeyBoardBtn: UIButton!
    @IBOutlet weak var editCoverBtn: UIButton!
//    @IBOutlet weak var pickATagBtn: UIButton!
    @IBOutlet weak var viewTagFriends: UIView!
    
    var listAsset: [AsssetInfor] = []
    @IBOutlet weak var distanceOfShowKeyBoardToBottom: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLayout()
        setUpCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
        
        // set none color for navigation bar
        setNoneColorForNavigation()
        initLeftRightButton()
        self.title = "Edit Memories"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        tabBarController?.tabBar.isHidden = false
//        navigationController?.isNavigationBarHidden = true
    }

    func setNoneColorForNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        //        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setDefaultColorForNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func initLeftRightButton() {
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelEditPost))
        navigationItem.leftBarButtonItem = cancelButton
        
        let postButton: UIBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextStep))
        navigationItem.rightBarButtonItem = postButton
    }
    
    @objc func cancelEditPost() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextStep() {
        
    }
    
    func setUpLayout() {
        
        // setup edit title label
        let attributedString = NSMutableAttributedString(string: "Enter Type Title  Image Here  ")
        let editAttachment = NSTextAttachment()
        let image = UIImage(named: "edit1")!.withRenderingMode(.alwaysTemplate)
        
        editAttachment.image = image
        
        editAttachment.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        attributedString.append(NSAttributedString(attachment: editAttachment))
        
        editTitleLbl.attributedText = attributedString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(editTitle))
        editTitleLbl.isUserInteractionEnabled = true
        editTitleLbl.addGestureRecognizer(tap)
        
        let tapPickATag = UITapGestureRecognizer(target: self, action: #selector(showPickATagScreen))
        pickATagLbl.isUserInteractionEnabled = true
        pickATagLbl.addGestureRecognizer(tapPickATag)
        //set up tag friends button
        let imageAddBtn = UIImage(named: "add")?.withRenderingMode(.alwaysTemplate)
        tagFriendBtn.setImage(imageAddBtn, for: .normal)
        tagFriendBtn.tintColor = .white
        
        let viewBorder = CAShapeLayer()
        viewBorder.path = UIBezierPath(roundedRect: tagFriendBtn.frame, cornerRadius: tagFriendBtn.frame.width / 2).cgPath
        viewBorder.strokeColor = UIColor.white.cgColor
        viewBorder.lineDashPattern = [1, 3]
        
        viewBorder.frame = tagFriendBtn.frame
        viewBorder.fillColor = UIColor.clear.cgColor
        viewBorder.backgroundColor = UIColor.clear.cgColor
        tagFriendBtn.layer.addSublayer(viewBorder)
        
        let imageShowKeyBoard = UIImage(named: "uparrow")?.withRenderingMode(.alwaysTemplate)
        showKeyBoardBtn.setImage(imageShowKeyBoard, for: .normal)
        showKeyBoardBtn.tintColor = .white
        
        UIView.animate(withDuration: 0.5, delay: 0.0 ,options: [.repeat, .autoreverse], animations: {
            self.distanceOfShowKeyBoardToBottom.constant = 40
//            self.showKeyBoardBtn.frame = CGRect(x: self.showKeyBoardBtn.frame.maxX + 10, y: self.showKeyBoardBtn.frame.maxY, width: self.showKeyBoardBtn.frame.width, height: self.showKeyBoardBtn.frame.height)
        }, completion:{ finished in
            self.distanceOfShowKeyBoardToBottom.constant = 30
//            self.showKeyBoardBtn.frame = CGRect(x: self.showKeyBoardBtn.frame.maxX - 10, y: self.showKeyBoardBtn.frame.maxY, width: self.showKeyBoardBtn.frame.width, height: self.showKeyBoardBtn.frame.height)
        })
    }
    
    @objc func editTitle() {
        print("edit title")
    }
    
    @objc func showPickATagScreen(){
        let vc = PickATagViewController()
        present(vc, animated: true, completion: nil)
    }
    
    func setUpCollectionView() {
        listTagFriendCollectionView.delegate = self
        listTagFriendCollectionView.dataSource = self
        listTagFriendCollectionView.register(UINib.init(nibName: "TagFriendsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tagFriends")
    }
    
    @IBAction func drawLineOnMap(_ sender: Any) {
        let vc = DrawLineOnMapViewController()
        vc.listAsset = listAsset
        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true, completion: nil)
    }
    
}

extension CoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagFriends", for: indexPath) as! TagFriendsCollectionViewCell
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = height
        return CGSize(width: width, height: height)
    }
}
