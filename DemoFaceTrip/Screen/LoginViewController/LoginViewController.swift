//
//  LoginViewController.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogInBtn(_ sender: Any) {
        let tabbar = initTabbarController()
        navigateToHomeScreen(tabbar)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func initTabbarController() -> TabbarBaseController{
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
    
    func setTabbarItem(_ controller: UIViewController, title: String, image: UIImage, selectedImage: UIImage) {
        controller.tabBarItem?.title = title
        controller.tabBarItem?.image = image.af_imageAspectScaled(toFit: CGSize(width: 25, height: 25)).withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = selectedImage.af_imageAspectScaled(toFit: CGSize(width: 25, height: 25)).withRenderingMode(.alwaysOriginal)
        
        controller.tabBarItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: .normal)
        controller.tabBarItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor(red: 235.0/255.0, green: 114.0/255.0, blue: 106.0/255.0, alpha: 1.0)], for: .selected)
    }
    
    func initNavHomeViewController() -> NavigationController{
        let homeVC = HomeViewController()
        return initNavigationControllerWithVC(homeVC)
    }
    
    func initNavigationControllerWithVC(_ controller: BaseViewController) -> NavigationController {
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
    
    func navigateToHomeScreen(_ visibleController: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = visibleController
            appDelegate.window?.makeKeyAndVisible()
        }
    }

}
