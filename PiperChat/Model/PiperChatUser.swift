//
//  PiperChatUser.swift
//  PiperChat
//
//  Created by Allen X on 5/18/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import Foundation
import RealmSwift

struct PiperChatUser {
    
    let uid: String!
    let userName: String!
    
}

final class PiperChatUserObject: Object {
    dynamic var uid: String!
    dynamic var userName: String!
    
    override static func primaryKey() -> String? {
        return "uid"
    }
}

extension PiperChatUser: Persistent {
    init(mappedObject: PiperChatUserObject) {
        uid = mappedObject.uid
        userName = mappedObject.userName
    }
    
    func mappedObject() -> PiperChatUserObject {
        let mappedObject = PiperChatUserObject()
        mappedObject.uid = uid
        mappedObject.userName = userName
        
        return mappedObject
    }
}
