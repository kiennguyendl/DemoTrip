//
//  Comment.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/15/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

class Comment: NSObject, Mappable {
    
    var nameguest: String?
    var country: String?
    var timeComment: String?
    var title: String?
    var contentComment: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        nameguest       <- map["nameguest"]
        country         <- map["from"]
        timeComment     <- map["timecomment"]
        title           <- map["title"]
        contentComment  <- map["comment"]
    }
    
    
}
