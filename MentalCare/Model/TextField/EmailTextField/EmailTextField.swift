//
//  EmailTextField.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/21.
//

import Foundation
import UIKit
import TextFieldEffects

// メールアドレスのテキストフィールドの情報を管理する
@available(iOS 13.0, *)
class EmailTextField{
    
    let x = PositionX()
    let y = PositionY()
    var position_x = Int()
    var position_y = Int()
    
    public func CreateLoginEmailTextField(email_text_field: HoshiTextField){
        
        // メールアドレスのテキストフィールドの設定
        position_x = x.PositionSetting(x: 50)
        position_y = y.PositionSetting(y: 100)
        email_text_field.frame = CGRect(x: position_x, y: position_y, width: 300, height: 50)
        email_text_field.placeholder = "Email"
        email_text_field.placeholderFontScale = 0.5
        email_text_field.placeholderColor = .darkGray
        email_text_field.textColor = .darkGray
        email_text_field.borderInactiveColor = .darkGray
        email_text_field.borderActiveColor = .darkGray
        
    }
    
    public func CreateRegisterEmailTextField(email_text_field: HoshiTextField){
        
        // メールアドレスのテキストフィールドの設定
        position_x = x.PositionSetting(x: 50)
        position_y = y.PositionSetting(y: 230)
        email_text_field.frame = CGRect(x: position_x, y: position_y, width: 300, height: 50)
        email_text_field.placeholder = "Email"
        email_text_field.placeholderFontScale = 0.5
        email_text_field.placeholderColor = .darkGray
        email_text_field.textColor = .darkGray
        email_text_field.borderInactiveColor = .darkGray
        email_text_field.borderActiveColor = .darkGray
    }
}
