//
//  HomeViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/25.
//

import UIKit
import SQLite3
import SnapKit

class HomeViewController: UIViewController {

    var home_label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        home_label.text = "ログイン成功"
        home_label.fontSize = 40
        view.addSubview(home_label)
        
        home_label.snp.makeConstraints{ (make) in
            
            make.center.equalToSuperview()
        }
    }
    
}
