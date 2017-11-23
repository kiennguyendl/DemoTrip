//
//  City.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/10/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class City: NSObject, Mappable, NSCoding {
    
    var id: Int?
    var listID: [ListInforMenu]?
    var name: String?
    var image: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
        image   <- map["image"]
        listID  <- map["listMenuID"]
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        id = (aDecoder.decodeObject(forKey: "id") as! Int)
        name = (aDecoder.decodeObject(forKey: "name") as! String)
        image = (aDecoder.decodeObject(forKey: "image") as! String)
        listID = (aDecoder.decodeObject(forKey: "listID") as! [ListInforMenu])
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(listID, forKey: "listID")
    }

}
