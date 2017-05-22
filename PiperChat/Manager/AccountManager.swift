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
    
    func loginWith(userName: String, password: String, and completion: @escaping () -> ()) {
        guard userName != "" else {
            log.errorMessage("userName empty")/
            return
        }
        guard password != "" else {
            log.errorMessage("password empty")/
            return
        }
        
        //Do the networking and token caching
        SocketManager.shared.logInWith(userName: userName, password: password) { (succeeded, id) in
            if succeeded {
                UserDefaults.standard.set("fooToken", forKey: "PiperChatToken")
                UserDefaults.standard.set(id, forKey: "PiperChatUserID")
                UserDefaults.standard.set(userName, forKey: "PiperChatUserName")
                
                completion()
                
            } else {
                log.word("failed")/
                completion()
            }
        }
    }
    
    func logOut(and completion: () -> ()) {
        UserDefaults.standard.removeObject(forKey: "PiperChatToken")
//        UserDefaults.standard.removeObject(forKey: "PiperChatUserID")
    }
    
    
    func getFriendList(and completion: @escaping ([PiperChatUser]) -> ()) {
        
        SocketManager.shared.getFriendList(uid: Int(UserDefaults.standard.object(forKey: "PiperChatUserID") as! String)!) {
            friends in
            var friendList: [PiperChatUser] = []
            for friend in friends {
                guard let friendID = friend["id"] as? Int,
                    let friendUserName = friend["username"] as? String,
                    let friendNickName = friend["nickname"] as? String else {
                        completion([])
                        return
                }
                if "\(friendID)" != UserDefaults.standard.object(forKey: "PiperChatUserID") as! String {
//                    let friend = PiperChatUser(uid: "\(friendID)", userName: friendNickName)
                    let friend = PiperChatUser(uid: "\(friendID)", userName: friendUserName, nickName: friendNickName)
                    friendList.append(friend)
                }
            }
            PiperChatUserManager.shared.users = friendList
            try! RealmManager.shared.flushToDisk(userToFlush: nil)
            completion(friendList)
        }
    }
    
}
