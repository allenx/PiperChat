//
//  SocketManager.swift
//  PiperChat
//
//  Created by Allen X on 5/22/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import SocketIO
import UIKit

class SocketManager: NSObject {
    
    static let shared = SocketManager()
    
    var socket = SocketIOClient(socketURL: URL(string: "http://35.185.153.217:3000")!, config: [.log(true), .forcePolling(true)])
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func logInWith(userName: String, password: String, completion: (Bool) -> ()) {
        var loginStatus = false
        socket.emit("login", ["username": userName, "password": password])
        
        socket.on("loginStatus") { (data, ack) in
            if let result = data[0] as? Dictionary<String, String> {
                if result["result"] == "success" {
                    
                    loginStatus = true
                }
            }
        }
        
        completion(loginStatus)
    }
    
    
}
