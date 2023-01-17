//
//  DetailViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/17.
//

import UIKit

class DetailViewController: UIViewController {
    
    fileprivate var title_label = UILabel()
    fileprivate var memo_body_view = UITextView()
    
    // 現段階ではfileprivateはつけない 後で値を渡すクラスを作成すること(リファクタリング)
    var title_string = String()
    var memo_body_string = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title_label.layer.frame = CGRect(x: 0, y: 200, width: 300, height: 50)
        memo_body_view.layer.frame = CGRect(x: 0, y: 400, width: 300, height: 200)
        
        title_label.text = title_string
        memo_body_view.text = memo_body_string
        
        view.addSubview(title_label)
        view.addSubview(memo_body_view)
        
    }
    


}
