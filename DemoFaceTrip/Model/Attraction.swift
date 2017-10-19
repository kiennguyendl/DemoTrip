//
//  Attraction.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/11/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class Attraction: NSObject, Mappable {
    
    var name: String?
    var image: String?
    var place: String?
    var country: String?
    var descriptionAttraction: String?
    var numReview: Int?
    var highlight: String?
    var openTime: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name                    <- map["name"]
        image                   <- map["image"]
        place                   <- map["place"]
        country                 <- map["place"]
        descriptionAttraction   <- map["description"]
        numReview               <- map["numReview"]
        highlight               <- map["highlight"]
        openTime                <- map["openTime"]
    }
    
}
