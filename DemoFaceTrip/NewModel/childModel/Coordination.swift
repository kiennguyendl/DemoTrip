//
//  Coordination.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/15/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class Coordination: NSObject, Mappable {
    
    var latitude: Double?
    var longtitue: Double?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        latitude    <- map["latitude"]
        longtitue   <- map["longtitue"]
    }
    
    
    
}
