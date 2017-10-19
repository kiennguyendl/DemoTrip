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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initBackButton() {
        //navigationController?.navigationBar.barTintColor = color3
        
        navigationItem.hidesBackButton = true
        let backBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        backBtn.setImage(UIImage(named: "backBtn")?.af_imageAspectScaled(toFit: CGSize(width: 20, height: 30)).withRenderingMode(.alwaysOriginal), for: UIControlState())
        backBtn.imageView?.contentMode = .scaleAspectFit
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
        backBtn.addTarget(self, action: #selector(backToHome(sender:)), for: .touchUpInside)
        let leftNavBarButton = UIBarButtonItem.init(customView: backBtn)
        self.navigationItem.leftBarButtonItems = [leftNavBarButton]
        
    }
    
    @objc func backToHome(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
}


