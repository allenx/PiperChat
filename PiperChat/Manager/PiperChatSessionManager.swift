//
//  PiperChatSessionManager.swift
//  PiperChat
//
//  Created by Allen X on 5/17/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import Foundation
import RealmSwift

class PiperChatSessionManager {
    static let shared = PiperChatSessionManager()
    var sessions = try! RealmManager.shared.fetchSessions()
    
    func didReceive(message: PiperChatMessage) {
        for var session in sessions {
            if message.palID == session.palID {
                session.insert(message: message)
                RealmManager.shared.flushToDisk(sessionToAdd: session)
                return
            }
        }
        
        let newSession = PiperChatSession(palID: message.palID, palName: "", messages: [message])
        RealmManager.shared.flushToDisk(sessionToAdd: newSession)
        sessions.append(newSession)
    }
}
