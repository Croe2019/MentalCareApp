//
//  CreateCounselingButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/02.
//

import Foundation
import UIKit
import SnapKit

@available(iOS 15.0, *)
class CreateCounselingButton{
    
    public func CreateCounselingButtonSetting(counseling_save_button: UIButton){
        
        counseling_save_button.snp.makeConstraints { make in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(700)
        }
        
        counseling_save_button.setTitle("保存", for: .normal)
        counseling_save_button.backgroundColor = .tintColor
    }
}
