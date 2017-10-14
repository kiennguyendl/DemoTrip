//
//  TravelAgency.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/11/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class TravelAgency: NSObject, Mappable {
    
    var name: String?
    var image: String?
    var place: String?
    var country: String?
    var descriptionAgency: String?
    var contact: String?
    var numReview: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name                <- map["name"]
        image               <- map["image"]
        place               <- map["place"]
        country             <- map["country"]
        descriptionAgency   <- map["description"]
        contact             <- map["contact"]
        numReview           <- map["numReview"]
    }
    
    
}
