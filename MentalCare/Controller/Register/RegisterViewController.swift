//
//  RegisterViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/22.
//

import UIKit
import TextFieldEffects
import Material

class RegisterViewController: UIViewController {
    
    var user_name_text_field = YoshikoTextField()
    let user_name_text_field_model = UserNameTextField()
    var email_text_field = YoshikoTextField()
    let email_text_field_model = EmailTextField()
    var password_text_field = YoshikoTextField()
    let password_text_field_model = PasswordTextField()
    var register_button = RaisedButton()
    let register_button_model = RegisterButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetNavigationBar()
        
        user_name_text_field_model.CreateUserNameTextField(user_name_text_field: user_name_text_field)
        email_text_field_model.CreateEmailTextField(email_text_field: email_text_field)
        password_text_field_model.CreatePasswordTextField(password_text_field: password_text_field)
        register_button_model.CreateRegisterButton(register_button: register_button)
        
        view.addSubview(user_name_text_field)
        view.addSubview(email_text_field)
        view.addSubview(password_text_field)
        view.addSubview(register_button)
    }
    
    // 現段階では登録画面だけnabigationbarを配置
    func SetNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 30, width: screenSize.width, height: 100))
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(Back))
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    // ログイン画面に戻る
    @objc func Back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func Register(){
        // ここでDBにユーザー情報を登録後、ホーム画面へ遷移する
    }
}
