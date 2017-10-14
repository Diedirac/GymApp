//
//  MemberInfoViewController.swift
//  GymeFit
//
//  Created by Chuan Yen Fu on 2017/9/14.
//  Copyright © 2017年 Chuan-Yen Fu. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MemberInfoViewController: UIViewController {
    @IBOutlet weak var memberPhoto: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var bmi: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 0.4, blue: 0.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        let manvc = self.tabBarController as! MainViewController
        
        if let PicURL = manvc.fbUserInfo?.userPhotoURL {
            var userImage: UIImage?
            let userPhotoURL = URL(string: PicURL)!
            let dtinternet = NSData(contentsOf: userPhotoURL)
            userImage = UIImage(data: dtinternet! as Data)
            memberPhoto.image = userImage
        }
        
        if let firstname = manvc.fbUserInfo?.firstName, let lastname = manvc.fbUserInfo?.lastName {
            userName.text = firstname + " " + lastname
        }
        
        if let email = manvc.fbUserInfo?.email {
            userEmail.text = email
        }
    }
    
    override func viewDidLayoutSubviews() {
        memberPhoto.layer.cornerRadius = memberPhoto.frame.width / 2.0
        memberPhoto.clipsToBounds = true
        logoutButton.layer.cornerRadius = 5
        logoutButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func memberLogout(_ sender: Any) {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        
        self.performSegue(withIdentifier: "toLoginMenu", sender: self)
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
