//
//  PiperChatUserManager.swift
//  PiperChat
//
//  Created by Allen X on 5/22/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit

class PiperChatUserManager: NSObject {
    static let shared = PiperChatUserManager()
    
    var users: [PiperChatUser]? = try! RealmManager.shared.fetchUsers()
    
    func didChangeFriendList() {
        // TODO: finish it
    }
    
    func userNickNameFrom(id: String) -> String {
        if users != nil {
            for user in users! {
                if user.uid == id {
                    return user.userName
                }
            }
        } else {
            AccountManager.shared.getFriendList(and: { (_) in
                
            })
            for user in users! {
                if user.uid == id {
                    return user.userName
                }
            }
        }
        
        
        return "Anonymous"
    }
}
