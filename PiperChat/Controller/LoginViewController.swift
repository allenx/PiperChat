//
//  LoginViewController.swift
//  PiperChat
//
//  Created by Allen X on 5/18/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import UIKit
import Material

class LoginViewController: UIViewController {
    
    var userNameTextField: TextField!
    var userPasswordTextField: TextField!
    var piperChatTitle: UILabel!
    var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
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
        
        
        view = rainbowBG
        // Do any additional setup after loading the view.
        
        
        prepareTitleLabel()
        prepareTextFields()
        prepareButtons()
        
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


// Login Process
extension LoginViewController {
    func login() {
        
        let username = userNameTextField.text
        let password = userPasswordTextField.text
        
        AccountManager.shared.loginWith(userName: username!, password: password!) {
            [weak self] in
            log.word("checking")/
            if AccountManager.shared.isLoggedIn {
                log.word("checking..Yes")/
                self?.navigationController?.popToRootViewController(animated: true)
                self?.navigationController?.isNavigationBarHidden = false
                self?.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            } else {
                log.word("checking..NO")/

            }
        }
    }
}


// UI Preparing
extension LoginViewController {
    func prepareTitleLabel() {
        piperChatTitle = UILabel(text: "PiperChat", boldFontSize: 48)
        piperChatTitle.textColor = .white
        
        view.addSubview(piperChatTitle)
        piperChatTitle.snp.makeConstraints {
            make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(88)
        }
        
    }
    
    func prepareButtons() {
        
        loginButton = UIButton(title: "Log In", borderWidth: 0.5, borderColor: .clear)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.layout(loginButton).center(offsetY: userPasswordTextField.height + 30).left(100).right(100)
    }
    
    func prepareTextFields() {
        
        
        hideKeyboardWhenTappedAround()
        
        //UserName
        userNameTextField = TextField()
        userNameTextField.keyboardAppearance = .dark
        userNameTextField.autocapitalizationType = .none
        userNameTextField.autocorrectionType = .no
        
        userNameTextField.placeholder = "User Name"
        userNameTextField.isClearIconButtonEnabled = true
        userNameTextField.textColor = .white
        userNameTextField.tintColor = .white
        //        userNameTextField.dividerColor = .white
        userNameTextField.placeholderNormalColor = .white
        userNameTextField.placeholderActiveColor = .white
        userNameTextField.borderColor = .white
        userNameTextField.dividerActiveColor = .white
        userNameTextField.returnKeyType = .next
        userNameTextField.delegate = self
        
        
        
        //Password
        userPasswordTextField = TextField()
        userPasswordTextField.keyboardAppearance = .dark
        userPasswordTextField.placeholder = "Password"
        userPasswordTextField.detail = "At least 8 characters"
        userPasswordTextField.clearButtonMode = .whileEditing
        userPasswordTextField.isVisibilityIconButtonEnabled = true
        userPasswordTextField.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(userPasswordTextField.isSecureTextEntry ? 0.38 : 0.54)
        userPasswordTextField.textColor = .white
        userPasswordTextField.tintColor = .white
        //        userPasswordTextField.dividerColor = .white
        userPasswordTextField.placeholderNormalColor = .white
        userPasswordTextField.placeholderActiveColor = .white
        userPasswordTextField.borderColor = .white
        userPasswordTextField.detailColor = .white
        userPasswordTextField.dividerActiveColor = .white
        userPasswordTextField.returnKeyType = .done
        userPasswordTextField.delegate = self
        
        
        view.layout(userPasswordTextField).center(offsetY: -30).left(40).right(40)
        view.layout(userNameTextField).center(offsetY: -userPasswordTextField.height - 60).left(40).right(40)
    }
}


extension LoginViewController: TextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            let flag = userPasswordTextField.becomeFirstResponder()
            if flag {
                
            }
        } else {
            dismissKeyboard()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}

private extension UIButton {
    convenience init(title: String, borderWidth: CGFloat, borderColor: UIColor) {
        self.init()
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel?.sizeToFit()
        self.layer.cornerRadius = 8
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
