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
import SQLite3

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
    
    fileprivate var test_button = RaisedButton()
    fileprivate var db:OpaquePointer?
    fileprivate var login_data: [(email: String, login_password: String)] = []
    fileprivate let db_file: String = "MentalCare.db"

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        GetUserData()
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
        
        login_data.forEach{ value in
            if(email_text_field.text == value.email && password_text_field.text == value.login_password){
                print("ログインボタンを押しました")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuBarController
                self.present(vc, animated: true, completion: nil)
            }else{
                // エラーメッセージを表示する
                print("メールアドレス：\(value.email)")
                print("パスワード：\(value.login_password)")
                return
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


@available(iOS 13.0, *)
// ログインの処理はこのファイルだけで行う 後でクラス化する
extension LoginViewController{
    private func OpenDB(){
        let file_url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.db_file)
        if sqlite3_open(file_url.path, &db) != SQLITE_OK{
            print("DBファイルが見つからず、生成もできません")
        }else{
            print("DBファイルが生成できました（対象のパスにDBファイルが存在しました）")
            print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        }
    }
    
    // ここから再開
    public func GetUserData(){
        // DBにのファイルを開く
        OpenDB()
        let sql = "select * from UserData"
        var stmt:OpaquePointer?
        
        // クリエを準備
        if sqlite3_prepare(db, sql, -1, &stmt, nil) != SQLITE_OK{
            let error_message = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(error_message)")
            return
        }
        
        // クリエを実行し、取得したレコードをループする
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let email = String(cString: sqlite3_column_text(stmt, 2))
            let password = String(cString: sqlite3_column_text(stmt, 3))
            login_data.append((email, password))
        }
    }
}
