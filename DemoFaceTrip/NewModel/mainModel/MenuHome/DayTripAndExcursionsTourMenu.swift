//
//  DayTripAndExcursionsTourMenu.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/20/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class DayTripAndExcursionsTourMenu: NSObject, Mappable {
    var id: Int?
    var type: String?
    var listItem: [ItemMenu] = []
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        type        <- map["type"]
        
        var dayTripAndExcursionsTour: [AnyObject]?
        
        dayTripAndExcursionsTour         <- map["DayTripAndExcursionsTour"]
        
        if let _dayTripAndExcursionsTour = dayTripAndExcursionsTour{
            for item in _dayTripAndExcursionsTour{
                let itemMapper = Mapper<ItemMenu>()
                if let item = itemMapper.map(JSONObject: item){
                    listItem.append(item)
                }
            }
        }
        
    }
}
