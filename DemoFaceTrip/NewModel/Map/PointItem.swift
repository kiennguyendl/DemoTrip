//
//  PointItem.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 2/5/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class PointItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
//    var images: [UIImage] = []
    var listAsset: [AsssetInfor]
    var startPoint = false
    var endPoint = false
    init(position: CLLocationCoordinate2D, listAsset: [AsssetInfor]/*images: [UIImage]*/, startPoint: Bool, endPoint: Bool){
        self.position = position
//        self.images = images
        self.listAsset = listAsset
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
}
