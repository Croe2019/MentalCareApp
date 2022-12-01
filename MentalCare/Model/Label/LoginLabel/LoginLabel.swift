//
//  LoginLabel.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/24.
//

import Foundation
import LTMorphingLabel
import SnapKit

class LoginLabel{
    
    public func LoginLabel(login_label: LTMorphingLabel){
        
        login_label.fontSize = 40
        //login_label.frame = CGRect(x: 140, y: -70, width: 300, height: 300)
        login_label.text = "Sign in"
        login_label.morphingEffect = .sparkle
    }
}
