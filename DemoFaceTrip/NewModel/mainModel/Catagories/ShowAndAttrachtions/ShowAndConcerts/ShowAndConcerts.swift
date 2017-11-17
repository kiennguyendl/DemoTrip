//
//  ShowAndConcerts.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/16/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class ShowAndConcerts: NSObject, Mappable {
    
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
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
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
    }
    
    
}

