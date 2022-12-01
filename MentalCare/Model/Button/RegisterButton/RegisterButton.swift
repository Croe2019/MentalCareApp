//
//  RegisterButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/22.
//

import Foundation
import UIKit
import Material
import SnapKit

class RegisterButton{
    
    public func CreateRegisterButton(register_button: RaisedButton){
        
        register_button.title = "Sign Up"
        register_button.titleColor = .white
        register_button.pulseColor = .white
        register_button.backgroundColor = Color.blue.base
        register_button.cornerRadiusPreset = .cornerRadius7
        register_button.snp.makeConstraints{ (make) in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
    }
}
