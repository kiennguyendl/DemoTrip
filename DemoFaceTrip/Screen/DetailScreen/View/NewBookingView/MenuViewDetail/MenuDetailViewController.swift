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
}

class MenuDetailViewController: UIViewController {

    var menu = ["Highligh", "Full Decription", "Availability", "Meeting Point", "Review"]
    @IBOutlet weak var tableViewMenuDetail: UITableView!
    var delegate: MenuDetailProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableViewMenuDetail.delegate = self
        tableViewMenuDetail.dataSource = self
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        tableViewMenuDetail.register(UINib.init(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuDetailCell")
    }


    @IBAction func dismissMenuDetailView(_ sender: Any) {
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
        return self.tableViewMenuDetail.frame.height / CGFloat(menu.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.scrollToItemAtIndexPath(indexPath: IndexPath(row: 0, section: indexPath.row + 2))
        self.dismiss(animated: true, completion: nil)
    }
}
