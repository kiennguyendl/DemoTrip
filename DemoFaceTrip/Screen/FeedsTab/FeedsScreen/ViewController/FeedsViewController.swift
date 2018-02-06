//
//  FeedsViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/22/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit
import ReadMoreTextView

class FeedsViewController: BaseViewController {

    @IBOutlet weak var feedsTableView: UITableView!
    var expandedCells = Set<Int>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupTableView() {
        feedsTableView.delegate = self
        feedsTableView.dataSource = self
        feedsTableView.register(UINib.init(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "friendsCell")
        feedsTableView.register(UINib.init(nibName: "FeedsTableViewCell", bundle: nil), forCellReuseIdentifier: "feedsCell")
        feedsTableView.register(UINib.init(nibName: "SuggestionTableViewCell", bundle: nil), forCellReuseIdentifier: "suggestionCell")
        
        feedsTableView.rowHeight = UITableViewAutomaticDimension
        feedsTableView.estimatedRowHeight = 300
    }

}

extension FeedsViewController: FeedProtocol{
    func createPost(listAsset: [AsssetInfor]) {
        let vc = CreatePostViewController()
        vc.listAsset = listAsset
        navigationController?.pushViewController(vc, animated: true)
    }
}
