//
//  BubbleLiveCell.swift
//  PiperChat
//
//  Created by Allen X on 5/18/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit

class BubbleLiveCell: UICollectionViewCell {
    
    var message: PiperChatMessage!
    var type: CellType!
    
    convenience init(message: PiperChatMessage!) {
        self.init()
        self.message = message
        self.type = message.type
        
        let bubble = bubbleWith(message: message)
        contentView.addSubview(bubble)
        
    }
    
    func bubbleWith(message: PiperChatMessage) -> UIImageView {
        
        var cornerRadius: CGFloat = 20
        var bubbleWidth: CGFloat = (Metadata.Size.Screen.width / 3.0) * 2.0
        let bubbleHeight: CGFloat = message.string.height(withConstrainedWidth: bubbleWidth-20, font: Metadata.Font.messageFont) + 14
        
        if message.string.characters.count < 17 {
            bubbleWidth = CGFloat(message.string.characters.count * 15 + 20)
        }
        
        if bubbleHeight < 50 {
            cornerRadius = bubbleHeight / 3.0
        }
        
        if message.type == .sent {
            let bubble = UIImageView(imageName: "BubbleSend", desiredSize: CGSize(width: bubbleWidth, height: bubbleHeight))
            bubble?.layer.cornerRadius = cornerRadius
            bubble?.clipsToBounds = true
            
            bubble?.frame = CGRect(x: (Metadata.Size.Screen.width-15-bubbleWidth), y: 0, width: bubbleWidth, height: bubbleHeight)
            
            //            let messageLabel = UILabel(text: message.string, fontSize: 14)
            //            messageLabel.textColor = .white
            //            messageLabel.numberOfLines = 0
            //            messageLabel.lineBreakMode = .byWordWrapping
            //
            //            messageLabel.frame = CGRect(x: 10, y: 7, width: bubbleWidth - 20, height: bubbleHeight - 14)
            //
            //            bubble?.addSubview(messageLabel)
            
            
            // Using better UITextView for special data format detecting
            let messageTextView = UITextView(frame: CGRect(x: 10, y: 7, width: bubbleWidth - 20, height: bubbleHeight - 14))
            messageTextView.text = message.string
            messageTextView.font = Metadata.Font.messageFont
            messageTextView.textColor = .white
            messageTextView.backgroundColor = .clear
            messageTextView.isScrollEnabled = false
            messageTextView.isEditable = false;
            messageTextView.dataDetectorTypes = .all;
            // Eliminate all the paddings and insets
            messageTextView.textContainerInset = .zero
            messageTextView.textContainer.lineFragmentPadding = 0
            
            bubble?.addSubview(messageTextView)
            return bubble!
            
        } else {
            let bubble = UIImageView(imageName: "BubbleReceive", desiredSize: CGSize(width: bubbleWidth, height: bubbleHeight))
            bubble?.layer.cornerRadius = cornerRadius
            bubble?.clipsToBounds = true
            
            bubble?.frame = CGRect(x: 15, y: 0, width: bubbleWidth, height: bubbleHeight)
            
            //            let messageLabel = UILabel(text: message.string, fontSize: 14)
            //            messageLabel.textColor = .black
            //            messageLabel.numberOfLines = 0
            //            messageLabel.lineBreakMode = .byWordWrapping
            //
            //            messageLabel.frame = CGRect(x: 10, y: 7, width: bubbleWidth - 20, height: bubbleHeight - 14)
            //
            //            bubble?.addSubview(messageLabel)
            
            
            // Using better UITextView for special data format detecting
            let messageTextView = UITextView(frame: CGRect(x: 10, y: 7, width: bubbleWidth - 20, height: bubbleHeight - 14))
            messageTextView.text = message.string
            messageTextView.font = Metadata.Font.messageFont
            messageTextView.textColor = .black
            messageTextView.backgroundColor = .clear
            messageTextView.isScrollEnabled = false
            messageTextView.isEditable = false;
            messageTextView.dataDetectorTypes = .all;
            // Eliminate all the paddings and insets
            messageTextView.textContainerInset = .zero
            messageTextView.textContainer.lineFragmentPadding = 0
            
            bubble?.addSubview(messageTextView)
            return bubble!
        }
    }

}
