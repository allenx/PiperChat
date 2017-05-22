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
    let nickName: String!
    
}

final class PiperChatUserObject: Object {
    dynamic var uid: String!
    dynamic var userName: String!
    dynamic var nickName: String!
    
    override static func primaryKey() -> String? {
        return "uid"
    }
}

extension PiperChatUser: Persistent {
    init(mappedObject: PiperChatUserObject) {
        uid = mappedObject.uid
        userName = mappedObject.userName
        nickName = mappedObject.nickName
    }
    
    func mappedObject() -> PiperChatUserObject {
        let mappedObject = PiperChatUserObject()
        mappedObject.uid = uid
        mappedObject.userName = userName
        mappedObject.nickName = nickName
        
        return mappedObject
    }
}
