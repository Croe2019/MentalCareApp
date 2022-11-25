//
//  LoginButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/22.
//

import Foundation
import UIKit
import Material

class LoginButton{
    
    public func CreateLoginButton(login_button: RaisedButton){
        
        // ボタンの設定
        login_button.title = "Sign in"
        login_button.titleColor = .white
        login_button.pulseColor = .white
        login_button.backgroundColor = Color.blue.base
        login_button.cornerRadiusPreset = .cornerRadius7
        login_button.frame = CGRect(x: 50, y: 300, width: 300, height: 50)
    }
}
