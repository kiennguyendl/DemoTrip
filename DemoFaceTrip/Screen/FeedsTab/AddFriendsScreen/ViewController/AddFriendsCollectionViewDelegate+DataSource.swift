//
//  AddFriendsCollectionViewDelegate+DataSource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 4/11/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
extension AddFriendsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listFriedsPicked.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagFriends", for: indexPath) as! TagFriendsCollectionViewCell
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = pickedFriendsCollectionView.frame.height
        
        return CGSize(width: height, height: height)
    }
}

extension AddFriendsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentRow = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "pickFriendCell", for: indexPath) as! PickFriendsTableViewCell
        cell.avatarImgView.layer.cornerRadius = cell.avatarImgView.frame.width / 2
        cell.avatarImgView.layer.masksToBounds = true
        cell.avatarImgView.image = listFriends[currentRow].avartar
        cell.nameFriendLbl.text = listFriends[currentRow].name
        if listFriends[currentRow].picked{
            cell.pickedImageView.image = #imageLiteral(resourceName: "check1")
        }else{
            cell.pickedImageView.image = UIImage()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PickFriendsTableViewCell
        let currentRow = indexPath.row
        if listFriends[currentRow].picked{
            listFriends[currentRow].picked = false
        }else{
            listFriends[currentRow].picked = true
        }
        listFriendsTableView.reloadRows(at: [indexPath], with: .automatic)
        let data = ["friend": listFriends[currentRow]]
        notificationCenter.post(name: NSNotification.Name(rawValue: keyPickFriendsNotification), object: nil, userInfo: data)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
