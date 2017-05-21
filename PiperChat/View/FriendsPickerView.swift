//
//  FriendsPickerView.swift
//  PiperChat
//
//  Created by Allen X on 5/19/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import Foundation
import UIKit

class FriendsPickerView: UIView {
    
    var frostView: UIVisualEffectView!
    var tableView: UITableView!
    var friends: [PiperChatUser] = []
    var isTrackingPanLocation = false
    
    //    convenience init(friends: [PiperChatUser]) {
    //        self.init()
    //        frame = CGRect(x: 0, y: 0, width: Metadata.Size.Screen.width, height: Metadata.Size.Screen.height)
    //        separatorColor = .clear
    //
    //        self.friends = friends
    //    }
    
    convenience init(friends: [PiperChatUser]) {
        self.init()
        self.friends = friends
        frame = CGRect(x: 0, y: 0, width: Metadata.Size.Screen.width, height: Metadata.Size.Screen.height)
        backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .light)
        frostView = UIVisualEffectView(effect: blurEffect)
        frostView.frame = frame
        frostView.alpha = 0
        
        let titleLabel = UILabel(text: "Pick a friend!", boldFontSize: 20)
        //        titleLabel.textColor = .gray
        titleLabel.sizeToFit()
        frostView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            make in
            make.centerX.equalTo(frostView)
            make.top.equalTo(frostView).offset(40)
        }
        
        addSubview(frostView)
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        
        tableView.layer.cornerRadius = 20
        tableView.frame = CGRect(x: 0, y: Metadata.Size.Screen.height / 8, width: Metadata.Size.Screen.width, height: Metadata.Size.Screen.height/8*7 + 20)
        addSubview(tableView)
        tableView.transform = CGAffineTransform(translationX: 0, y: tableView.bounds.size.height)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.frostView.alpha = 1
            self.tableView.transform = CGAffineTransform.identity
        }, completion: nil)
        
        assignGesture()
    }
    
    
}

extension FriendsPickerView {
    
    func dismissAnimated(and completion: @escaping () -> ()) {
        for view in frostView.subviews {
            if view.isKind(of: UILabel.self) {
                view.removeFromSuperview()
            }
        }
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.tableView.transform = CGAffineTransform(translationX: 0, y: self.tableView.bounds.size.height)
            self.frostView.alpha = 0
        }) { finished in
            
            if finished {
                self.removeFromSuperview()
                completion()
            }
        }
    }
    
    func dismissAnimatedWithNoCompletion() {
        for view in frostView.subviews {
            if view.isKind(of: UILabel.self) {
                view.removeFromSuperview()
            }
        }
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.tableView.transform = CGAffineTransform(translationX: 0, y: self.tableView.bounds.size.height)
            self.frostView.alpha = 0
        }) { finished in
            
            if finished {
                self.removeFromSuperview()
            }
        }
    }
    
}


extension FriendsPickerView: UIGestureRecognizerDelegate {
    
    func assignGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAnimatedWithNoCompletion))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissAnimatedWithNoCompletion))
        swipeDown.direction = .down
        
        frostView.isUserInteractionEnabled = true
        frostView.addGestureRecognizer(tapGesture)
        frostView.addGestureRecognizer(swipeDown)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panRecognized(recognizer:)))
        panGesture.delegate = self
        tableView.addGestureRecognizer(panGesture)
        
    }
    
    func panRecognized(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began && tableView.contentOffset.y == 0 {
            recognizer.setTranslation(CGPoint.zero, in: tableView)
            isTrackingPanLocation = true
        } else if recognizer.state != .ended && recognizer.state != .failed && recognizer.state != .cancelled && isTrackingPanLocation {
            let panOffset = recognizer.translation(in: tableView)
            
            let isEligible = panOffset.y > 200
            if isEligible {
                recognizer.isEnabled = false
                recognizer.isEnabled = true
                self.dismissAnimatedWithNoCompletion()
            }
            
            if panOffset.y < 0 {
                isTrackingPanLocation = false
            }
        } else {
            isTrackingPanLocation = false
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


extension FriendsPickerView: UITableViewDelegate, UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserCell(user: friends[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissAnimated {
            let friend = self.friends[indexPath.row]
            let newSession = PiperChatSession(palID: friend.uid, palName: friend.userName, messages: [])
            let chatDetailVC = ChatDetailViewController(session: newSession)
            (UIApplication.shared.keyWindow?.rootViewController as? UINavigationController)?.pushViewController(chatDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

