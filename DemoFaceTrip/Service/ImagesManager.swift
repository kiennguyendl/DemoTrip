//
//  ImagesManager.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 3/30/18.
//  Copyright © 2018 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ImagesManager: NSObject {
    
    static var shareInstance = ImagesManager()
    
    func groupImgesByDate() {
        
    }
    
    func groupdImagesByLocation(listAsset: [AsssetInfor]) -> [CLLocationCoordinate2D: [AsssetInfor]] {
        var dictImageCreateByLocation = [CLLocationCoordinate2D: [AsssetInfor]]()
        
        for assetInfor in listAsset{
            
            if let key = assetInfor.location{
//                print("location kaka: \(key.coordinate.latitude) + \(key.coordinate.longitude)")
                if dictImageCreateByLocation.count > 0{
                    if dictImageCreateByLocation.keys.contains(key){
                        dictImageCreateByLocation[key]?.append(assetInfor)
                    }else{
                        dictImageCreateByLocation[key] = [AsssetInfor]()
                        dictImageCreateByLocation[key]?.append(assetInfor)
                    }
                }else{
                    dictImageCreateByLocation[key] = [AsssetInfor]()
                    dictImageCreateByLocation[key]?.append(assetInfor)
                }
            }
        }
        
        for (k,v) in (Array(dictImageCreateByLocation).sorted{$0.1[0].createDate! < $1.1[0].createDate!}){
//            print("\(k): \(v)")
        }
        
        return dictImageCreateByLocation
    }
}
