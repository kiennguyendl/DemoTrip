//
//  CreatePostViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/30/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var contentPostTableView: UITableView!
    
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayOut()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
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
    func heightOfTextView(height: CGFloat) {
        self.contentPostTableView.beginUpdates()
        self.contentPostTableView.endUpdates()
    }
}
