//
//  FTPickesMenu.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/20/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class FTPickesMenu: NSObject, Mappable {
    var id: Int?
    var type: String?
    var listItem: [ItemMenu] = []
    var typeCategory: typeOfCategoryMenu = .None
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        type        <- map["type"]
        typeCategory = .FTPickes
        var ftPickes: [AnyObject]?
        
        ftPickes         <- map["FTPickes"]
        
        if let _ftPickes = ftPickes{
            for item in _ftPickes{
                let itemMapper = Mapper<ItemMenu>()
                if let item = itemMapper.map(JSONObject: item){
                    listItem.append(item)
                }
            }
            
        }
        
    }
    
    
}
