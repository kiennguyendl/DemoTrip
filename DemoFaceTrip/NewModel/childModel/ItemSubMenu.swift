//
//  ItemSubMenu.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/22/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class ItemSubMenu: NSObject, Mappable {
    var id: Int?
    var type: String?
    var avatar: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        type        <- map["type"]
        avatar      <- map["avatar"]
    }
    
    
}
