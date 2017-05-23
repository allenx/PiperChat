//
//  PiperChatSessionManager.swift
//  PiperChat
//
//  Created by Allen X on 5/17/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import Foundation
import RealmSwift

class PiperChatSessionManager: MessageOnReceiveDelegate {
    static let shared = PiperChatSessionManager()
    var sessions: [PiperChatSession] {
        get {
            return try! RealmManager.shared.fetchSessions()
        } set {
            sessions = newValue
        }
    }
    
    
    func didReceive(message: PiperChatMessage) {
//        log.obj(message as AnyObject)/
        log.errorMessage("fufufufuufufful")/
        for var session in sessions {
            if message.palID == session.palID {
                session.insert(message: message)
                RealmManager.shared.flushToDisk(sessionToAdd: session)
                return
            }
        }
        
//        let newSession = PiperChatSession(palID: message.palID, palName: PiperChatUserManager.shared.userNickNameFrom(id: message.palID), messages: [message])
        let newSession = PiperChatSession(palID: message.palID, palName: PiperChatUserManager.shared.userNickNameFrom(id: message.palID), palUserName: message.palUserName, messages: [message])
        RealmManager.shared.flushToDisk(sessionToAdd: newSession)
        sessions.append(newSession)
    }
}
