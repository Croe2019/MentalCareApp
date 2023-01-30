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

    fileprivate var uuid = String()
    fileprivate var login_user_label = UILabel()
    fileprivate var email_label = UILabel()
    fileprivate var image_view = UIImageView()
    fileprivate var image_path = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(login_user_label)
        view.addSubview(image_view)
        view.addSubview(email_label)
        
        // リファクタリング対象
        image_view.snp.makeConstraints { make in
            
            make.centerX.equalToSuperview()
            make.top.equalTo(50)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        login_user_label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(image_view.snp.top).offset(200)
        }
        
        email_label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(login_user_label.snp.top).offset(50)
        }
        
        // ここまで
    }
    
}
