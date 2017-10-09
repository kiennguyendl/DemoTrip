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
        let profile = initNavigationControllerWithVC(HomeViewController(nibName: "HomeViewController", bundle: nil))
        setTabbarItem(homeNavController, title: "Home", image: UIImage(named: "HomeIcon")!)
        setTabbarItem(profile, title: "Profile", image: UIImage(named: "profile")!)
        tabbarController.viewControllers = [homeNavController, profile]
        return tabbarController
    }
    
    func setTabbarItem(_ controller: UIViewController, title: String, image: UIImage) {
        controller.tabBarItem?.title = title
        controller.tabBarItem?.image = image
    }
    
    func initNavHomeViewController() -> NavigationController{
        let homeVC = HomeViewController()
        return initNavigationControllerWithVC(homeVC)
    }
    
    func initNavigationControllerWithVC(_ controller: BaseViewController) -> NavigationController {
        var navigationController = NavigationController()
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
