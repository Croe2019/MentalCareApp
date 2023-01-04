//
//  HomeViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/25.
//

import UIKit
import SQLite3
import SnapKit
import RealmSwift

class HomeViewController: UIViewController {

    fileprivate let realm = try! Realm()
    fileprivate var user_data: Results<User>!
    fileprivate var uuid = String()
    fileprivate var login_user_label = UILabel()
    fileprivate var email_label = UILabel()
    fileprivate var image_view = UIImageView()
    fileprivate var image_path = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        user_data = realm.objects(User.self)
        uuid = UIDevice.current.identifierForVendor!.uuidString
        
        // ログインしているユーザーをチェック
        // チェック完了後ログインしているユーザー名を表示する
        user_data.forEach { data in
            if data.individual_identification_number == uuid{
                
                // ユーザー名
                login_user_label.text = data.user_name
                // メールアドレス
                email_label.text = data.email
                // プロフィール画像
                image_path = data.default_image
                let url = URL(string: image_path)
                let data = try! Data(contentsOf: url!)
                image_view.image = UIImage(data: data)
            }
        }
        
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
