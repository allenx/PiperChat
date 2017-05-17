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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sigmond Freud"
        
        //Foo testing
        let m1 = PiperChatMessage(string: "Hellooooooo, 你上午十点过的时候讲话声音太大了 你的大招两千多上海", time: Date(), type: .Sent, uid: "2")
        let m2 = PiperChatMessage(string: "【阿里云】亲！第三届阿里中间件性能挑战赛重磅来袭，快加入挑战，展现技术实力吧！大赛提供30万大奖和美国硅谷游学机会！详情：http://tb.cn/BERDoqw 更多资讯请关注微信tianchibigdata001 回td退订", time: Date(), type: .Received, uid: "2")
        
        let m3 = PiperChatMessage(string: "温馨提示：截止05月14日24时，您当月累计使用流量740.3MB。其中：国内流量已使用596.1MB，剩余2.840GB；省内闲时流量已使用144.3MB，剩余1.418GB； 回复“流量查询”或点击进入http://wap.10010.com 查询详情。", time: Date(), type: .Received, uid: "2")
        
        let m4 = PiperChatMessage(string: "师兄我刚刚加了你了不知道你有没有收到", time: Date(), type: .Sent, uid: "1")
        
        let m5 = PiperChatMessage(string: "【阿里巴巴校园招聘】恭喜你获得阿里巴巴实习生offer，欢迎你加入温暖的大家庭！请及时查收个人简历中填写的邮箱并在5月12日中午12点之前完成其中的调研问卷，让阿里能了解你的情况。若有疑问，可咨询阿里巴巴校招小蜜。", time: Date(), type: .Received, uid: "2")
        messages = [m1, m2, m3, m4, m5]
        
        chatBubbleTable.dataSource = self
        chatBubbleTable.delegate = self
        chatBubbleTable.separatorColor = .clear
        view = chatBubbleTable
        
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
        cell.selectionStyle = .none
        return cell
    }
}
