//
//  ShowAndConcertsSubMenu.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/29/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class ShowAndConcertsSubMenu: NSObject, Mappable {
    var id: Int?
    var type: String?
    var listItem: [ItemMenu] = []
    //var typeCategory: typeOfCategoryMenu = .None
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        type        <- map["type"]
        //typeCategory = .FTPickes
        var showAndConcerts: [AnyObject]?
        
        showAndConcerts         <- map["ShowAndConcerts"]
        
        if let _showAndConcerts = showAndConcerts{
            for item in  _showAndConcerts{
                let itemMapper = Mapper<ItemMenu>()
                if let item = itemMapper.map(JSONObject: item){
                    listItem.append(item)
                }
            }
            
        }
        
    }
 
}
