//
//  CreatePostViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/30/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

protocol CreatePostProtocol {
    func cancelCreatePost()
}

class CreatePostViewController: UIViewController {
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var contentPostTableView: UITableView!
    
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    var listAsset: [AsssetInfor] = []
    var delegate: CreatePostProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayOut()
       self.title = "Edit"
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
        initLeftRightButton()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        notificationCenter.removeObserver(self)
    }
    
    func initLeftRightButton() {
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelEditPost))
        navigationItem.leftBarButtonItem = cancelButton
        
        let postButton: UIBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(postNews))
        navigationItem.rightBarButtonItem = postButton
    }
    
    @objc func cancelEditPost() {
        delegate?.cancelCreatePost()
        let data = ["isPlayMusic": false]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyPlaymusicNotificationCreatePost), object: nil, userInfo: data)
        navigationController?.popViewController(animated: true)
    }
    
     @objc func postNews() {
        
    }
    func setupLayOut() {
        parentView.layer.cornerRadius = 10
        parentView.layer.masksToBounds = true
        setupButton()
        setupTableView()
    }

    func setupButton() {
        previewBtn.layer.cornerRadius = 5
        
        postBtn.layer.cornerRadius = 5
    }
    
    deinit {
        print("hihi")
    }
    func setupTableView() {
        contentPostTableView.delegate = self
        contentPostTableView.dataSource = self
        contentPostTableView.register(UINib.init(nibName: "TagFriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "TagFriendsCell")
        
        contentPostTableView.register(UINib.init(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "titleCell")
        
        contentPostTableView.register(UINib.init(nibName: "ContentTableViewCell", bundle: nil), forCellReuseIdentifier: "contentCell")
        
        self.contentPostTableView.estimatedRowHeight = 60
        self.contentPostTableView.rowHeight = UITableViewAutomaticDimension
    }
    
}

extension CreatePostViewController: HeightForTextView{
    func editSlideShow(listAsset: [AsssetInfor]) {
        let vc = EditSlideShowViewController()
        vc.listAsset = listAsset
        vc.delegate = self
//        present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func heightOfTextView(height: CGFloat) {
        self.contentPostTableView.beginUpdates()
        self.contentPostTableView.endUpdates()
    }
}

extension CreatePostViewController: EditSlideShowProtocol{
    func doneEditSlideShow(listAsset: [AsssetInfor]) {
        self.listAsset = []
        self.listAsset = listAsset
        contentPostTableView.reloadData()
    }
}
