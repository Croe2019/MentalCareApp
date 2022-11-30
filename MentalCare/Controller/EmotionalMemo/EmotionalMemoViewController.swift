//
//  EmotionalMemoViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/29.
//

import UIKit

class EmotionalMemoViewController: UIViewController {

    var home_label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()

        home_label.text = "感情メモ"
        home_label.frame = CGRect(x: 50, y: 300, width: 300, height: 200)
        home_label.fontSize = 40
        view.addSubview(home_label)
    }
    
    
}
