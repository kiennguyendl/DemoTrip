//
//  CityTour.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/11/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class CityTour: NSObject, Mappable {
    
    var tour: String?
    var place: String?
    var country: String?
    var descriptionTour: String?
    var price: Double?
    var numPersonReview: Int?
    var urlImg: String?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        tour            <- map["tour"]
        place           <- map["place"]
        country         <- map["country"]
        descriptionTour <- map["description"]
        price           <- map["price"]
        numPersonReview <- map["numPersonReview"]
        urlImg          <- map["url"]
    }
}
