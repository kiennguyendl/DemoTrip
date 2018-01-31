//
//  MenuDetailViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/9/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

protocol MenuDetailProtocol {
    func scrollToItemAtIndexPath(indexPath: IndexPath)
    func dismissMenuView()
}

class MenuDetailViewController: BaseViewController {

    @IBOutlet weak var viewBackgroud: UIButton!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var heightOfTableView: NSLayoutConstraint!
    var menu = ["Highligh", "Full Decription", "Availability", "Meeting Point", "Review"]
    @IBOutlet weak var tableViewMenuDetail: UITableView!
    var delegate: MenuDetailProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        if let window = UIApplication.shared.keyWindow {
//            window.windowLevel = UIWindowLevelStatusBar + 1
//        }
//        self.view.window?.windowLevel = UIWindowLevelStatusBar + 1
//        self.view.backgroundColor?.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
        let height = menu.count * 50
        
        heightOfTableView.constant = CGFloat(height)
        tableViewMenuDetail.delegate = self
        tableViewMenuDetail.dataSource = self
        

        tableViewMenuDetail.register(UINib.init(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuDetailCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewBackgroud.backgroundColor = UIColor.black.withAlphaComponent(0)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    } 
    @IBAction func dismissMenuDetailView(_ sender: Any) {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        delegate?.dismissMenuView()
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension MenuDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuDetailCell", for: indexPath) as! MenuTableViewCell
        cell.titleMenu.text = menu[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.scrollToItemAtIndexPath(indexPath: IndexPath(row: 0, section: indexPath.row + 2))
        self.dismiss(animated: true, completion: nil)
    }
}
