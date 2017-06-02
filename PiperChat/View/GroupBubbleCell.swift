//
//  GroupBubbleCellTableViewCell.swift
//  PiperChat
//
//  Created by Allen X on 6/2/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit

class GroupBubbleCell: UITableViewCell {

    var message: PiperChatMessage!
    var type: CellType!
    
    convenience init(message: PiperChatMessage!) {
        self.init()
        self.message = message
        self.type = message.type
        
        let bubble = bubbleWith(message: message)
        if type == .groupReceived {
            log.word("fooo")/
            let nameLabel = UILabel(text: PiperChatUserManager.shared.userNickNameFrom(id: message.palID), fontSize: 14)
            let avatarView = UIImageView()

            avatarView.sd_setImage(with: URL(string: "http://oqemn5a21.bkt.clouddn.com/piperchat_avatar\(message.palID).jpg"), placeholderImage: #imageLiteral(resourceName: "default_avatar"))
            avatarView.layer.cornerRadius = 17
            avatarView.clipsToBounds = true
            avatarView.frame = CGRect(x: 8, y: 5, width: 34, height: 34)
            log.word(nameLabel.text!)/
            nameLabel.textColor = .gray
            nameLabel.sizeToFit()
            nameLabel.frame = CGRect(x: 18+39, y: 0, width: nameLabel.bounds.size.width, height: nameLabel.bounds.size.height)
            contentView.addSubview(avatarView)
            contentView.addSubview(nameLabel)
        }
        
        contentView.addSubview(bubble)
        
        selectionStyle = .none
        
    }
    
    func bubbleWith(message: PiperChatMessage) -> UIView {
        
        var cornerRadius: CGFloat = 20
        var bubbleWidth: CGFloat = (Metadata.Size.Screen.width / 3.0) * 2.0
        var bubbleHeight: CGFloat = message.string.height(withConstrainedWidth: bubbleWidth-20, font: Metadata.Font.messageFont) + 14
        
        if message.string.containsChineseCharacters {
            if message.string.characters.count < 17 {
                let fooLabel = UILabel(text: message.string)
                fooLabel.font = Metadata.Font.messageFont
                fooLabel.sizeToFit()
                bubbleWidth = fooLabel.bounds.size.width + 20
            }
        } else {
            if message.string.characters.count < 34 {
                //                bubbleWidth = CGFloat(message.string.characters.count) * 8 + 20
                let fooLabel = UILabel(text: message.string)
                fooLabel.font = Metadata.Font.messageFont
                fooLabel.sizeToFit()
                bubbleWidth = fooLabel.bounds.size.width + 20
            }
        }
        
        if bubbleHeight < 50 {
            cornerRadius = bubbleHeight / 3.0
        }
        
        if message.type == .groupSent {
            
            if message.string.characters.count < 5 && message.string.containsOnlyEmoji {
                let emojiBubble = UILabel(text: message.string, fontSize: 50)
                emojiBubble.sizeToFit()
                bubbleWidth = emojiBubble.bounds.size.width
                bubbleHeight = emojiBubble.bounds.size.height
                //                log.obj(bubbleHeight as AnyObject)/
                emojiBubble.frame = CGRect(x: (Metadata.Size.Screen.width-15-bubbleWidth), y: 0, width: bubbleWidth, height: bubbleHeight)
                return emojiBubble
            }
            
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
            if message.string.characters.count < 4 && message.string.containsOnlyEmoji {
                messageTextView.font = Metadata.Font.messageEmojiFont
            } else {
                messageTextView.font = Metadata.Font.messageFont
            }
            
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
            
            if message.string.characters.count < 5 && message.string.containsOnlyEmoji {
                let emojiBubble = UILabel(text: message.string, fontSize: 50)
                emojiBubble.sizeToFit()
                bubbleWidth = emojiBubble.bounds.size.width
                bubbleHeight = emojiBubble.bounds.size.height
                emojiBubble.frame = CGRect(x: 15+39, y: 20, width: bubbleWidth, height: bubbleHeight)
                return emojiBubble
            }
            
            let bubble = UIImageView(imageName: "BubbleReceive", desiredSize: CGSize(width: bubbleWidth, height: bubbleHeight))
            bubble?.layer.cornerRadius = cornerRadius
            bubble?.clipsToBounds = true
            
            bubble?.frame = CGRect(x: 15+39, y: 20, width: bubbleWidth, height: bubbleHeight)
            
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
            if message.string.characters.count < 4 && message.string.containsOnlyEmoji {
                messageTextView.font = Metadata.Font.messageEmojiFont
            } else {
                messageTextView.font = Metadata.Font.messageFont
            }
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
