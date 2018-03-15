//
//  AsssetInfor.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 1/24/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import Photos
import CoreLocation
import UIKit
class AsssetInfor: NSObject {
    
    var location: CLLocation?
    var createDate: Date?
    var asset: PHAsset?
    var isPicked = false
    
    init(location: CLLocation?, createDate: Date, asset: PHAsset, isPicked: Bool) {
        self.location = location
        self.createDate = createDate
        self.asset = asset
        self.isPicked = isPicked
    }
}

