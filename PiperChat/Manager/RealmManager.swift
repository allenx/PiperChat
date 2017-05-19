//
//  RealmManager.swift
//  PiperChat
//
//  Created by Allen X on 5/19/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import Foundation
import RealmSwift

//struct RealmManager {
//    
//    static let shared = RealmManager()
//    private let realm: Realm
//    
//    init() throws {
//        try self.init(realm: Realm())
//    }
//    
//    func update(session: PiperChatSession, and completion: () -> ()) {
//        
//        
//        completion()
//    }
//}

final class WriteTransaction {
    private let realm: Realm
    internal init(realm: Realm) {
        self.realm = realm
    }
    
    func add<T: Persistent>(_ value: T, update: Bool) {
        realm.add(value.mappedObject(), update: update)
    }
}

final class RealmManager {
    
    static let shared = try! RealmManager()
    
    private let realm: Realm
    
    convenience init() throws {
        try self.init(realm: Realm())
    }
    
    internal init(realm: Realm) {
        self.realm = realm
        log.obj(self.realm.configuration.fileURL as AnyObject)/
    }
    
    func write(_ block: @escaping (WriteTransaction) throws -> Void) throws {
        let transaction = WriteTransaction(realm: realm)
        try realm.write {
            try block(transaction)
        }
    }
    
    func fetchSessions() -> [PiperChatSession] {
        var sessions: [PiperChatSession] = []
        let sessionObjects = realm.objects(PiperChatSessionObject.self)
        for sessionObject in sessionObjects {
            let session = PiperChatSession(mappedObject: sessionObject)
            sessions.append(session)
        }
        return sessions
    }
}
