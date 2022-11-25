//
//  RegisterLable.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/24.
//

import Foundation
import LTMorphingLabel

class RegisterLabel{
    
    // テキストラベルの設定
    public func RegisterLabel(register_label: LTMorphingLabel){
        
        register_label.fontSize = 40
        register_label.frame = CGRect(x: 130, y: -30, width: 300, height: 300)
        register_label.text = "Register"
        register_label.morphingEffect = .sparkle
    }
}
