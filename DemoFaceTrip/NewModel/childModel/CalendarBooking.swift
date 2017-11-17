//
//  CalendarBooking.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/15/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class CalendarBooking: NSObject, Mappable {
    
    var dayBookings: [Int]?
    var month: Int?
    var year: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        dayBookings     <- map["day"]
        month           <- map["month"]
        year            <- map["year"]
    }
    
    
}
