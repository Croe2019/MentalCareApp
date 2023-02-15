//
//  CreateCounselingTextView.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/01.
//

import Foundation
import UIKit
import SnapKit

class CreateCounselingTextView{
    
    public func CreateCounselingView(counseling_body_view: UITextView){
        
        counseling_body_view.snp.makeConstraints { make in
            
            make.height.equalTo(200)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(300)
        }
        
        counseling_body_view.borderColor = .darkGray
        counseling_body_view.layer.borderWidth = 2
    }
}
