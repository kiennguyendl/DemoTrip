//
//  AppDelegate.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigation: UINavigationController?
    let googleMapsApiKey = "AIzaSyAcQ6DygC5hMoUY5RSzBNxcbXeCfGhmYjI"
    let directionAPIKey = "AIzaSyCVloQ1V5dIJPvNgKa0DnnWdSGqD7E8t6U"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        self.window?.frame = CGRect(x: 0, y: 20, width: (self.window?.frame.size.width)!, height: (self.window?.frame.size.height)! - 20)
        
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeController = TabbarBaseController(nibName: "TabbarBaseController", bundle: nil)
        //let navigationController = UINavigationController(rootViewController: homeController)
        window?.rootViewController = homeController
        window?.makeKeyAndVisible()
        
        //init tabbar
        let tabbar = initTabbarController()
        navigateToHomeScreen(tabbar)
        
        Settings.isScaleMenuView = false
        
        //google map
        GMSServices.provideAPIKey(googleMapsApiKey)
        GMSPlacesClient.provideAPIKey(googleMapsApiKey)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func initTabbarController() -> TabbarBaseController{
        let tabbarController = TabbarBaseController()
        let homeNavController = initNavHomeViewController()
        
        let profile = initNavigationControllerWithVC(ProfileViewController(nibName: "ProfileViewController", bundle: nil))
        let like = initNavigationControllerWithVC(LikeViewController(nibName: "LikeViewController", bundle: nil))
        let inbox = initNavigationControllerWithVC(InboxViewController(nibName: "InboxViewController", bundle: nil))
        let booking = initNavigationControllerWithVC(BookingViewController(nibName: "BookingViewController", bundle: nil))
        
        setTabbarItem(homeNavController, title: "HOME", image: UIImage(named: "home1")!, selectedImage: UIImage(named: "home2")!)
        setTabbarItem(like, title: "LIKE", image: UIImage(named: "like1")!, selectedImage: UIImage(named: "like2")!)
        setTabbarItem(inbox, title: "INBOX", image: UIImage(named: "inbox1")!, selectedImage: UIImage(named: "inbox2")!)
        setTabbarItem(booking, title: "BOOKING", image: UIImage(named: "booking1")!, selectedImage: UIImage(named: "booking2")!)
        setTabbarItem(profile, title: "PROFILE", image: UIImage(named: "profile1")!, selectedImage: UIImage(named: "profile2")!)
        tabbarController.viewControllers = [homeNavController, like, inbox, booking, profile]
        return tabbarController
    }
    
    
   private func setTabbarItem(_ controller: UIViewController, title: String, image: UIImage, selectedImage: UIImage) {
        controller.tabBarItem?.title = title
        controller.tabBarItem?.image = image.af_imageAspectScaled(toFit: CGSize(width: 25, height: 25)).withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = selectedImage.af_imageAspectScaled(toFit: CGSize(width: 25, height: 25)).withRenderingMode(.alwaysOriginal)
        
        controller.tabBarItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: .normal)
        controller.tabBarItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)], for: .selected)
    }
    
    private func initNavHomeViewController() -> NavigationController{
        let homeVC = HomeViewController()
        return initNavigationControllerWithVC(homeVC)
    }
    
    private func initNavigationControllerWithVC(_ controller: BaseViewController) -> NavigationController {
        let navigationController = NavigationController()
        navigationController.viewControllers = [controller]
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if appDelegate.navigation != nil {
                appDelegate.navigation = navigationController
            }else {
                appDelegate.navigation = UINavigationController()
                appDelegate.navigation = navigationController
            }
        }
        return navigationController
    }
    
    private func navigateToHomeScreen(_ visibleController: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = visibleController
            appDelegate.window?.makeKeyAndVisible()
        }
    }

}

