//
//  EmotinalPieChart.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/30.
//

import Foundation
import RKPieChart
import SnapKit

class EmotionalPieChart{
    
    public func EmotionalPieChartSet(chart_view: RKPieChartView){
        
        chart_view.circleColor = .clear
        chart_view.translatesAutoresizingMaskIntoConstraints = false
        chart_view.arcWidth = 30
        chart_view.isIntensityActivated = false
        chart_view.style = .butt
        chart_view.isTitleViewHidden = false
        chart_view.isAnimationActivated = true
        
        chart_view.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(500)
        }
        
    }
}
