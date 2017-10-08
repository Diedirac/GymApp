//
//  AppDelegate.swift
//  GymeFitApp
//
//  Created by Chuan Yen Fu on 2017/9/14.
//  Copyright © 2017年 Chuan-Yen Fu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var fbUserInfo: [String:Any]?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(1)
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        var initialViewController: UIViewController
        
        if(FBSDKAccessToken.current() != nil){
            
            let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
            
            FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
                (connection, result, error) -> Void in
                
                if error != nil {
                    print("longinerror =\(error?.localizedDescription ?? "unknown")")
                } else {
                    if let userInfo = result as? [String:Any] {
                        AppDelegate.fbUserInfo = userInfo
                    }
                }
            })
                
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "mainViewController") as! MainViewController
            initialViewController = vc
        } else {
            initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        }
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
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

