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

        //Foo testing
        let m1 = PiperChatMessage(string: "Hellooooooo, 你上午十点过的时候讲话声音太大了 你的大招两千多上海", time: Date(), type: .Sent, uid: "2")
        let m2 = PiperChatMessage(string: "【阿里云】亲！第三届阿里中间件性能挑战赛重磅来袭，快加入挑战，展现技术实力吧！大赛提供30万大奖和美国硅谷游学机会！详情：http://tb.cn/BERDoqw 更多资讯请关注微信tianchibigdata001 回td退订", time: Date(), type: .Received, uid: "1")
        messages = [m1, m2]
        
        chatBubbleTable.dataSource = self
        chatBubbleTable.delegate = self
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let currentMessage = messages[indexPath.row]
        let messageHeight = currentMessage.string.height(withConstrainedWidth: (Metadata.Size.Screen.width / 3.0) * 2 - 20, font: Metadata.Font.messageFont)

        let bubbleHeight = messageHeight + 14
        
        return bubbleHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BubbleCell(message: messages[indexPath.row])
        
        return cell
    }
}
