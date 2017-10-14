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
    case localGuideType
    case travelAgencyType
    case attractionType
    case themParkType
    case foodTourType
    case cityTourType
    case None
}
class Catagory: NSObject, Mappable {
    var typeCatagory: catagoryType = .None
    var type: String?
    var avatar: String?
    var catagoryItems: [AnyObject]?
    
    required convenience init?(map: Map) {
        self.init()
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
                _experiences <- map["experience"]
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
            case "City Tour":
                //get city tours
                typeCatagory = .cityTourType
                var _cityTours: [[String: AnyObject]]?
                _cityTours <- map["cityTour"]
                self.catagoryItems = [CityTour]()
                if let _tours = _cityTours{
                    for _tour in _tours{
                        let mapperItem = Mapper<CityTour>()
                        if let item = mapperItem.map(JSONObject: _tour){
                            catagoryItems?.append(item)
                        }
                    }
                }
                break
            case "Food Tour":
                //get food tours
                typeCatagory = .foodTourType
                var _foodTours: [[String: AnyObject]]?
                _foodTours <- map["foodTour"]
                self.catagoryItems = [FoodTour]()
                if let _tours = _foodTours{
                    for _tour in _tours{
                        let mapperItem = Mapper<FoodTour>()
                        if let item = mapperItem.map(JSONObject: _tour){
                            catagoryItems?.append(item)
                        }
                    }
                }
                break
            case "Theme Parks":
                //get theme parks
                typeCatagory = .themParkType
                var _themeParks : [[String: AnyObject]]?
                _themeParks <- map["themeParks"]
                self.catagoryItems = [ThemeParks]()
                if let _themeParks = _themeParks{
                    for _themePark in _themeParks{
                        let mapperItem = Mapper<ThemeParks>()
                        if let item = mapperItem.map(JSONObject: _themePark){
                            catagoryItems?.append(item)
                        }
                    }
                }
                break
            case "Attraction":
                
                // get attractions
                typeCatagory = .attractionType
                var _attractions : [[String: AnyObject]]?
                _attractions <- map["attraction"]
                self.catagoryItems = [Attraction]()
                if let _attractions = _attractions{
                    for _attraction in _attractions{
                        let mapperItem = Mapper<Attraction>()
                        if let item = mapperItem.map(JSONObject: _attraction){
                            catagoryItems?.append(item)
                        }
                    }
                }
                break
            case "Travel Agency":
                typeCatagory = .travelAgencyType
                var _travelAgencys: [[String: AnyObject]]?
                _travelAgencys <- map["travelAgency"]
                self.catagoryItems = [TravelAgency]()
                if let _travelAgencys = _travelAgencys{
                    for _travelAgency in _travelAgencys{
                        let mapperItem = Mapper<TravelAgency>()
                        if let item = mapperItem.map(JSONObject: _travelAgency){
                            catagoryItems?.append(item)
                        }
                    }
                }
                break
            case "Local Guide":
                typeCatagory = .localGuideType
                var _localGuides: [[String: AnyObject]]?
                _localGuides <- map["localGuide"]
                self.catagoryItems = [LocalGuide]()
                if let _localGuides = _localGuides{
                    for _localGuide in _localGuides{
                        let mapperItem = Mapper<LocalGuide>()
                        if let item = mapperItem.map(JSONObject: _localGuide){
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
