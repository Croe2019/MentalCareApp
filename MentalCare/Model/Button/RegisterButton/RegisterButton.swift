//
//  RegisterButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/22.
//

import Foundation
import UIKit
import Material

class RegisterButton{
    
    public func CreateRegisterButton(register_button: RaisedButton){
        
        register_button.title = "ユーザー登録"
        register_button.titleColor = .white
        register_button.pulseColor = .white
        register_button.backgroundColor = Color.blue.base
        register_button.frame = CGRect(x: 100, y: 400, width: 150, height: 50)
    }
}
