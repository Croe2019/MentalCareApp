//
//  RegisterViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/22.
//

import UIKit
import TextFieldEffects
import Material
import LTMorphingLabel

@available(iOS 13.0, *)
class RegisterViewController: UIViewController {
    
    var user_name_text_field = YoshikoTextField()
    let user_name_text_field_model = UserNameTextField()
    var email_text_field = YoshikoTextField()
    let email_text_field_model = EmailTextField()
    var password_text_field = YoshikoTextField()
    let password_text_field_model = PasswordTextField()
    var register_button = RaisedButton()
    let register_button_model = RegisterButton()
    var register_label = LTMorphingLabel()
    let register_label_model = RegisterLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user_name_text_field_model.CreateUserNameTextField(user_name_text_field: user_name_text_field)
        email_text_field_model.CreateRegisterEmailTextField(email_text_field: email_text_field)
        password_text_field_model.CreateRegisterPasswordTextField(password_text_field: password_text_field)
        register_button_model.CreateRegisterButton(register_button: register_button)
        register_label_model.RegisterLabel(register_label: register_label)
        
        view.addSubview(register_label)
        view.addSubview(user_name_text_field)
        view.addSubview(email_text_field)
        view.addSubview(password_text_field)
        view.addSubview(register_button)
    }
    
    // ログイン画面に戻る
    @objc func Back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func Register(){
        // ここでDBにユーザー情報を登録後、ホーム画面へ遷移する
    }
}
