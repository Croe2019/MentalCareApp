//
//  EmotionalMemoEditTextField.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/19.
//

import Foundation
import UIKit
import SnapKit

class EmotionalMemoEditTextField{
    
    public func CreateEmotionalMemoEditTextField(emotional_memo_edit_text_field: UITextField, edit_text: String){
        
        emotional_memo_edit_text_field.snp.makeConstraints { make in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(150)
        }
        
        //emotional_memo_edit_text_field.placeholder = "タイトル"
        emotional_memo_edit_text_field.layer.borderColor = UIColor.black.cgColor
        emotional_memo_edit_text_field.layer.borderWidth = 1.0
        
    }
}
