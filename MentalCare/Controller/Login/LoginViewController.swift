//
//  LoginViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/21.
//

import UIKit
import TextFieldEffects
import Material
import LTMorphingLabel
import SnapKit
import RealmSwift

@available(iOS 13.0, *)
class LoginViewController: UIViewController {
    
    fileprivate var email_text_field = HoshiTextField()
    fileprivate let email_text_field_model = EmailTextField()
    fileprivate var password_text_field = HoshiTextField()
    fileprivate let password_text_field_model = PasswordTextField()
    fileprivate var login_button = RaisedButton()
    fileprivate let login_button_model = LoginButton()
    fileprivate var register_button = RaisedButton()
    fileprivate let register_button_model = RegisterButton()
    fileprivate var login_label = LTMorphingLabel()
    fileprivate let login_label_model = LoginLabel()
    fileprivate var user_table = UsersTable()
    //fileprivate var login_data: [(email: String, login_password: String)] = []
    
    fileprivate var test_button = RaisedButton()
    fileprivate let realm = try! Realm()
    fileprivate var user_data: Results<User>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        user_data = realm.objects(User.self)
        
        user_data.forEach { data in
            
            print("メールアドレス：\(data.email)")
            print("ユーザー名：\(data.user_name)")
            print("パスワード：\(data.password)")
            print("デフォルト画像：\(data.default_image)")
        }
        
        print(realm.configuration.fileURL!)
        // UIパーツの設定はクラスで管理する
        email_text_field_model.CreateLoginEmailTextField(email_text_field: email_text_field)
        password_text_field_model.CreateLoginPasswordTextField(password_text_field: password_text_field)
        login_button_model.CreateLoginButton(login_button: login_button)
        register_button_model.CreateRegisterButton(register_button: register_button)
        login_label_model.LoginLabel(login_label: login_label)
        
        view.addSubview(login_label)
        view.addSubview(email_text_field)
        view.addSubview(password_text_field)
        view.addSubview(login_button)
        view.addSubview(register_button)
        view.addSubview(test_button)
        UISetting()
        // ログインボタンをタップされた時の処理
        login_button.addTarget(self, action: #selector(LoginButtonTapped), for: .touchUpInside)
        
        // 新規ユーザー登録をタップしたときの処理
        register_button.addTarget(self, action: #selector(RegisterButtonTapped), for: .touchUpInside)
        
        // テスト用ログインボタン処理呼び出し
        test_button.addTarget(self, action: #selector(TestLogin), for: .touchUpInside)
    }
    
    fileprivate func UISetting(){
        
        // ログインラベルの位置設定
        login_label.snp.makeConstraints{ (make) in
            
            make.centerX.equalToSuperview()
            make.top.equalTo(30)
        }
        
        email_text_field.snp.makeConstraints{ (make) in
            
            make.centerX.equalToSuperview()
            make.top.equalTo(login_label.snp.top).offset(100)
        }
        
        password_text_field.snp.makeConstraints{ (make) in
            
            make.centerX.equalToSuperview()
            make.top.equalTo(email_text_field.snp.top).offset(70)
        }
        
        login_button.snp.makeConstraints{ (make) in
            
            make.centerX.equalToSuperview()
            make.top.equalTo(password_text_field.snp.top).offset(100)
        }
        
        register_button.snp.makeConstraints{ (make) in
            
            make.centerX.equalToSuperview()
            make.top.equalTo(login_button.snp.top).offset(100)
        }
        
        // テスト用ログインボタン
        test_button.snp.makeConstraints{ (make) in
            
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(300)
            make.top.equalTo(register_button.snp.top).offset(100)
        }
        test_button.title = "テスト"
        test_button.titleColor = .white
        test_button.pulseColor = .white
        test_button.backgroundColor = Color.blue.base
        test_button.cornerRadiusPreset = .cornerRadius7
    }
    
    // テスト用ボタン
    @objc func TestLogin(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuBarController
        self.present(vc, animated: true, completion: nil)
    }
    
    // ログイン処理を行う
    @objc func LoginButtonTapped(){
        
        if email_text_field.text == "" || password_text_field.text == ""{
            print("メールアドレス、パスワードのいずれかが入力されていません")
            return
        }
        
        for i in 0..<user_data.count{
            do{
                if user_data[i].email == email_text_field.text && user_data[i].password == password_text_field.text{
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuBarController
                    self.present(vc, animated: true, completion: nil)
                }
            }catch{
                print("メールアドレス、パスワードのどちらかが違います")
            }
        }
    }
    
    // ユーザー登録画面への遷移
    @objc func RegisterButtonTapped(){
        // ここに画面遷移処理をかく
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "register") as! RegisterViewController
            self.present(vc, animated: true, completion: nil)
        print("ユーザー登録画面ボタンを押しました")
    }
    
}

