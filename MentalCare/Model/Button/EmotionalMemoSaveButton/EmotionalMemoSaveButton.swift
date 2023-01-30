//
//  EmotionalMemoSaveButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/13.
//

import Foundation
import UIKit
import SnapKit

@available(iOS 15.0, *)
class EmotionalMemoSaveButton{
    
    public func CreateEmotionalMemoSaveButton(emotional_save_button: UIButton){
        
        emotional_save_button.snp.makeConstraints { make in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(600)
        }
        
        emotional_save_button.setTitle("保存", for: .normal)
        emotional_save_button.backgroundColor = .tintColor
    }
}
