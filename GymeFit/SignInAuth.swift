//
//  SignInAuth.swift
//  GymeFit
//
//  Created by Chuan Yen Fu on 2017/10/13.
//  Copyright © 2017年 Diedirac. All rights reserved.
//

import FBSDKLoginKit
import GoogleSignIn

class GoogleAuth {
    static func getInstance() -> GIDSignIn {
        return GIDSignIn.sharedInstance()
    }
    
    static func isLogin() -> Bool {
        return getInstance().hasAuthInKeychain()
    }
    
    static func signOut() {
        getInstance().signOut()
    }
    
    static func isValidatedWithUrl(url: NSURL) -> Bool {
        return url.scheme!.hasPrefix(Bundle.main.bundleIdentifier!) || url.scheme!.hasPrefix("com.googleusercontent.apps.")
    }
}

class FacebookAuth {
    static func isLogin() -> Bool {
        return FBSDKAccessToken.current() != nil
    }
    
    static func signOut() {
        FBSDKLoginManager().logOut()
    }
    
    static func isValidatedWithUrl(url: NSURL) -> Bool {
        return url.scheme!.hasPrefix("fb\(FBSDKSettings.appID())") && url.host == "authorize"
    }
}
