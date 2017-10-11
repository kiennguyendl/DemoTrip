//
//  BaseViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    //var tabbar: TabbarBaseController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabbar?.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
}

//extension BaseViewController: UITabBarControllerDelegate, UITabBarDelegate{
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("kien test")
//    }
//
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("kien test")
//    }
//}

