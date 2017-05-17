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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        chatTableView.reloadData()
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
        
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
