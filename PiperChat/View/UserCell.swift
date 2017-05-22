//
//  UserCell.swift
//  PiperChat
//
//  Created by Allen X on 5/20/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit
import SDWebImage
import Material

class UserCell: TableViewCell {

    var user: PiperChatUser!
    
    convenience init(user: PiperChatUser) {
        self.init()
        self.user = user
        
        let nickName = user.nickName
        let palID = user.uid
        let avatarView = UIImageView()
        
        if let avatarImage = SDImageCache.shared().imageFromCache(forKey: "avatar_\(palID!)") {
            //            log.word("Found Cache!")/
            avatarView.image = avatarImage
            avatarView.layer.cornerRadius = 28
            avatarView.clipsToBounds = true
        } else {
            avatarView.sd_setImage(with: URL(string: "https://liukanshan.zhihu.com/images/downloads/avatars/classic/01-b18627b8.png"), placeholderImage: nil)
            avatarView.layer.cornerRadius = 28
            avatarView.clipsToBounds = true
            
            // Caching
            SDImageCache.shared().store(avatarView.image, forKey: "avatar_\(palID!)", toDisk: true) {
                log.word("Cached Successfully!")/
            }
        }
        
        let nameLabel = UILabel(text: nickName!, boldFontSize: 18)
        nameLabel.numberOfLines = 1
        
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints {
            make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(14)
            make.height.width.equalTo(56)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(avatarView.snp.right).offset(14)
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
