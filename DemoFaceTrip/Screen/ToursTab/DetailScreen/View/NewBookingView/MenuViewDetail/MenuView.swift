//
//  MenuView.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 12/13/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class MenuView: BaseView {

    var menu = ["Highligh", "Full Decription", "Availability", "Meeting Point", "Review"]
    @IBOutlet weak var tableViewMenuDetail: UITableView!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var heightOfViewMenu: NSLayoutConstraint!
    
    @IBOutlet weak var bottomOfDismissBtn: NSLayoutConstraint!
    
    var delegate: MenuDetailProtocol?
    var heightView = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        heightView = menu.count * 50
        heightOfViewMenu.constant = CGFloat(heightView)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomOfDismissBtn.constant -= (CGFloat(self.heightView))
        })
        
        tableViewMenuDetail.delegate = self
        tableViewMenuDetail.dataSource = self
        
        
        tableViewMenuDetail.register(UINib.init(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuDetailCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
    }
    
    @IBAction func dismissView(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomOfDismissBtn.constant += (CGFloat(self.heightView))
            self.delegate?.dismissMenuView()
        })
    }
    
}

extension MenuView: UITableViewDelegate, UITableViewDataSource{
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
        delegate?.dismissMenuView()
        delegate?.scrollToItemAtIndexPath(indexPath: IndexPath(row: 0, section: indexPath.row + 2))        
    }
}
