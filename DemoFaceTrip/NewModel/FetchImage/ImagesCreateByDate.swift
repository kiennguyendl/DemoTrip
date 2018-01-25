//
//  ImagesCreateByDate.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/24/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class ImagesCreateByDate: NSObject{
    var createDate: String?
    var imagesCreateByDate: [AsssetInfor]?
    
    init(createDate: String, imagesCreateByDate: [AsssetInfor]){
        self.createDate = createDate
        self.imagesCreateByDate = imagesCreateByDate
    }
}
