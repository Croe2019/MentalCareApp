//
//  EmailTextField.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/21.
//

import Foundation
import UIKit
import TextFieldEffects
import SnapKit

// メールアドレスのテキストフィールドの情報を管理する
@available(iOS 13.0, *)
class EmailTextField{
    
    public func CreateLoginEmailTextField(email_text_field: HoshiTextField){
        
        // メールアドレスのテキストフィールドの設定
        email_text_field.snp.makeConstraints{ (make) in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        email_text_field.placeholder = "Email"
        email_text_field.placeholderFontScale = 0.5
        email_text_field.placeholderColor = .darkGray
        email_text_field.textColor = .darkGray
        email_text_field.borderInactiveColor = .darkGray
        email_text_field.borderActiveColor = .darkGray
        
    }
    
    public func CreateRegisterEmailTextField(email_text_field: HoshiTextField){
        
        // メールアドレスのテキストフィールドの設定
        email_text_field.snp.makeConstraints{ (make) in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        email_text_field.placeholder = "Email"
        email_text_field.placeholderFontScale = 0.5
        email_text_field.placeholderColor = .darkGray
        email_text_field.textColor = .darkGray
        email_text_field.borderInactiveColor = .darkGray
        email_text_field.borderActiveColor = .darkGray
    }
}
