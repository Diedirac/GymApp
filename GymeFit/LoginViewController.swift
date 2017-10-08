//
//  LoginViewController.swift
//  GymeFitApp
//
//  Created by Chuan Yen Fu on 2017/9/14.
//  Copyright © 2017年 Chuan-Yen Fu. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    @IBOutlet weak var fbLoginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        fbLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func loginButtonClicked() {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) {
            (result, error) in
            if error != nil {
                print("loginerror = \(error?.localizedDescription ?? "unknown")")
                return
            }
            
            self.fetchProfile()
            
            if FBSDKAccessToken.current() != nil {
                self.performSegue(withIdentifier: "fbtoMainView", sender: nil)
            }
        }
    }
    
    func fetchProfile() {
        print("attempt to fetch profile......")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            (connection, result, error) -> Void in
            
            if error != nil {
                print("登入失敗")
                print("longinerror =\(error?.localizedDescription ?? "unknown")")
            } else {
                if let userInfo = result as? [String:Any] {
                    AppDelegate.fbUserInfo = userInfo
                    
                    print("成功登入")
                    
                    let email = userInfo["email"]  as! String
                    print(email)
                    
                    let firstName = userInfo["first_name"] as! String
                    print(firstName)
                    
                    let lastName = userInfo["last_name"] as! String
                    print(lastName)
                    
                    if let picture = userInfo["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String {
                        print(url)
                    }
                }
            }
        })
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
