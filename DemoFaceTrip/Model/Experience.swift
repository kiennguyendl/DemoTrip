//
//  Experience.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/5/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class Experience: NSObject, Mappable {
    
    var experience: String?
    var place: String?
    var country: String?
    var descriptionExp: String?
    var price: Double?
    var numPersonReview: Int?
    var urlImg: String?
    var highlight: String?
    var time: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        experience          <- map["experience"]
        place               <- map["place"]
        country             <- map["country"]
        descriptionExp      <- map["description"]
        price               <- map["price"]
        numPersonReview     <- map["numPersonReview"]
        urlImg              <- map["url"]
        highlight           <- map["highlight"]
        time                <- map["time"]
    }
}
