//
//  PasswordTextField.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/22.
//

import Foundation
import UIKit
import TextFieldEffects

@available(iOS 13.0, *)
class PasswordTextField{
    
    let x = PositionX()
    let y = PositionY()
    var position_x = Int()
    var position_y = Int()
    
    public func CreateLoginPasswordTextField(password_text_field: HoshiTextField){
        
        // ここで各画面ごとに位置を設定する
        position_x = x.PositionSetting(x: 50)
        position_y = y.PositionSetting(y: 200)
        password_text_field.frame = CGRect(x: position_x, y: position_y, width: 300, height: 50)
        password_text_field.placeholder = "Password"
        password_text_field.placeholderFontScale = 0.5
        password_text_field.placeholderColor = .darkGray
        password_text_field.textColor = .darkGray
        password_text_field.borderActiveColor = .darkGray
        password_text_field.borderInactiveColor = .darkGray
        password_text_field.isSecureTextEntry = true
    }
    
    public func CreateRegisterPasswordTextField(password_text_field: HoshiTextField){
        
        position_x = x.PositionSetting(x: 50)
        position_y = y.PositionSetting(y: 280)
        password_text_field.frame = CGRect(x: position_x, y: position_y, width: 300, height: 50)
        password_text_field.placeholder = "Password"
        password_text_field.placeholderFontScale = 0.5
        password_text_field.placeholderColor = .darkGray
        password_text_field.textColor = .darkGray
        password_text_field.borderActiveColor = .darkGray
        password_text_field.borderInactiveColor = .darkGray
        password_text_field.isSecureTextEntry = true
    }
}
