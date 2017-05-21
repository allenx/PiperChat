//
//  SessionManager.swift
//  PiperChat
//
//  Created by Allen X on 5/17/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import Foundation

struct SessionManager {
    static var sessions: [PiperChatSession] = RealmManager.shared.fetchSessions()
    
    static func flush() {
        try! RealmManager.shared.write {
            transaction in
            
        }
    }
}
