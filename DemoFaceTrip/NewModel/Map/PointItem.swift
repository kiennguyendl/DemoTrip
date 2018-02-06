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
    var images: [UIImage] = []
    
    init(position: CLLocationCoordinate2D, images: [UIImage]){
        self.position = position
        self.images = images
    }
}
