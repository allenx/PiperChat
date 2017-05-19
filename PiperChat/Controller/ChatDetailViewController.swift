//
//  ChatDetailViewController.swift
//  PiperChat
//
//  Created by Allen X on 5/17/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit
import SlackTextViewController


enum ScrollOrientation {
    case up
    case down
    case left
    case right
}

class ChatDetailViewController: SLKTextViewController {
    
    
    var scrollOrientation: ScrollOrientation?
    //    var chatBubbleTable = UITableView()
    var session: PiperChatSession!
    var messages: [PiperChatMessage] {
        return session.messages
    }
    var tableViewLastPosition = CGPoint.zero
    
    convenience init(session: PiperChatSession) {
        self.init()
        self.session = session
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let messageToSend = UserDefaults.standard.object(forKey: "messageToSendTo\(session.palID)") {
            textView.text = messageToSend as! String
        }
        
        // Using SlackTextViewController is funny because my tableView is all inverted by default
        isInverted = false
        bounces = true
        isKeyboardPanningEnabled = true
        textView.layer.borderColor = UIColor(colorLiteralRed: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0).cgColor
        textView.placeholder = "Message"
        textView.placeholderColor = .gray
        
        textView.backgroundColor = .white
        textInputbar.backgroundColor = .white
        textInputbar.editorRightButton.tintColor = Metadata.Color.accentColor
        textInputbar.rightButton.tintColor = Metadata.Color.accentColor
        textInputbar.isTranslucent = false
        textInputbar.clipsToBounds = true
        textInputbar.autoHideRightButton = true
        textInputbar.maxCharCount = 256
        
        leftButton.setImage(#imageLiteral(resourceName: "icn_upload"), for: .normal)
        leftButton.tintColor = .gray
        rightButton.setTitle("send", for: .normal)
        
        session.messages = session.messages + session.messages
        //        title = messages[0].palID
        title = "Richard Henderix"
        tableView?.separatorColor = .clear
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //TODO: Fix it
        scrollToBottom(animated: false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if textView.text != "" {
            // Set the messageToSend cache
            UserDefaults.standard.set(textView.text, forKey: "messageToSendTo\(session.palID)")
        } else {
            UserDefaults.standard.removeObject(forKey: "messageToSendTo\(session.palID)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollToBottom(animated: Bool) {
        if tableView?.numberOfRows(inSection: 0) != 0 {
            let indexPath = IndexPath(row: (tableView?.numberOfRows(inSection: 0))!-1, section: 0)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tableView?.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
            //            log.word("scrolled to bottom")/
        }
    }
    
    func prepareTextView() {
        
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

extension ChatDetailViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let fooView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 20))
        
        return fooView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let fooView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 30))
        
        return fooView
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let currentMessage = messages[indexPath.row]
        let messageHeight = currentMessage.string.height(withConstrainedWidth: (Metadata.Size.Screen.width / 3.0) * 2 - 20, font: Metadata.Font.messageFont)
        
        var bubbleHeight = messageHeight + 14
        
        if currentMessage.string.characters.count < 5 && currentMessage.string.containsOnlyEmoji {
            bubbleHeight = 60
        }
        
        if indexPath.row < messages.count - 1 {
            //Broken because of using SlackTextViewController
            let nextMessage = messages[indexPath.row + 1]
            if nextMessage.type == currentMessage.type {
                bubbleHeight = bubbleHeight + 2
            } else {
                bubbleHeight = bubbleHeight + 8
            }
            
            //            return bubbleHeight + 8
        }
        
        
        return bubbleHeight
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            
            if scrollOrientation == .down {
                cell.contentView.layer.transform = CATransform3DMakeTranslation(0, 30, 0)
            } else {
                cell.contentView.layer.transform = CATransform3DMakeTranslation(0, -30, 0)
            }
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.contentView.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        scrollOrientation = scrollView.contentOffset.y > tableViewLastPosition.y ? .down : .up
        
        tableViewLastPosition = scrollView.contentOffset
        
        //        if (tableView?.isDragging)! {
        //
        //            for (index, cell) in (tableView?.visibleCells)!.enumerated() {
        //                if scrollOrientation == .down {
        //                    cell.contentView.layer.transform = CATransform3DMakeTranslation(0, -30, 0)
        //                } else {
        //                    cell.contentView.layer.transform = CATransform3DMakeTranslation(0, 30, 0)
        //                }
        //                UIView.animate(withDuration: 0.5, delay: Double(index) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
        //                    cell.contentView.layer.transform = CATransform3DIdentity
        //                }, completion: nil)
        //
        //            }
        //
        //        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        var cell = tableView.dequeueReusableCell(withIdentifier: "BubbleCell", for: indexPath)
        
        let cell = BubbleCell(message: messages[indexPath.row])
        //        cell.transform = tableView.transform
        return cell
    }
}


//MARK: TextViewDelegate
extension ChatDetailViewController {
    
    override func textViewDidBeginEditing(_ textView: UITextView) {
        scrollToBottom(animated: true)
    }
    
    override func didPressRightButton(_ sender: Any?) {

        textView.refreshFirstResponder()
        
        let messageToSend = PiperChatMessage(string: textView.text, timestamp: Date().ticks, type: .sent, palID: session.palID)
        //Send the message via socket and do networking and data storing
        
        let indexPath = IndexPath(row: messages.count, section: 0)
        let rowAnimation: UITableViewRowAnimation = .top
        
        tableView?.beginUpdates()
        session.insert(message: messageToSend)
        tableView?.insertRows(at: [indexPath], with: rowAnimation)
        try! RealmManager.shared.write {
            transaction in
            transaction.add(self.session, update: true)
        }
        tableView?.endUpdates()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tableView?.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
        
        tableView?.reloadRows(at: [indexPath], with: .automatic)
        
        super.didPressRightButton(sender)
    }
    
    
    
    
}
