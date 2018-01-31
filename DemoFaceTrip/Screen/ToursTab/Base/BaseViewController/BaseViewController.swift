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
    var customNavigationBar: CustomNavigationbarForDetailViewController!
    
    var backBtn: UIButton!
    var sharingBtn: UIButton!
    var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBar  = UIApplication.shared.value(forKey: "statusBar") as! UIView
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.initIndicator()
    }
    
    ///notification center
    
    
    func postNotificaion() {
        notificationCenter.post(name: calendarPushtoBookingNotification, object: nil)
    }
    
    func removeObserverForDetail() {
        notificationCenter.removeObserver(self)
    }
    
    
    
    
    //////////////
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    ///custom navigation bar
    func initCustomNavigationBar(){
        customNavigationBar = CustomNavigationbarForDetailViewController(frame: CGRect(x: 0, y: 0, width: (navigationController?.navigationBar.frame.width)!, height: (navigationController?.navigationBar.frame.height)!))
        navigationController?.navigationBar.addSubview(customNavigationBar)
        customNavigationBar.backBtn.addTarget(self, action: #selector(backButtonTarget(sender:)), for: .touchUpInside)
        customNavigationBar.shareBtn.addTarget(customNavigationBar.leftView, action: #selector(shareButtonTarget(sender:)), for: .touchUpInside)
        
    }
    
    func setTitleForNavigationBar(title: String) {
        customNavigationBar.title.text = title
        customNavigationBar.title.sizeToFit()
        if customNavigationBar.title.frame.width >= customNavigationBar.centerView.frame.width{
            
            customNavigationBar.leadingContraint.constant = -customNavigationBar.title.frame.width
            UIView.animate(withDuration: 8, delay: 0.5, options: .repeat, animations: {
                self.customNavigationBar.title.frame.origin.x = self.customNavigationBar.frame.width
                self.customNavigationBar.leadingContraint.constant = self.customNavigationBar.frame.width
            }, completion: nil)
        }else{
            customNavigationBar.title.frame.origin.x = (customNavigationBar.centerView.frame.width / 2) - (customNavigationBar.title.frame.width / 2)
            customNavigationBar.leadingContraint.constant = (customNavigationBar.centerView.frame.width / 2) - (customNavigationBar.title.frame.width / 2)
        }
    }
    
    
    func removeCustomBar() {
        customNavigationBar.removeFromSuperview()
    }
    
    @objc func backButtonTarget(sender: UIButton) {
        setRedColorForStatusBar()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func shareButtonTarget(sender: UIButton) {
        print("sharing")
    }
    
    
    /////////////////////
    
    func initBackButton() {
        //navigationController?.navigationBar.barTintColor = color3
        
        navigationItem.hidesBackButton = true
        backBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
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
        sharingBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        sharingBtn.setImage(UIImage(named: "share")?.af_imageAspectScaled(toFit: CGSize(width: 15, height: 15)).withRenderingMode(.alwaysOriginal), for: UIControlState())
        sharingBtn.imageView?.contentMode = .scaleAspectFit
        sharingBtn.addTarget(self, action: #selector(backToHome(sender:)), for: .touchUpInside)
        let rightNavBarButton = UIBarButtonItem.init(customView: sharingBtn)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
    }
    
    func setRedColorForStatusBar() {
        statusBar.backgroundColor = color1
    }
    
    func setWhiteColorForStatusBar() {
        statusBar.backgroundColor = UIColor.white
    }
    
    func initIndicator() {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        activityIndicator.color = UIColor.gray
        
        self.view.addSubview(activityIndicator)
    }
    func displayIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideIndicator() {
        activityIndicator.stopAnimating()
    }
}


