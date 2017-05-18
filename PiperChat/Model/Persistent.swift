//
//  Persistent.swift
//  PiperChat
//
//  Created by Allen X on 5/19/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import RealmSwift

protocol Persistent {
    associatedtype MappedObject: RealmSwift.Object
    init(mappedObject: MappedObject)
    func mappedObject() -> MappedObject
}


