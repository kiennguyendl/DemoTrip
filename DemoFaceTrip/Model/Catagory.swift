//
//  Catagory.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/5/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

enum catagoryType{
    case hotelType
    case experienceType
    case tourType
    case None
}
class Catagory: NSObject, Mappable {
    var typeCatagory: catagoryType = .None
//    var hotels: [Hotel]?
//    var experiences: [Experience]?
//    var tours: [Tour]?
    var type: String?
    var avatar: String?
    var catagoryItems: [AnyObject]?
    required convenience init?(map: Map) {
        self.init()
//        hotels = []
//        experiences = []
//        tours = []
        //catagoryItems = []
    }
    
    func mapping(map: Map) {
        
        type <- map["type"]
        avatar <- map["avatar"]
        if let strongType = type{
            switch strongType{
            case "Hotel":
                //get hotels
                typeCatagory = .hotelType
                var _hotels: [[String: AnyObject]]?
                _hotels <- map["hotels"]
                self.catagoryItems = [Hotel]()
                if let _hotels = _hotels{
                    for _hotel in _hotels{
                        let mapperItem = Mapper<Hotel>()
                        if let item = mapperItem.map(JSONObject: _hotel){
                            catagoryItems?.append(item)
                        }
                    }
                }
                break
            case "Experience":
                //get experiences
                typeCatagory = .experienceType
                var _experiences: [[String: AnyObject]]?
                _experiences <- map["Experience"]
                self.catagoryItems = [Experience]()
                if let _experiences = _experiences{
                    for _experience in _experiences{
                        let mapperItem = Mapper<Experience>()
                        if let item = mapperItem.map(JSONObject: _experience){
                            catagoryItems?.append(item)
                        }
                    }
                }
                break
            case "Tour":
                //get tours
                typeCatagory = .tourType
                var _tours: [[String: AnyObject]]?
                _tours <- map["tour"]
                self.catagoryItems = [Tour]()
                if let _tours = _tours{
                    for _tour in _tours{
                        let mapperItem = Mapper<Tour>()
                        if let item = mapperItem.map(JSONObject: _tour){
                            catagoryItems?.append(item)
                        }
                    }
                }
                break
            default:
                break
            }
        }
   
    }
    
    
}
