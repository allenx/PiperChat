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
    let palID: String!
    
}

final class PiperChatMessageObject: Object {
    
    dynamic var string: String!
    dynamic var timestamp: String!
    dynamic var type: Int = 0
    dynamic var palID: String!
    
    override static func primaryKey() -> String? {
        return "timestamp"
    }
    
}

extension PiperChatMessage: Persistent {
    init(mappedObject: PiperChatMessageObject) {
        string = mappedObject.string
        timestamp = UInt64(mappedObject.timestamp)!
        type = mappedObject.type == 0 ? .received : .sent
        palID = mappedObject.palID
    }
    
    func mappedObject() -> PiperChatMessageObject {
        let mappedObject = PiperChatMessageObject()
        mappedObject.string = string
        mappedObject.timestamp = String(timestamp!)
        mappedObject.type = type == .received ? 0 : 1
        mappedObject.palID = palID
        
        return mappedObject
    }
}
