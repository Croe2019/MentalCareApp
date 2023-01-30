//
//  EmotionalParamaterSlider.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/26.
//

import Foundation
import UIKit
import RKSlider
import SnapKit

class EmotionalParamaterSlider{
    
    public func EmotionalParamaterSliderSet(slider: Slider){
        
        slider.snp.makeConstraints { make in
            
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(500)
        }
        
        slider.cornerRadius = 16
        slider.maximum = 100
        slider.minimum = .zero
        slider.value = .zero
        slider.step = 5
        slider.thumbTextColor = .red
        slider.thumbBackgroundColor = .white
        slider.thumbWidth = 100
    }
}
