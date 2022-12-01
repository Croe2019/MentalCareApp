//
//  UserNameTextField.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/22.
//

import Foundation
import UIKit
import TextFieldEffects
import SnapKit

@available(iOS 13.0, *)
class UserNameTextField{
    
    public func CreateUserNameTextField(user_name_text_field: HoshiTextField){
        
        // 名前のテキストフィールドの設定
        user_name_text_field.snp.makeConstraints{ (make) in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        user_name_text_field.placeholder = "UserName"
        user_name_text_field.placeholderFontScale = 0.5
        user_name_text_field.placeholderColor = .darkGray
        user_name_text_field.textColor = .darkGray
        user_name_text_field.borderActiveColor = .darkGray
        user_name_text_field.borderInactiveColor = .darkGray
    }
}
