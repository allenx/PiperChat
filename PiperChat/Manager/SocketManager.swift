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
    
    func readyToReceiveMessages() {
        socket.on(UserDefaults.standard.object(forKey: "PiperChatUserID") as! String) { (data, ack) in
            if let dic = data[0] as? [String: Any] {
                guard let palID = dic["fromID"] as? Int,
                    let string = dic["message"] as? String else {
                        return
                }
                
                let message = PiperChatMessage(string: string, timestamp: Date().ticks, type: .received, palID: "\(palID)")
                PiperChatSessionManager.shared.didReceive(message: message)
            }
        }
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func logInWith(userName: String, password: String, completion: @escaping (Bool, String) -> ()) {
        socket.emit("login", ["username": userName, "password": password])
        
        socket.on("loginStatus") { (data, ack) in
            
            if let result = data as? [[String: Any]] {
                if let status = result[0]["result"] as? String {
                    var loginStatus = false
                    if status == "success" {
                        if let id = result[0]["id"] as? Int {
                            loginStatus = true
                            log.word("omg")/
                            completion(loginStatus, "\(id)")
                            return
                        }
                        
                    } else {
                        completion(loginStatus, "0")
                        return
                    }
                }
            }
        }
    }
    
    func getFriendList(uid: Int, completion: @escaping ([[String: Any]]) -> ()) {
        socket.emit("queryFriends", ["uid": uid])
        
        socket.on("friendList") { (data, ack) in
            if let result = data as? [[String: Any]] {
//                log.obj(result as AnyObject)/
                
                let friends = result[0]["results"] as! [[String: Any]]
//                log.obj(friends as AnyObject)/
                completion(friends)
            }
        }
    }
    
    func friendListDidChange() {
        
    }
    
    
    
}
