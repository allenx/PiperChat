//
//  SocketManager.swift
//  PiperChat
//
//  Created by Allen X on 5/22/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import SocketIO
import UIKit

protocol MessageOnReceiveDelegate: class {
    func didReceive(message: PiperChatMessage)
}

class SocketManager: NSObject {
    
    static let shared = SocketManager()
    var delegate: MessageOnReceiveDelegate!
    
    private var socket = SocketIOClient(socketURL: URL(string: "http://35.185.153.217:3000")!, config: [.log(true), .forcePolling(true)])
    
    func establishConnection() {
        
        //        let channel = UserDefaults.standard.object(forKey: "PiperChatUserName") as! String
        //        socket.on(channel) { (data, ack) in
        //                if let dic = data[0] as? [String: Any] {
        //                    guard let palID = dic["fromID"] as? Int,
        //                        let string = dic["message"] as? String else {
        //                            log.errorMessage("fuck")/
        //                            return
        //                    }
        //
        //                    let message = PiperChatMessage(string: string, timestamp: Date().ticks, type: .received, palID: "\(palID)")
        //                    PiperChatSessionManager.shared.didReceive(message: message)
        //
        //                    // For other view controllers to update their views
        //                    self.delegate.didReceive(message: message)
        //                }
        //
        //        }
        
        //        socket.on("messageSC") { (data, ack) in
        //            if let dic = data[0] as? [String: Any] {
        //                guard let palID = dic["fromID"] as? Int,
        //                    let string = dic["message"] as? String else {
        //                        log.errorMessage("fuck")/
        //                        return
        //                }
        //
        ////                let message = PiperChatMessage(string: string, timestamp: Date().ticks, type: .received, palID: "\(palID)")
        //                let message = PiperChatMessage(string: string, timestamp: Date().ticks, type: .received, palUserName: <#T##String!#>, palID: <#T##String#>)
        //                PiperChatSessionManager.shared.didReceive(message: message)
        //
        //                // For other view controllers to update their views
        //                self.delegate.didReceive(message: message)
        //            }
        //
        //        }
        
        socket.connect()
    }
    
    func readyToReceiveMessage() {
        //        let channel = UserDefaults.standard.object(forKey: "PiperChatUserName") as! String
        //        socket.on(channel) { (data, ack) in
        //            if let dic = data[0] as? [String: Any] {
        //                guard let palID = dic["fromID"] as? Int,
        //                let palUserName = dic["from"] as? String,
        //                    let string = dic["message"] as? String else {
        //                        log.errorMessage("fuck")/
        //                        return
        //                }
        //
        ////                let message = PiperChatMessage(string: string, timestamp: Date().ticks, type: .received, palID: "\(palID)")
        //                let message = PiperChatMessage(string: string, timestamp: Date().ticks, type: .received, palUserName: palUserName, palID: "\(palID)")
        //                PiperChatSessionManager.shared.didReceive(message: message)
        //
        //                // For other view controllers to update their views
        //                self.delegate.didReceive(message: message)
        //            }
        //
        //        }
        
        socket.on("receive") { (data, ack) in
            if let dic = data[0] as? [String: Any] {
                guard let palID = dic["fromID"] as? Int,
                    let palUserName = dic["from"] as? String,
                    let string = dic["message"] as? String,
                    let toUserName = dic["to"] as? String else {
                        //                        log.errorMessage("fuck")/
                        return
                }
                
                //                let message = PiperChatMessage(string: string, timestamp: Date().ticks, type: .received, palID: "\(palID)")
                if toUserName == UserDefaults.standard.object(forKey: "PiperChatUserName") as! String {
                    let message = PiperChatMessage(string: string, timestamp: Date().ticks, type: .received, palUserName: palUserName, palID: "\(palID)")
                    
                    log.word("sfdjsdfjklsdfjlksdfjklsdfjlksdjfklsdjflksdjfklsdjf")/
                    
                    PiperChatSessionManager.shared.didReceive(message: message)
                    
                    // For other view controllers to update their views
                    self.delegate.didReceive(message: message)
                }
                
            }
            
        }
    }
    
    func send(message: String, to username: String) {
        let messageBody: [String: String] = [
            "fromID": UserDefaults.standard.object(forKey: "PiperChatUserID") as! String,
            "from": UserDefaults.standard.object(forKey: "PiperChatUserName") as! String,
            "message": message,
            "to": username
        ]
        socket.emit("messageTo", messageBody)
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
