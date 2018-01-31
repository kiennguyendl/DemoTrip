//
//  TagFriendsTableViewCell.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/31/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import UIKit

class TagFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var listTagFriendsCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    func setupCollectionView() {
        listTagFriendsCollectionView.delegate = self
        listTagFriendsCollectionView.dataSource = self
        listTagFriendsCollectionView.register(UINib.init(nibName: "FriendCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "friendColletionCell")
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addFriends(_ sender: Any) {
    }
}


extension TagFriendsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendColletionCell", for: indexPath) as! FriendCollectionViewCell
            cell.avatar.layer.cornerRadius = cell.frame.width / 2
        cell.avatar.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.frame.height
        return CGSize(width: height / 2, height: height)
    }
}
