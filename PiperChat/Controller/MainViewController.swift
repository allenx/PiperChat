//
//  MainViewController.swift
//  PiperChat
//
//  Created by Allen X on 5/15/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit
import SocketIO
import WebKit
import RealmSwift
import SnapKit



class MainViewController: UIViewController {

    var chatTableView = UITableView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView = UITableView()
        
        view = chatTableView
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        chatTableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let socket = SocketIOClient(socketURL: URL(string: "http://35.185.153.217:80")!, config: [.log(true), .forcePolling(true)])
//        //let socket = SocketIOClient(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .forcePolling(true)])
//        socket.on(clientEvent: .connect) { (data, ack) in
//            log.word("socket connected")/
//            log.obj(data as AnyObject)/
//        }
//        
//        socket.on("currentAmount") {data, ack in
//            if let cur = data[0] as? Double {
//                socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
//                    socket.emit("update", ["amount": cur + 2.50])
//                }
//                
//                ack.with("Got your currentAmount", "dude")
//            }
//        }
//        
//        socket.connect()
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
