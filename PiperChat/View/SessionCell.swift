//
//  SessionCell.swift
//  PiperChat
//
//  Created by Allen X on 5/17/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit
import SDWebImage
import Material

class SessionCell: TableViewCell {
    
    var session: PiperChatSession!
    
    convenience init(session: PiperChatSession) {
        self.init()
        self.session = session
        
        let palName = session.palName
        let palID = session.palID
        let messageToDisplay = session.latestMessage
        let avatarView = UIImageView()
        
        
        if let avatarImage = SDImageCache.shared().imageFromCache(forKey: "avatar_\(palID!)") {
//            log.word("Found Cache!")/
            avatarView.image = avatarImage
            avatarView.layer.cornerRadius = 28
            avatarView.clipsToBounds = true
        } else {
            avatarView.sd_setImage(with: URL(string: "http://oqemn5a21.bkt.clouddn.com/piperchat_avatar\(palID!).jpg"), placeholderImage: #imageLiteral(resourceName: "default_avatar"))
            avatarView.layer.cornerRadius = 28
            avatarView.clipsToBounds = true
            
            // Caching
            SDImageCache.shared().store(avatarView.image, forKey: "avatar_\(palID!)", toDisk: true) {
                log.word("Cached Successfully!")/
            }
        }
        
        
        let palNameLabel = UILabel(text: palName!, boldFontSize: 18)
        palNameLabel.numberOfLines = 1
        let messageToDisplayLabel = UILabel(text: messageToDisplay.string, fontSize: 14)
        messageToDisplayLabel.numberOfLines = 2
        messageToDisplayLabel.textColor = Metadata.Color.secondaryTextColor
        
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints {
            make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(14)
            make.height.width.equalTo(56)
        }
        
        contentView.addSubview(palNameLabel)
        palNameLabel.snp.makeConstraints {
            make in
            make.top.equalTo(avatarView)
            make.left.equalTo(avatarView.snp.right).offset(14)
        }
        
        contentView.addSubview(messageToDisplayLabel)
        messageToDisplayLabel.snp.makeConstraints {
            make in
            make.left.equalTo(palNameLabel)
            make.top.equalTo(palNameLabel.snp.bottom).offset(4)
            make.right.equalTo(contentView).offset(-30)
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
