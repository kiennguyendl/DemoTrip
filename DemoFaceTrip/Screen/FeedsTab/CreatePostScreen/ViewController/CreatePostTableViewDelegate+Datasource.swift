//
//  CreatePostTableViewDelegate+Datasource.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/31/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension CreatePostViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let currentRow = indexPath.row
        
//        if currentRow == 0{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TagFriendsCell", for: indexPath) as! TagFriendsTableViewCell
//            
//            return cell
//        }else if currentRow == 1{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TitleTableViewCell
//            
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! ContentTableViewCell
//            
//            return cell
//        }
        
        
        switch currentRow {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TagFriendsCell", for: indexPath) as! TagFriendsTableViewCell

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TitleTableViewCell

            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! ContentTableViewCell
//            cell.contentTextPost.sizeToFit()
            //cell.contentTextPost.text = "What's on your mind?"
            cell.listAsset = listAsset
            cell.isShowingVideo = true
            cell.delgate = self
            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0, 1:
            return 60
        case 2:
            return UITableViewAutomaticDimension
        default:
            return 0
        }
//        let currentRow = indexPath.row
//        if currentRow == 0 || currentRow == 1{
//            return 60
//        }else{
//            return UITableViewAutomaticDimension
//        }
    }
}
