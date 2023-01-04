//
//  TableViewCell.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/04.
//

import Foundation
import SwipeCellKit

class TableViewCell: SwipeTableViewCell{
    
    var title_label = UILabel()
    
    override func awakeFromNib() {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
