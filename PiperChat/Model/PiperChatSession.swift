//
//  PiperChatSession.swift
//  PiperChat
//
//  Created by Allen X on 5/17/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import Foundation
import RealmSwift

struct PiperChatSession {
    
    let palID: String!
    let palName: String!
    let palUserName: String!
    var messages: [PiperChatMessage]!
    
    var latestMessage: PiperChatMessage {
        get {
            //            for message in messages.reversed() {
            //                if message.palID == palID {
            //                    return message
            //                }
            //            }
            return messages.last!
        }
    }
    
    mutating func insert(message: PiperChatMessage) {
        messages.append(message)
    }
}

final class PiperChatSessionObject: Object {
    dynamic var palID: String!
    dynamic var palName: String!
    dynamic var palUserName: String!
    let messages = List<PiperChatMessageObject>()
    
    override static func primaryKey() -> String? {
        return "palID"
    }
}

extension PiperChatSession: Persistent {
    init(mappedObject: PiperChatSessionObject) {
        palID = mappedObject.palID
        palName = mappedObject.palName
        palUserName = mappedObject.palUserName
        messages = []
        for message in mappedObject.messages {
            messages.append(PiperChatMessage(mappedObject: message))
        }
    }
    
    func mappedObject() -> PiperChatSessionObject {
        let mappedObject = PiperChatSessionObject()
        mappedObject.palID = palID
        mappedObject.palName = palName
        mappedObject.palUserName = palUserName
        for message in messages {
            mappedObject.messages.append(message.mappedObject())
        }
        
        return mappedObject
    }
}
