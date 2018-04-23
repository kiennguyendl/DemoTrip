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
    fileprivate static let kCityPicked = "kCityPicked"
    fileprivate static let kListIDMenu = "kListIDMenu"
    fileprivate static let kCity = "kCity"
    
    // check scale menu in home screen
    static var isScaleMenuView: Bool? {
        get{
            return UserDefaults.standard.object(forKey: kScaleHome) as? Bool
        }
        set{
            UserDefaults.standard.set(newValue, forKey: kScaleHome)
            UserDefaults.standard.synchronize()
        }
    }
    
    //save city picked
    static var cityPicked: String?{
        get{
            return UserDefaults.standard.object(forKey: kCityPicked) as? String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: kCityPicked)
            UserDefaults.standard.synchronize()
        }
    }
    
    //list Id get from server
    static var listID: Data?{
        get{
            return UserDefaults.standard.object(forKey: kListIDMenu) as? Data
        }
        set{
            UserDefaults.standard.set(newValue, forKey: kListIDMenu)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var city: Data?{
        get{
            return UserDefaults.standard.object(forKey: kCity) as? Data
        }
        set{
            UserDefaults.standard.set(newValue, forKey: kCity)
            UserDefaults.standard.synchronize()
        }
    }
}
