//
//  WishListMenu.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/20/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class WishListMenu: NSObject, Mappable {
    var id: Int?
    var type: String?
    var listItem: [ItemMenu] = []
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        type        <- map["type"]
        
        var wishList: [AnyObject]?
        
        wishList         <- map["WishList"]
        
        if let _wishList = wishList{
            for item in _wishList{
                let itemMapper = Mapper<ItemMenu>()
                if let item = itemMapper.map(JSONObject: item){
                    listItem.append(item)
                }
            }
        }
        
    }
}
