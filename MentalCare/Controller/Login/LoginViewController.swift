//
//  LoginViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/21.
//

import UIKit
import TextFieldEffects
import Material

class LoginViewController: UIViewController {
    
    var email_text_field = YoshikoTextField()
    let email_text_field_model = EmailTextField()
    var password_text_field = YoshikoTextField()
    let password_text_field_model = PasswordTextField()
    var login_button = RaisedButton()
    let login_button_model = LoginButton()
    var register_button = RaisedButton()
    let register_button_model = RegisterButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIパーツの設定はクラスで管理する
        email_text_field_model.CreateEmailTextField(email_text_field: email_text_field)
        password_text_field_model.CreatePasswordTextField(password_text_field: password_text_field)
        login_button_model.CreateLoginButton(login_button: login_button)
        register_button_model.CreateRegisterButton(register_button: register_button)
        
        view.addSubview(email_text_field)
        view.addSubview(password_text_field)
        view.addSubview(login_button)
        view.addSubview(register_button)
        
        // ログインボタンをタップされた時の処理
        login_button.addTarget(self, action: #selector(LoginViewController.LoginButtonTapped(sender:)), for: .touchUpInside)
        
        // 新規ユーザー登録をタップしたときの処理
        register_button.addTarget(self, action: #selector(LoginViewController.RegisterButtonTapped(sender:)), for: .touchUpInside)
    }
    
    // ログイン処理を行う
    @objc func LoginButtonTapped(sender : Any){
        // ここにはログイン処理を書く
        if email_text_field.text == "" || password_text_field.text == ""{
            print("メールアドレス、パスワードが入力されていません")
        }
        print("ログインボタンを押しました")
    }
    
    // ユーザー登録画面への遷移
    @objc func RegisterButtonTapped(sender: Any){
        // ここに画面遷移処理をかく
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "register") as! RegisterViewController
            self.present(vc, animated: true, completion: nil)
        print("ユーザー登録画面ボタンを押しました")
    }
    
}
