//
//  LocalLife.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/20/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class LocalLife: NSObject, Mappable {
    var id: Int?
    var name: String?
    var listUrlImg: [String]?
    var hightligh: String?
    var descriptionTour: String?
    var price: Int?
    var meetingPoint: String?
    var coordination: Coordination?
    var rating: Float?
    var rateStar: RateStar?
    var favorite: Int?
    var comments: [Comment]?
    var calendarBooking: [CalendarBooking]?
    var numbooking: Int?
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        listUrlImg          <- map["image"]
        hightligh           <- map["hightligh"]
        descriptionTour     <- map["decription"]
        price               <- map["price"]
        meetingPoint        <- map["meetingPoint"]
        coordination        <- map["coordination"]
        rating              <- map["rating"]
        rateStar            <- map["rateStar"]
        favorite            <- map["favorite"]
        comments            <- map["comments"]
        calendarBooking     <- map["calendar"]
        numbooking          <- map["numbooking"]
    }
    
    
}

