//
//  EventsSubMenu.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/29/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class EventsSubMenu: NSObject, Mappable {
    var id: Int?
    var type: String?
    var listItem: [ItemMenu] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        type        <- map["type"]
        var events: [AnyObject]?
        
        events         <- map["Events"]
        
        if let _events = events{
            for item in  _events{
                let itemMapper = Mapper<ItemMenu>()
                if let item = itemMapper.map(JSONObject: item){
                    listItem.append(item)
                }
            }
            
        }
        
    }
    
}
