//
//  CounselingDeleteButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/02.
//

import Foundation
import SnapKit

class CounselingDeleteButton{
    
    public func CreateDeleteButton(delete_button: UIButton){
        
        delete_button.snp.makeConstraints { make in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(750)
        }
        
        delete_button.setTitle("削除", for: .normal)
        delete_button.backgroundColor = .red
    }
}
