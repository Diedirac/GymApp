//
//  MainViewController.swift
//  GymeFitApp
//
//  Created by Chuan Yen Fu on 2017/9/14.
//  Copyright © 2017年 Chuan-Yen Fu. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    var fbUserInfo: [String:Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor(red: 1.0, green: 0.4, blue: 0.0, alpha: 1.0)
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.black
        
        if let resultNew = fbUserInfo {
            print("Here is mainView.")
            
            let email = resultNew["email"]  as! String
            print(email)
            
            let firstName = resultNew["first_name"] as! String
            print(firstName)
            
            let lastName = resultNew["last_name"] as! String
            print(lastName)
            
            if let picture = resultNew["picture"] as? NSDictionary,
                let data = picture["data"] as? NSDictionary,
                let url = data["url"] as? String {
                print(url)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
