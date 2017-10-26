//
//  Setting.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/26/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class Settings{
    
    fileprivate static let kScaleHome = "ScaleHome"
    
    static var isScaleMenuView: Bool? {
        get{
            return UserDefaults.standard.object(forKey: kScaleHome) as? Bool
        }
        set{
            UserDefaults.standard.set(newValue, forKey: kScaleHome)
            UserDefaults.standard.synchronize()
        }
    }
}
