//
//  AppDelegate.swift
//  parsetagram
//
//  Created by Diana C on 3/9/17.
//  Copyright © 2017 Diana C. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "parsetagram"
                configuration.clientKey = "dkchen"  // set to nil assuming you have not set clientKey
                configuration.server = "https://still-crag-43061.herokuapp.com/parse"
            })
        )
        
//        if User.currentUser != nil {
//            print("There is a current user")
//            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            
//            let vc = storyboard.instantiateViewController(withIdentifier: "")
//            
//            window?.rootViewController = vc
//        } else {
//            print("There is no current user")
//        }
//        
//        NotificationCenter.default.addObserver(forName: User.userDidLogoutNotification, object: nil, queue: OperationQueue.main) { (notification: Notification) in
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            
//            let vc = storyboard.instantiateViewController(withIdentifier: "")
//            
//            self.window?.rootViewController = vc
//        }
        if PFUser.current() != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
            let homeNavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
            let homeViewController = homeNavigationController.topViewController as! HomeViewController
            homeNavigationController.tabBarItem.title = "Home"
            homeNavigationController.tabBarItem.image = UIImage(named: "home")
        
            let captureNavigationController = storyboard.instantiateViewController(withIdentifier: "CaptureNavigationController") as! UINavigationController
            let captureViewController = captureNavigationController.topViewController as! CaptureViewController
            captureNavigationController.tabBarItem.title = "Capture"
            captureNavigationController.tabBarItem.image = UIImage(named: "capture")
        
            let profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
            let profileViewController = profileNavigationController.topViewController as! ProfileViewController
            profileNavigationController.tabBarItem.title = "Profile"
            profileNavigationController.tabBarItem.image = UIImage(named: "profile")
        
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [homeNavigationController, captureNavigationController, profileNavigationController]
        
        
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
        }
        
        NotificationCenter.default.addObserver(forName: ProfileViewController.userDidLogoutNotification, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            
            self.window?.rootViewController = vc
        }
        
        NotificationCenter.default.addObserver(forName: LoginViewController.userDidLoginNotification, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let homeNavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
            let homeViewController = homeNavigationController.topViewController as! HomeViewController
            homeNavigationController.tabBarItem.title = "Home"
            homeNavigationController.tabBarItem.image = UIImage(named: "home")
            
            let captureNavigationController = storyboard.instantiateViewController(withIdentifier: "CaptureNavigationController") as! UINavigationController
            let captureViewController = captureNavigationController.topViewController as! CaptureViewController
            captureNavigationController.tabBarItem.title = "Capture"
            captureNavigationController.tabBarItem.image = UIImage(named: "capture")
            
            let profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
            let profileViewController = profileNavigationController.topViewController as! ProfileViewController
            profileNavigationController.tabBarItem.title = "Profile"
            profileNavigationController.tabBarItem.image = UIImage(named: "profile")
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [homeNavigationController, captureNavigationController, profileNavigationController]
            
            
            self.window?.rootViewController = tabBarController
            self.window?.makeKeyAndVisible()
        }
        
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


}

