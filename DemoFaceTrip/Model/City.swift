//
//  City.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/10/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class City: NSObject, Mappable {
    
    var name: String?
    var image: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name    <- map["name"]
        image   <- map["image"]
    }

}
