//
//  TabbarBaseController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class TabbarBaseController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabbarFont()
        self.delegate = self
    }
    
    func setTabbarFont() {
        
    }

}

extension TabbarBaseController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
}
