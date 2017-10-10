//
//  LoginViewController.swift
//  GymeFit
//
//  Created by Chuan Yen Fu on 2017/9/14.
//  Copyright © 2017年 Chuan-Yen Fu. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    @IBOutlet weak var fbLoginButton: UIButton!
    var fbUserInfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil) {
            print("performSegue")
            self.fetchProfile()
        } else {
            fbLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        }
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
        }
    }
    
    private func fetchProfile() {
        print("attempt to fetch profile......")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            (connection, result, error) -> Void in
            
            if error != nil {
                print("longinerror =\(error?.localizedDescription ?? "unknown")")
            } else {
                if let userInfo = result as? NSDictionary {
                    if let picture = userInfo["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let pictureURL = data["url"] as? String {
                        self.fbUserInfo = UserInfo(firstName: userInfo["first_name"] as? String, lastName: userInfo["last_name"] as? String, email: userInfo["email"]  as? String, userPhotoURL: pictureURL)
                        print("login info set finish")
                        //AppDelegate.fbUserInfo = UserInfo()
                        //AppDelegate.fbUserInfo = self.fbUserInfo
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toMainMenu", sender: self)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainMenu" {
            if let mainvc = segue.destination as? MainViewController {
                mainvc.fbUserInfo = UserInfo()
                mainvc.fbUserInfo = self.fbUserInfo
                print("pass data")
            }
        }
    }
    
    @IBAction func unwindsegueToLoginMenu(unwindSegue: UIStoryboardSegue) {
        
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
