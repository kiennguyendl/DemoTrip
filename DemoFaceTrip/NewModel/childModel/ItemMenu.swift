//
//  ItemMenu.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/22/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class ItemMenu: NSObject, Mappable {
    var id: Int?
    var name: String?
    var imageURL: String?
    var price: Int?
    var rating: Float?
    var favorite: Int?
    var numBooking: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        imageURL    <- map["image"]
        price       <- map["price"]
        rating      <- map["rating"]
        favorite    <- map["favorite"]
        numBooking  <- map["numbooking"]
    }
    
    
}
