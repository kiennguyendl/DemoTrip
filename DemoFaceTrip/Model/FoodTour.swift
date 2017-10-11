//
//  FoodTour.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/11/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class FoodTour: NSObject, Mappable {
    
    var name: String?
    var place: String?
    var country: String?
    var image: String?
    var price: Int?
    var highlight: String?
    var descriptionTour: String?
    var numReview: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name                    <- map["name"]
        place                   <- map["place"]
        country                 <- map["country"]
        image                   <- map["image"]
        price                   <- map["price"]
        highlight               <- map["highlight"]
        descriptionTour         <- map["description"]
        numReview               <- map["numReview"]
    }
    
    
}
