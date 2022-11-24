//
//  UserNameTextField.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/22.
//

import Foundation
import UIKit
import TextFieldEffects

@available(iOS 13.0, *)
class UserNameTextField{
    
    let x = PositionX()
    let y = PositionY()
    var position_x = Int()
    var position_y = Int()
    
    public func CreateUserNameTextField(user_name_text_field: YoshikoTextField){
        
        // 名前のテキストフィールドの設定
        position_x = x.PositionSetting(x: 50)
        position_y = y.PositionSetting(y: 180)
        user_name_text_field.frame = CGRect(x: position_x, y: position_y, width: 250, height: 50)
        user_name_text_field.placeholder = "名前を入力してください"
        user_name_text_field.placeholderFontScale = 0.5
        user_name_text_field.placeholderColor = .darkGray
        user_name_text_field.textColor = .darkGray
        user_name_text_field.activeBorderColor = .link
    }
}
