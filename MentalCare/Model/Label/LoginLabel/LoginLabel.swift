//
//  LoginLabel.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/24.
//

import Foundation
import LTMorphingLabel

class LoginLabel{
    
    public func LoginLabel(login_label: LTMorphingLabel){
        
        login_label.fontSize = 40
        login_label.frame = CGRect(x: 130, y: -70, width: 300, height: 300)
        login_label.text = "ログイン"
        login_label.morphingEffect = .sparkle
    }
}
