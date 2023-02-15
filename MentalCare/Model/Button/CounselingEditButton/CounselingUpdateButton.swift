//
//  CounselingEditButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/15.
//

import Foundation
import UIKit

@available(iOS 15.0, *)
class CounselingUpdateButton{
    
    public func CreateUpdateButton(save_button: UIButton){
        
        save_button.snp.makeConstraints { make in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(680)
        }
        
        save_button.setTitle("更新", for: .normal)
        save_button.backgroundColor = .tintColor
    }
}
