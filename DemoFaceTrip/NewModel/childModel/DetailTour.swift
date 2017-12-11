//
//  DetailTour.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 12/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class DetailTour: NSObject, Mappable {
    
    var id: Int?
    var nameTour: String?
    var images: [String]?
    var highlight: String?
    var descriptionTour: String?
    var price: Double?
    var meetingPoint: String?
    var coordination: Coordination?
    var rating: Float?
    var rateStar: RateStar?
    var favorite: Int?
    var numbooking: Int?
    var comments: [Comment]?
    var calendarTour: [CalendarBooking]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        nameTour            <- map["name"]
        images              <- map["image"]
        highlight           <- map["hightligh"]
        descriptionTour     <- map["decription"]
        price               <- map["price"]
        meetingPoint        <- map["meetingPoint"]
        coordination        <- map["coordination"]
        rating              <- map["rating"]
        rateStar            <- map["rateStar"]
        favorite            <- map["favorite"]
        numbooking          <- map["numbooking"]
        comments            <- map["comments"]
        calendarTour        <- map["calendar"]
    }
    
    
}
