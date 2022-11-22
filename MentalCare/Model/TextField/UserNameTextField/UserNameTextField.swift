//
//  UserNameTextField.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/22.
//

import Foundation
import UIKit
import TextFieldEffects

class UserNameTextField{
    
    public func CreateUserNameTextField(user_name_text_field: YoshikoTextField){
        
        // メールアドレスのテキストフィールドの設定
        user_name_text_field.frame = CGRect(x: 100, y: 100, width: 150, height: 50)
        user_name_text_field.placeholder = "メールアドレスを入力してください"
        user_name_text_field.placeholderFontScale = 0.5
        user_name_text_field.placeholderColor = .darkGray
        user_name_text_field.textColor = .darkGray
        user_name_text_field.activeBorderColor = .darkGray
    }
}
