//
//  ChatDetailLiveViewController.swift
//  PiperChat
//
//  Created by Allen X on 5/18/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit

class ChatDetailLiveViewController: UIViewController {
    
    var chatBubbleCollectionView = UICollectionView()
    var messages: [PiperChatMessage] = []
    
    convenience init(messages: [PiperChatMessage]) {
        self.init()
        self.messages = messages
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = messages[0].palID
        
        chatBubbleCollectionView.dataSource = self
        chatBubbleCollectionView.delegate = self
        //        chatBubbleTable.separatorColor = .clear
        chatBubbleCollectionView.allowsSelection = false
//        chatBubbleCollectionView.setCollectionViewLayout(, animated: true)
//        if let flowLayout = chatBubbleCollectionView.collectionViewLayout as? ScrollFlowLayout {
//            flowLayout.itemSize = CGSize(width: self.view.frame.size.width, height: 50)
//            flowLayout.minimumLineSpacing = 28
//        }
        //        chatBubbleCollectionView.collectionViewLayout.itemSize
        view = chatBubbleCollectionView
        
        
        // TODO: Fix it
        if chatBubbleCollectionView.numberOfItems(inSection: 0) != 0 {
            let indexPath = IndexPath(row: chatBubbleCollectionView.numberOfItems(inSection: 0)-1, section: 0)
            chatBubbleCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
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


extension ChatDetailLiveViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = BubbleLiveCell(message: messages[indexPath.row])
        return cell
    }
    
    
}
