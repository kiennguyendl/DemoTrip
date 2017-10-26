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
    //static var isScaleMenuView = false
    var statusBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBar  = UIApplication.shared.value(forKey: "statusBar") as! UIView
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initBackButton() {
        //navigationController?.navigationBar.barTintColor = color3
        
        navigationItem.hidesBackButton = true
        let backBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backBtn.setImage(UIImage(named: "backBtn")?.af_imageAspectScaled(toFit: CGSize(width: 15, height: 20)).withRenderingMode(.alwaysOriginal), for: UIControlState())
        backBtn.imageView?.contentMode = .scaleAspectFit
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
        backBtn.addTarget(self, action: #selector(backToHome(sender:)), for: .touchUpInside)
        let leftNavBarButton = UIBarButtonItem.init(customView: backBtn)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
    }
    
    @objc func backToHome(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func addShareButton() {
        let shareBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        shareBtn.setImage(UIImage(named: "share")?.af_imageAspectScaled(toFit: CGSize(width: 15, height: 15)).withRenderingMode(.alwaysOriginal), for: UIControlState())
        shareBtn.imageView?.contentMode = .scaleAspectFit
        shareBtn.addTarget(self, action: #selector(backToHome(sender:)), for: .touchUpInside)
        let rightNavBarButton = UIBarButtonItem.init(customView: shareBtn)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
    }
    
    func setRedColorForStatusBar() {
        statusBar.backgroundColor = color1
    }
    
    func setWhiteColorForStatusBar() {
        statusBar.backgroundColor = UIColor.white
    }
}


