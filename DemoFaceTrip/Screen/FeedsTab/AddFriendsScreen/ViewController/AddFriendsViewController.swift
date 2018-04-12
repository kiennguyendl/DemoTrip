//
//  AddFriendsViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 4/11/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class Friend: NSObject {
    var id: Int!
    var avartar: UIImage!
    var name: String!
    var picked = false
    
    init(id: Int, avartar: UIImage, name: String) {
        self.id = id
        self.avartar = avartar
        self.name = name
    }
}

protocol TagFriendsProtocol {
    func showListTagFriend(listFriendTagged: [Friend])
}

class AddFriendsViewController: BaseViewController {
    @IBOutlet weak var searchFriendsTf: UITextField!
    
    @IBOutlet weak var numberFriendsLbl: UILabel!
    @IBOutlet weak var sellectOrUnSellectBtn: UIButton!
    @IBOutlet weak var pickedFriendsCollectionView: UICollectionView!
    
    @IBOutlet weak var listFriendsTableView: UITableView!
    
    let listFriends = [Friend(id: 1, avartar: #imageLiteral(resourceName: "avatar.jpg"), name: "friend1"),
                       Friend(id: 2, avartar: #imageLiteral(resourceName: "avatar.jpg"), name: "friend2"),
                       Friend(id: 3, avartar: #imageLiteral(resourceName: "avatar.jpg"), name: "friend3"),
                       Friend(id: 4, avartar: #imageLiteral(resourceName: "avatar.jpg"), name: "friend4"),
                       Friend(id: 5, avartar: #imageLiteral(resourceName: "avatar.jpg"), name: "friend5"),
                       Friend(id: 6, avartar: #imageLiteral(resourceName: "avatar.jpg"), name: "friend6"),
                       Friend(id: 7, avartar: #imageLiteral(resourceName: "avatar.jpg"), name: "friend7"),
                       Friend(id: 8, avartar: #imageLiteral(resourceName: "avatar.jpg"), name: "friend8"),
                       Friend(id: 9, avartar: #imageLiteral(resourceName: "avatar.jpg"), name: "friend9"),
                       Friend(id: 10, avartar: #imageLiteral(resourceName: "avatar.jpg"), name: "friend10"),
                       Friend(id: 11, avartar: #imageLiteral(resourceName: "avatar.jpg"), name: "friend11"),
                        ]
    var numFriends = 1
    var listFriedsPicked: [Friend] = []
    
    var delegate: TagFriendsProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        addObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        initLeftRightButton(titleLeft: "Back", titleRight: "Done")
        self.title = "List Members"
    }
    
    func setupLayout() {
        
        pickedFriendsCollectionView.delegate = self
        pickedFriendsCollectionView.dataSource = self
        pickedFriendsCollectionView.register(UINib.init(nibName: "TagFriendsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tagFriends")
        
        listFriendsTableView.delegate = self
        listFriendsTableView.dataSource = self
        listFriendsTableView.register(UINib.init(nibName: "PickFriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "pickFriendCell")
    }
    
    func addObserver() {
        notificationCenter.addObserver(self, selector: #selector(pickFriend(_:)), name: NSNotification.Name(rawValue: keyPickFriendsNotification), object: nil)
    }
    
    @objc func pickFriend(_ notification: NSNotification){
        if let friend = notification.userInfo!["friend"] as? Friend{
            if listFriedsPicked.count == 0{
                listFriedsPicked.append(friend)
                pickedFriendsCollectionView.reloadData()
            }else{
                if listFriedsPicked.contains(friend){
                    for index in 0..<listFriedsPicked.count{
                        if listFriedsPicked[index].id == friend.id{
                            listFriedsPicked.remove(at: index)
                            pickedFriendsCollectionView.reloadData()
                            break
                        }
                    }
                }else{
                    listFriedsPicked.append(friend)
                    pickedFriendsCollectionView.reloadData()
                }
//                for index in 0..<listFriedsPicked.count{
//                    if listFriedsPicked[index].id == friend.id{
//                        listFriedsPicked.remove(at: index)
//                        pickedFriendsCollectionView.reloadData()
//                        break
//                    }
//                }
            }
        }
        
    }
    override func leftButton() {
        navigationController?.popViewController(animated: true)
    }
    
    override func rightButton() {
        delegate?.showListTagFriend(listFriendTagged: listFriedsPicked)
        navigationController?.popViewController(animated: true)
    }

}
