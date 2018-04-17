//
//  BaseViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class BaseViewController: UIViewController {
    //static var isScaleMenuView = false
    var statusBar: UIView!
    var customNavigationBar: CustomNavigationbarForDetailViewController!
    
    var backBtn: UIButton!
    var sharingBtn: UIButton!
    var activityIndicator: UIActivityIndicatorView!
    
    var backgroundMusicPlayer: AVAudioPlayer!
    var player: AVPlayer?
    var playerLayer:AVPlayerLayer?
//    var listMusic = ["Inspired", "Birthday", "Playful", "Epic", "Happy"]
    var musicType = arrayMusic[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBar  = UIApplication.shared.value(forKey: "statusBar") as! UIView
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.initIndicator()
        addObserverForKeyBoard()
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
    
    func setNoneColorForNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        //        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setDefaultColorForNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func initLeftRightButton(titleLeft: String, titleRight: String) {
        let leftBtn: UIBarButtonItem = UIBarButtonItem(title: titleLeft, style: .done, target: self, action: #selector(leftButton))
        navigationItem.leftBarButtonItem = leftBtn
        
        let rightBtn: UIBarButtonItem = UIBarButtonItem(title: titleRight, style: .done, target: self, action: #selector(rightButton))
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    @objc func leftButton() {
        
    }
    
    @objc func rightButton() {
        
    }
    
    func addObserverPlayMusicBackground() {
        notificationCenter.addObserver(self, selector: #selector(playBackgroundMusic), name: NSNotification.Name(rawValue: keyPlaymusicNotification), object: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @objc func playBackgroundMusic(_ notification: NSNotification) {
        if let isPlayMusic = notification.userInfo!["isPlayMusic"] as? Bool, let musicFile = notification.userInfo!["musicFile"] as? String{
            let fileManager = FileManager.default
            var audioUrl = getDocumentsDirectory().appendingPathComponent("RecordTheme").appendingPathComponent(musicFile)
            
            if !fileManager.fileExists(atPath: audioUrl.path){
                audioUrl = NSURL(fileURLWithPath: Bundle.main.path(forResource: musicFile, ofType: "mp3")!) as URL
            }
            
            do{
                if backgroundMusicPlayer == nil{
                    backgroundMusicPlayer = try AVAudioPlayer(contentsOf: audioUrl)
                }
            }catch{
                print("can not play file")
            }
            if backgroundMusicPlayer == nil {
                print("Could not create audio player")
                return
            }
            if isPlayMusic{
                print("playing music")
                backgroundMusicPlayer.play()
            }else{
                print("the end play music")
                backgroundMusicPlayer.pause()
                backgroundMusicPlayer = nil
            }
        }
    }
    
    func addObserverForKeyBoard() {
        notificationCenter.addObserver(self, selector: #selector(showKeyBoard), name: UIKeyboardWillShowNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(hideKeyBoard(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @objc func showKeyBoard(_ notification: NSNotification) {
        
    }
    
    @objc func hideKeyBoard(_ notification: NSNotification) {
        
    }
}


