//
//  PiperChatSession.swift
//  PiperChat
//
//  Created by Allen X on 5/17/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import Foundation

struct PiperChatSession {
    let palID: String!
    let palName: String!
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
