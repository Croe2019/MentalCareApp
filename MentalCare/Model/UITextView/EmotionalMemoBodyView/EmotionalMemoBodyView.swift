//
//  EmotionalMemoBodyView.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/13.
//

import Foundation
import UIKit
import SnapKit

class EmotionalMemoBodyView{
    
    public func CreateEmotionalMemoBodyView(memo_body_view: UITextView){
        
        memo_body_view.snp.makeConstraints { make in
            
            make.height.equalTo(200)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(300)
        }
        
        memo_body_view.borderColor = .darkGray
        memo_body_view.layer.borderWidth = 2
    }
}
