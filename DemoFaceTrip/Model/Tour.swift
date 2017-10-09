//
//  Tour.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/5/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class Tour: NSObject, Mappable {
    
    var tour: String?
    var place: String?
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
        descriptionTour <- map["description"]
        price           <- map["price"]
        numPersonReview <- map["numPersonReview"]
        urlImg          <- map["url"]
    }
}
