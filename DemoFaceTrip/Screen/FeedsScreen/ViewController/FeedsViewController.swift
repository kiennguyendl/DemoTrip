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

extension FeedsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell = indexPath.section
        
        if currentCell == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsTableViewCell
            cell.selectionStyle = .none
            return cell
        }else if currentCell == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionCell", for: indexPath) as! SuggestionTableViewCell
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "feedsCell", for: indexPath) as! FeedsTableViewCell
            
            cell.textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
            let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
            readMoreTextView.shouldTrim = !expandedCells.contains(indexPath.section)
            readMoreTextView.setNeedsUpdateTrim()
            readMoreTextView.layoutIfNeeded()
            cell.selectionStyle = .none
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section != 0{
            let readMoreTextView: ReadMoreTextView!
            
            readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView

            readMoreTextView.onSizeChange = { [unowned tableView, unowned self] r in
                let point = tableView.convert(r.bounds.origin, from: r)
                guard let indexPath = tableView.indexPathForRow(at: point) else { return }
                if r.shouldTrim {
                    self.expandedCells.remove(indexPath.section)
                } else {
                    self.expandedCells.insert(indexPath.section)
                }
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentRow = indexPath.section
        if currentRow == 0{
            return self.view.frame.height * 2 / 7.5
        }else{
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        return 7
    }
}

extension FeedsViewController: FeedProtocol{
    func createPost() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
