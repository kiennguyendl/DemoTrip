//
//  LocalGuide.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/11/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class LocalGuide: NSObject, Mappable{
    
    var nameGuide: String?
    var avatar: String?
    var place: String?
    var country: String?
    var numLike: Int?
    var contact: String?
    var gender: String?
    var price: Int?
    var language: String?
    var groupSize: String?
    var descriptionGuide: String?
    var aboutTour: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        nameGuide           <- map["nameGuide"]
        avatar              <- map["avatar"]
        place               <- map["place"]
        country             <- map["country"]
        numLike             <- map["numLike"]
        contact             <- map["contact"]
        gender              <- map["gender"]
        price               <- map["price"]
        language            <- map["languages"]
        groupSize           <- map["groupSize"]
        descriptionGuide    <- map["description"]
        aboutTour           <- map["aboutTour"]
    }
    
    
}
