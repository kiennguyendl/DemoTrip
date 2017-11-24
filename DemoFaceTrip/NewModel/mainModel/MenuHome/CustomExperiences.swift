//
//  CustomExperiences.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/16/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class CustomExperiences: NSObject, Mappable{
    var id: Int?
    var type: String?
    var listSubMenu: [ItemSubMenu] = []
    var typeCategory: typeOfCategoryMenu = .None
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        type            <- map["type"]
        typeCategory = .Experiences
        var customExperiences: [AnyObject]?
        
        customExperiences         <- map["CustomExperiences"]
        
        if let _customExperiences = customExperiences{
            for item in _customExperiences{
                let itemMapper = Mapper<ItemSubMenu>()
                if let item = itemMapper.map(JSONObject: item){
                    listSubMenu.append(item)
                }
            }
        }
//        if let type = type{
//            switch type{
//            case "Nightlife":
//                var nightlife: [String: AnyObject]?
//                nightlife   <- map["Nightlife"]
//                customExperiences = [Nightlife]()
//                
//                if let _nightlife = nightlife{
//                    for item in _nightlife{
//                        let itemMapper = Mapper<Nightlife>()
//                        if let item = itemMapper.map(JSONObject: item){
//                            customExperiences?.append(item)
//                        }
//                    }
//                }
//                break
//            case "Food":
//                var food: [String: AnyObject]?
//                food    <- map["Food"]
//                customExperiences = [Food]()
//                
//                if let _food = food{
//                    for item in _food{
//                        let itemMapper = Mapper<Food>()
//                        if let item = itemMapper.map(JSONObject: item){
//                            customExperiences?.append(item)
//                        }
//                    }
//                }
//                break
//            case "Shopping":
//                var shopping: [String: AnyObject]?
//                shopping    <- map["Shopping"]
//                customExperiences = [Shopping]()
//                
//                if let _shopping = shopping{
//                    for item in _shopping{
//                        let itemMapper = Mapper<Shopping>()
//                        if let item = itemMapper.map(JSONObject: item){
//                            customExperiences?.append(item)
//                        }
//                    }
//                }
//                break
//            case "Local life":
//                var localLife: [String: AnyObject]?
//                localLife   <- map["LocalLife"]
//                customExperiences = [LocalLife]()
//                
//                if let _localLife = localLife{
//                    for item in _localLife{
//                        let itemMapper = Mapper<LocalLife>()
//                        if let item = itemMapper.map(JSONObject: item){
//                            customExperiences?.append(item)
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
