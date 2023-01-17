//
//  EmotinalMemoTitle.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/13.
//

import Foundation
import UIKit
import SnapKit

class EmotionalMemoTitleTextField{
    
    public func CreateEmotionalMemoTitleTextField(emotional_memo_title_text_field: UITextField){
        
        emotional_memo_title_text_field.snp.makeConstraints { make in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(100)
        }
        
        emotional_memo_title_text_field.placeholder = "タイトル"
        emotional_memo_title_text_field.layer.borderColor = UIColor.black.cgColor
        emotional_memo_title_text_field.layer.borderWidth = 1.0
        
    }
}
