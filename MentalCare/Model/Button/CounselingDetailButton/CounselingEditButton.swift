//
//  CounselingEditButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/02.
//

import Foundation
import SnapKit

@available(iOS 15.0, *)
class CounselingEditButton{
    
    public func CounselingEditButton(edit_button: UIButton){
        
        edit_button.snp.makeConstraints { make in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(650)
        }
        
        edit_button.setTitle("編集", for: .normal)
        edit_button.backgroundColor = .tintColor
    }
}
