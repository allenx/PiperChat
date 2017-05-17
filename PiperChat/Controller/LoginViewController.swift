//
//  LoginViewController.swift
//  PiperChat
//
//  Created by Allen X on 5/18/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rainbowBG = GradientRainbowView(frame: view.bounds)
        rainbowBG.startPoint = .bottomLeft
        rainbowBG.endPoint = .topRight
        
        rainbowBG.animationDuration = 3
        
        rainbowBG.setColors(colors: [UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                                     UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                                     UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                                     UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                                     UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                                     UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                                     UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        rainbowBG.startAnimation()
        
        view.insertSubview(rainbowBG, at: 0)
        
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
