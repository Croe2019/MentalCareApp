//
//  CounselingDetailTextView.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/02.
//

import Foundation
import SnapKit

class CounselingDetailTextView{
    
    public func DetailCounselingTextView(counseling_body_view: UITextView, counseling_text: String){
        
        counseling_body_view.snp.makeConstraints { make in
            
            make.height.equalTo(200)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(200)
        }
        
        counseling_body_view.borderColor = .darkGray
        counseling_body_view.layer.borderWidth = 2
    }
}
