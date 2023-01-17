//
//  AddButton.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/10.
//

import Foundation
import UIKit
import SnapKit

@available(iOS 15.0, *)
class AddButton{
    
    public func setupFloatingButton(button: UIButton) {
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.tintColor.cgColor
        button.layer.borderWidth = 3.0
        button.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-30)
        }
        button.layer.cornerRadius = 25
    }
}
