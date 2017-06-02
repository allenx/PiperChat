//
//  PiperChatMessage.swift
//  PiperChat
//
//  Created by Allen X on 5/17/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import Foundation
import RealmSwift

struct PiperChatMessage {
    let string: String!
    let timestamp: UInt64?
    let type: CellType!
    let palUserName: String!
    let palID: String
    
}

final class PiperChatMessageObject: Object {
    
    dynamic var string: String!
    dynamic var timestamp: String!
    dynamic var type: Int = 0
    dynamic var palUserName: String!
    dynamic var palID: String!
    
    override static func primaryKey() -> String? {
        return "timestamp"
    }
    
}

extension PiperChatMessage: Persistent {
    init(mappedObject: PiperChatMessageObject) {
        string = mappedObject.string
        timestamp = UInt64(mappedObject.timestamp)!
        switch mappedObject.type {
        case 0:
            type = .received
        case 1:
            type = .sent
        case 2:
            type = .groupReceived
        case 3:
            type = .groupSent
        default:
            type = .received
        }
        palUserName = mappedObject.palUserName
        palID = mappedObject.palID
    }
    
    func mappedObject() -> PiperChatMessageObject {
        let mappedObject = PiperChatMessageObject()
        mappedObject.string = string
        mappedObject.timestamp = String(timestamp!)
        switch type! {
        case .received:
            mappedObject.type = 0
        case .sent:
            mappedObject.type = 1
        case .groupReceived:
            mappedObject.type = 2
        case .groupSent:
            mappedObject.type = 3
        }
        mappedObject.palUserName = palUserName
        mappedObject.palID = palID
        
        return mappedObject
    }
}
