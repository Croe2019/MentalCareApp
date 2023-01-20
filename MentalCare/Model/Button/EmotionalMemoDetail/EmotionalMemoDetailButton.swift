//
//  EmotionalMemoDetailButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/19.
//

import Foundation
import UIKit
import SnapKit

@available(iOS 15.0, *)
class EmotionalMemoDetailButton{
    
    public func CreateEmotionalMemoDetailButton(edit_button: UIButton){
        
        edit_button.snp.makeConstraints { make in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(600)
        }
        
        edit_button.setTitle("編集", for: .normal)
        edit_button.backgroundColor = .tintColor
    }
}
