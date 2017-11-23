//
//  ListInforMenu.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/18/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class ListInforMenu: NSObject, Mappable, NSCoding {
    var id: Int?
    var type: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        type    <- map["type"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        id = (aDecoder.decodeObject(forKey: "id") as! Int)
        type = (aDecoder.decodeObject(forKey: "type") as! String)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(type, forKey: "type")
    }
}
