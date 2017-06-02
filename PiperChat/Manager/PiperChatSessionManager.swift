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
            
        }
    }
    
    
    func didReceive(message: PiperChatMessage) {
        //        log.obj(message as AnyObject)/
        log.errorMessage("fufufufuufufful")/
        for var session in sessions {
            if message.type == .groupReceived {
                if "0" == session.palID {
                    session.insert(message: message)
                    RealmManager.shared.flushToDisk(sessionToAdd: session)
                    return
                }
            } else {
                if message.palID == session.palID {
                    session.insert(message: message)
                    RealmManager.shared.flushToDisk(sessionToAdd: session)
                    return
                }
            }
            
        }
        
        //        let newSession = PiperChatSession(palID: message.palID, palName: PiperChatUserManager.shared.userNickNameFrom(id: message.palID), messages: [message])
        let newSession = PiperChatSession(palID: message.type == .groupReceived ? "0" : message.palID, palName: message.type == .groupReceived ? "Groupie Talkie" : PiperChatUserManager.shared.userNickNameFrom(id: message.palID), palUserName: message.type == .groupReceived ? "GroupieTalkie" : message.palUserName, messages: [message])
        RealmManager.shared.flushToDisk(sessionToAdd: newSession)
        sessions.append(newSession)
    }
}
