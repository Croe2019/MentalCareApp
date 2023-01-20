//
//  EmotionalMemoDetalLabel.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/19.
//

import Foundation
import LTMorphingLabel
import SnapKit

class EmotionalMemoDetailLabel{
    
    // テキストラベルの設定
    public func EmotionalMemoDetailLabel(detail_label: UILabel, detail_text: String){
        
        detail_label.snp.makeConstraints{ (make) in
            
            make.height.equalTo(70)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(110)
        }
        
    }
}
