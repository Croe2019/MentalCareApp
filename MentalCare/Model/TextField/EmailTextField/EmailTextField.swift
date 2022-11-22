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
class EmailTextField{
    
    public func CreateEmailTextField(email_text_field: YoshikoTextField){
        
        // メールアドレスのテキストフィールドの設定
        email_text_field.frame = CGRect(x: 100, y: 200, width: 150, height: 50)
        email_text_field.placeholder = "メールアドレスを入力してください"
        email_text_field.placeholderFontScale = 0.5
        email_text_field.placeholderColor = .darkGray
        email_text_field.textColor = .darkGray
        email_text_field.activeBorderColor = .darkGray
    }
}
