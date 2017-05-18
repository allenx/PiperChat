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
import Material



class MainViewController: UIViewController {
    
    var chatTableView = UITableView()
    var sessions: [PiperChatSession] = []
    var newChatButton: FABButton!
    
    let vc = LoginViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareFabBtn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissFabAnimated()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if !AccountManager.shared.isLoggedIn {
            log.word("Need to Login")/
            let loginVC = LoginViewController()
            navigationController?.pushViewController(loginVC, animated: false)
        }
        
        
        //Foo testing
        let m1 = PiperChatMessage(string: "Hellooooooo, 你上午十点过的时候讲话声音太大了 你的大招两千多上海", time: Date(), type: .sent, palID: "2")
        let m2 = PiperChatMessage(string: "【阿里云】亲！第三届阿里中间件性能挑战赛重磅来袭，快加入挑战，展现技术实力吧！大赛提供30万大奖和美国硅谷游学机会！详情：http://tb.cn/BERDoqw 更多资讯请关注微信tianchibigdata001 回td退订", time: Date(), type: .received, palID: "2")
        
        let m3 = PiperChatMessage(string: "温馨提示：截止05月14日24时，您当月累计使用流量740.3MB。其中：国内流量已使用596.1MB，剩余2.840GB；省内闲时流量已使用144.3MB，剩余1.418GB； 回复“流量查询”或点击进入http://wap.10010.com 查询详情。", time: Date(), type: .received, palID: "2")
        
        let m4 = PiperChatMessage(string: "师兄我刚刚加了你了不知道你有没有收到", time: Date(), type: .sent, palID: "1")
        
        let m5 = PiperChatMessage(string: "It was a pleasure ! Hope you guys have a great day until your flight ! Safe trip back !", time: Date(), type: .received, palID: "2")
        var messages = [m1, m2, m3, m4, m5]
        let session = PiperChatSession(palID: "1", palName: "Richard Hendrix", messages: messages)
        
        let session2 = session
        sessions = [session, session2]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = Metadata.Color.accentColor
        //Changing NavigationBar Title color
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Metadata.Color.naviTextColor]
        // This is for removing the dark shadows when transitioning
        navigationController?.navigationBar.isTranslucent = false
        
        title = "PiperChat"
        
        chatTableView = UITableView()
        
        view = chatTableView
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.separatorColor = .clear
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissFabAnimated() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.newChatButton.frame = CGRect(x: Metadata.Size.Screen.width-90, y: Metadata.Size.Screen.height+10, width: 60, height: 60)
        }) { (animationFinished) in
            if animationFinished {
                self.newChatButton.removeFromSuperview()
            }
        }
    }
    
    func prepareFabBtn() {
        
        
        newChatButton = FABButton(title: "+")
        
        newChatButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        newChatButton.backgroundColor = Metadata.Color.accentColor
        newChatButton.pulseColor = .white
        newChatButton.pulseAnimation = .pointWithBacking
        
        newChatButton.frame = CGRect(x: Metadata.Size.Screen.width-90, y: Metadata.Size.Screen.height-90, width: 60, height: 60)
        newChatButton.transform = CGAffineTransform(translationX: 0, y: 100)
        
        navigationController?.view.addSubview(newChatButton)
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.curveEaseIn], animations: {
            self.newChatButton.frame = CGRect(x: Metadata.Size.Screen.width-90, y: Metadata.Size.Screen.height-90, width: 60, height: 60)
        }) { (flag) in
            
        }
    }
    
    func startNewChat() {
        
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sessions.count < 6 {
            return sessions.count + 2
        }
        
        return sessions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < sessions.count {
            let cell = SessionCell(session: sessions[indexPath.row])
            return cell
        }
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        if indexPath.row == sessions.count {
            let newChat = UIImageView(image: #imageLiteral(resourceName: "newChatBtn"))
            newChat.contentMode = .scaleAspectFit
            cell.contentView.addSubview(newChat)
            newChat.snp.makeConstraints {
                make in
                make.center.equalTo(cell.contentView)
                make.width.equalTo(Metadata.Size.Screen.width * 0.9)
                
            }
        }
        if indexPath.row == sessions.count + 1 {
            let newGroup = UIImageView(image: #imageLiteral(resourceName: "groupChatBtn"))
            newGroup.contentMode = .scaleAspectFit
            cell.contentView.addSubview(newGroup)
            newGroup.snp.makeConstraints {
                make in
                make.center.equalTo(cell.contentView)
                make.width.equalTo(Metadata.Size.Screen.width * 0.9)
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < sessions.count {
            let chatDetailVC = ChatDetailViewController(messages: sessions[indexPath.row].messages)
//            let chatDetailVC = ChatDetailLiveViewController(messages: sessions[indexPath.row].messages)
            navigationController?.pushViewController(chatDetailVC, animated: true)
        }
        
    }
}
