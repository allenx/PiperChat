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
    var sessions: [PiperChatSession] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Foo testing
        let m1 = PiperChatMessage(string: "Hellooooooo, 你上午十点过的时候讲话声音太大了 你的大招两千多上海", time: Date(), type: .Sent, palID: "2")
        let m2 = PiperChatMessage(string: "【阿里云】亲！第三届阿里中间件性能挑战赛重磅来袭，快加入挑战，展现技术实力吧！大赛提供30万大奖和美国硅谷游学机会！详情：http://tb.cn/BERDoqw 更多资讯请关注微信tianchibigdata001 回td退订", time: Date(), type: .Received, palID: "2")
        
        let m3 = PiperChatMessage(string: "温馨提示：截止05月14日24时，您当月累计使用流量740.3MB。其中：国内流量已使用596.1MB，剩余2.840GB；省内闲时流量已使用144.3MB，剩余1.418GB； 回复“流量查询”或点击进入http://wap.10010.com 查询详情。", time: Date(), type: .Received, palID: "2")
        
        let m4 = PiperChatMessage(string: "师兄我刚刚加了你了不知道你有没有收到", time: Date(), type: .Sent, palID: "1")
        
        let m5 = PiperChatMessage(string: "【阿里巴巴校园招聘】恭喜你获得阿里巴巴实习生offer，欢迎你加入温暖的大家庭！请及时查收个人简历中填写的邮箱并在5月12日中午12点之前完成其中的调研问卷，让阿里能了解你的情况。若有疑问，可咨询阿里巴巴校招小蜜。", time: Date(), type: .Received, palID: "2")
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
        
        navigationItem.title = "PiperChat"
        
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


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sessions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SessionCell(session: sessions[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chatDetailVC = ChatDetailViewController(messages: sessions[indexPath.row].messages)
        navigationController?.pushViewController(chatDetailVC, animated: true)
    }
}
