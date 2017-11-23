//
//  OutDoorActivities.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/16/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class OutDoorActivities: NSObject, Mappable{
    var id: Int?
    var type: String?
    var listSubMenu: [ItemSubMenu] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        type            <- map["type"]
        
        var outDoorActivities: [AnyObject]?
        
        outDoorActivities         <- map["OutDoorActivities"]
        
        if let _outDoorActivities = outDoorActivities{
            for item in _outDoorActivities{
                let itemMapper = Mapper<ItemSubMenu>()
                if let item = itemMapper.map(JSONObject: item){
                    listSubMenu.append(item)
                }
            }
        }
//        if let type = type{
//            switch type{
//            case "Cruises,SaiLing And Water Tour":
//                var cruisesSaiLingAndWaterTour: [String: AnyObject]?
//                cruisesSaiLingAndWaterTour <- map["CruisesSaiLingAndWaterTour"]
//                outDoorActivities = [CruisesSaiLingAndWaterTour]()
//
//                if let _cruisesSaiLingAndWaterTour = cruisesSaiLingAndWaterTour{
//                    for item in _cruisesSaiLingAndWaterTour{
//                        let itemMapper = Mapper<CruisesSaiLingAndWaterTour>()
//                        if let item = itemMapper.map(JSONObject: item){
//                            outDoorActivities?.append(item)
//                        }
//                    }
//                }
//                break
//            case "Walking And Biking Tour":
//                var walkingBikingTour: [String: AnyObject]?
//                walkingBikingTour   <- map["WalkingBikingTour"]
//                outDoorActivities = [WalkingBikingTour]()
//
//                if let _walkingBikingTour = walkingBikingTour{
//                    for item in _walkingBikingTour{
//                        let itemMapper = Mapper<WalkingBikingTour>()
//                        if let item = itemMapper.map(JSONObject: item){
//                            outDoorActivities?.append(item)
//                        }
//                    }
//                }
//                break
//            case "Climbing And Trekking Tour":
//                var climbingAndTrekkingTour: [String: AnyObject]?
//                climbingAndTrekkingTour <- map["ClimbingAndTrekkingTour"]
//                outDoorActivities = [ClimbingAndTrekkingTour]()
//
//                if let _climbingAndTrekkingTour = climbingAndTrekkingTour{
//                    for item in _climbingAndTrekkingTour{
//                        let itemMapper = Mapper<ClimbingAndTrekkingTour>()
//                        if let item = itemMapper.map(JSONObject: item){
//                            outDoorActivities?.append(item)
//                        }
//                    }
//                }
//                break
//            default:
//                print("")
//            }
//        }
    }
    
    
}
