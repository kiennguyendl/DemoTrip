//
//  RateStar.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/15/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class RateStar: NSObject, Mappable {
    
    var fiveStar: Int?
    var fourStar: Int?
    var threeStar: Int?
    var twoStar: Int?
    var oneStar: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        fiveStar        <- map["fiveStar"]
        fourStar        <- map["fourStar"]
        threeStar       <- map["threeStar"]
        twoStar         <- map["twoStar"]
        oneStar         <- map["oneStar"]
    }
    
    
}
