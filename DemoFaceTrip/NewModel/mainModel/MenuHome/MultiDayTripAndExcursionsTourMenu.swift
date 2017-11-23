//
//  MultiDayTripAndExcursionsTourMenu.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/20/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class MultiDayTripAndExcursionsTourMenu: NSObject, Mappable {
    var id: Int?
    var type: String?
    var listItem: [ItemMenu] = []
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        type        <- map["type"]
        
        var multiDayTripAndExcursionsTour: [AnyObject]?
        
        multiDayTripAndExcursionsTour         <- map["MultiDayTripAndExcursionsTour"]
        
        if let _multiDayTripAndExcursionsTour = multiDayTripAndExcursionsTour{
            for item in _multiDayTripAndExcursionsTour{
                let itemMapper = Mapper<ItemMenu>()
                if let item = itemMapper.map(JSONObject: item){
                    listItem.append(item)
                }
            }
        }
        
    }
}
