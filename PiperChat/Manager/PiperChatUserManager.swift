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
}
