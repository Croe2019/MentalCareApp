//
//  EditSaveButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/19.
//

import Foundation
import UIKit
import SnapKit

@available(iOS 15.0, *)
class EditSaveButton{
    
    public func CreateEdtiSaveButton(edit_save_button: UIButton){
        
        edit_save_button.snp.makeConstraints { make in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(600)
        }
        
        edit_save_button.setTitle("更新", for: .normal)
        edit_save_button.backgroundColor = .tintColor
    }
}
