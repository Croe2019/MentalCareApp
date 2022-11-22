//
//  PasswordTextField.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/22.
//

import Foundation
import UIKit
import TextFieldEffects

class PasswordTextField{
    
    public func CreatePasswordTextField(password_text_field: YoshikoTextField){
        
        password_text_field.frame = CGRect(x: 100, y: 300, width: 150, height: 50)
        password_text_field.placeholder = "パスワードを入力してください"
        password_text_field.placeholderFontScale = 0.5
        password_text_field.placeholderColor = .darkGray
        password_text_field.textColor = .darkGray
        password_text_field.activeBorderColor = .darkGray
        password_text_field.isSecureTextEntry = true
    }
}
