//
//  ShowAndAttrachtions.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/16/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class ShowAndAttrachtions: NSObject, Mappable{
    var id: Int?
    var type: String?
    var avatar: String?
    var showAndAttrachtions: [AnyObject]?
    required convenience init?(map: Map) {
        self.init(map: map)
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        type            <- map["type"]
        avatar          <- map["avatar"]
        if let type = type{
            switch type{
            case "Show And Concerts":
                var showAndConcerts: [String: AnyObject]?
                showAndConcerts     <- map["ShowAndAttrachtions"]
                showAndAttrachtions = [ShowAndConcertsMenu]()
                if let _showAndConcerts = showAndConcerts{
                    for item in _showAndConcerts{
                        let itemMapper = Mapper<ShowAndConcertsMenu>()
                        if let item = itemMapper.map(JSONObject: item){
                            showAndAttrachtions?.append(item)
                        }
                    }
                }
                break
            case "Sightseeing Tickets":
                var sightseeingTickets: [String: AnyObject]?
                sightseeingTickets <- map["SightseeingTickets"]
                showAndAttrachtions = [SightseeingTickets]()
                if let _sightseeingTickets = sightseeingTickets{
                    for item in _sightseeingTickets{
                        let itemMapper = Mapper<SightseeingTickets>()
                        if let item = itemMapper.map(JSONObject: item){
                            showAndAttrachtions?.append(item)
                        }
                    }
                }
                break
            case "Events":
                var events: [String: AnyObject]?
                events  <- map["Events"]
                showAndAttrachtions = [Events]()
                if let _events = events{
                    for event in _events{
                        let itemMapper = Mapper<Events>()
                        if let item = itemMapper.map(JSONObject: event){
                            showAndAttrachtions?.append(item)
                        }
                    }
                }
                break
            case "Passes":
                var passes: [String: AnyObject]?
                passes      <- map["Passes"]
                showAndAttrachtions = [Passes]()
                if let items = passes{
                    for item in items{
                        let itemMapper = Mapper<Passes>()
                        if let item = itemMapper.map(JSONObject: item){
                            showAndAttrachtions?.append(item)
                        }
                    }
                }
                break
            default:
                print("")
            }
        }
    }
    
    
}
