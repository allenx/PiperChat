//
//  ChatDetailViewController.swift
//  PiperChat
//
//  Created by Allen X on 5/17/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit

class ChatDetailViewController: UIViewController {
    
    
    
    var chatBubbleTable = UITableView()
    var messages: [PiperChatMessage] = []

    convenience init(messages: [PiperChatMessage]) {
        self.init()
        self.messages = messages
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = messages[0].palID
        
        
        
        chatBubbleTable.dataSource = self
        chatBubbleTable.delegate = self
        chatBubbleTable.separatorColor = .clear
        view = chatBubbleTable
        
        
        //TODO: Fix it
        if chatBubbleTable.numberOfRows(inSection: 0) != 0 {
            let indexPath = IndexPath(row: chatBubbleTable.numberOfRows(inSection: 0)-1, section: 0)
            chatBubbleTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            log.word("scrolled to bottom")/
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let fooView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 30))
        
        return fooView
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let currentMessage = messages[indexPath.row]
        let messageHeight = currentMessage.string.height(withConstrainedWidth: (Metadata.Size.Screen.width / 3.0) * 2 - 20, font: Metadata.Font.messageFont)

        var bubbleHeight = messageHeight + 14
        
        if indexPath.row < messages.count - 1 {
            let nextMessage = messages[indexPath.row + 1]
            if nextMessage.type == currentMessage.type {
                bubbleHeight = bubbleHeight + 2
            } else {
                bubbleHeight = bubbleHeight + 8
            }
        }
        
        return bubbleHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BubbleCell(message: messages[indexPath.row])
        return cell
    }
}
