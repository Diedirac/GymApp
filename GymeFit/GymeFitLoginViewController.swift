//
//  GymeFitLoginViewController.swift
//  GymeFitApp
//
//  Created by Chuan Yen Fu on 2017/9/19.
//  Copyright © 2017年 Chuan-Yen Fu. All rights reserved.
//

import UIKit

class GymeFitLoginViewController: UIViewController, UITextFieldDelegate {
    private var screenSize: CGRect = UIScreen.main.bounds
    private var viewSize: CGRect = CGRect(x: 0.0, y:20.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 20.0)
    @IBOutlet weak var memberLoginPhoto: UIImageView!
    @IBOutlet weak var accountText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var recallButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountText.clearButtonMode = .whileEditing
        accountText.keyboardType = .emailAddress
        accountText.returnKeyType = .go
        accountText.delegate = self
        passwordText.clearButtonMode = .whileEditing
        passwordText.keyboardType = .emailAddress
        passwordText.returnKeyType = .go
        passwordText.delegate = self
        signInButton.layer.cornerRadius = 5.0
        signInButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        memberLoginPhoto.layer.cornerRadius = memberLoginPhoto.frame.size.width / 2.0
        memberLoginPhoto.clipsToBounds = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
