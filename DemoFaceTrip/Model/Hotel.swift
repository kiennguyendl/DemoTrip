//
//  Hotel.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/5/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class Hotel: NSObject, Mappable {
    var nameHotel: String?
    var place: String?
    var numRoom: Int?
    var numPersonReview: Int?
    var urlImg: String?
    var descriptionHotel: String?
    var price: Double?
    var country: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        nameHotel           <- map["nameHotel"]
        place               <- map["place"]
        country             <- map["country"]
        numRoom             <- map["numRoom"]
        numPersonReview     <- map["numPersonReview"]
        urlImg              <- map["url"]
        descriptionHotel    <- map["description"]
        price               <- map["price"]
    }
}

