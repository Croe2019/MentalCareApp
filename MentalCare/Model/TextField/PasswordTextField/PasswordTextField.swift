//
//  PasswordTextField.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/22.
//

import Foundation
import UIKit
import TextFieldEffects
import SnapKit

@available(iOS 13.0, *)
class PasswordTextField{
    
    public func CreateLoginPasswordTextField(password_text_field: HoshiTextField){
        
        // ここで各画面ごとに位置を設定する
        password_text_field.snp.makeConstraints{ (make) in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        password_text_field.placeholder = "Password"
        password_text_field.placeholderFontScale = 0.5
        password_text_field.placeholderColor = .darkGray
        password_text_field.textColor = .darkGray
        password_text_field.borderActiveColor = .darkGray
        password_text_field.borderInactiveColor = .darkGray
        password_text_field.isSecureTextEntry = true
    }
    
    public func CreateRegisterPasswordTextField(password_text_field: HoshiTextField){
        
        
        password_text_field.snp.makeConstraints{ (make) in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        password_text_field.placeholder = "Password"
        password_text_field.placeholderFontScale = 0.5
        password_text_field.placeholderColor = .darkGray
        password_text_field.textColor = .darkGray
        password_text_field.borderActiveColor = .darkGray
        password_text_field.borderInactiveColor = .darkGray
        password_text_field.isSecureTextEntry = true
    }
}
