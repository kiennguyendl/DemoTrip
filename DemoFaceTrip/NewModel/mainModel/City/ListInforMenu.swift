//
//  ListInforMenu.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/18/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class ListInforMenu: NSObject, Mappable, NSCoding {
    var id: Int?
    var type: String?
    //var typeOfMenu: typeOfCategoryMenu = .None
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        type    <- map["type"]
//        if let type = type{
//            switch type{
//            case "Attractions":
//                typeOfMenu = .Attractions
//            case "Activities":
//                typeOfMenu = .Activities
//            case "Experiences":
//                typeOfMenu = .Experiences
//            case "Recentlies":
//                typeOfMenu = .Recentlies
//            case "WishList":
//                typeOfMenu = .WishList
//            case "BestSeller":
//                typeOfMenu = .BestSeller
//            case "FTPickes":
//                typeOfMenu = .FTPickes
//            case "Day trip":
//                typeOfMenu = .Daytrip
//            case "Multi Day Trip":
//                typeOfMenu = .MultiDayTrip
//            default:
//                typeOfMenu = .None
//            }
//        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        id = (aDecoder.decodeObject(forKey: "id") as! Int)
        type = (aDecoder.decodeObject(forKey: "type") as! String)
        //typeOfMenu = (aDecoder.decodeObject(forKey: "typeOfMenu") as! typeOfCategoryMenu)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(type, forKey: "type")
       // aCoder.encode(type, forKey: "typeOfMenu")
    }
}
