//
//  AccountManager.swift
//  PiperChat
//
//  Created by Allen X on 5/18/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import Foundation


struct AccountManager {
    static let shared = AccountManager()
    
    var isLoggedIn: Bool {
        get {
            if UserDefaults.standard.object(forKey: "PiperChatToken") != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    func loginWith(userName: String, password: String, and completion: () -> ()) {
        guard userName != "" else {
            log.errorMessage("userName empty")/
            return
        }
        guard password != "" else {
            log.errorMessage("password empty")/
            return
        }
        
        //Do the networking and token caching
        
        //Foo Testing
        UserDefaults.standard.set("fooToken", forKey: "PiperChatToken")
        completion()
    }
    
    func logOut(and completion: () -> ()) {
        UserDefaults.standard.removeObject(forKey: "PiperChatToken")
        
    }
    
    
    
    
}
