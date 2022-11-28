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
    
    var user_name_text_field = HoshiTextField()
    let user_name_text_field_model = UserNameTextField()
    var email_text_field = HoshiTextField()
    let email_text_field_model = EmailTextField()
    var password_text_field = HoshiTextField()
    let password_text_field_model = PasswordTextField()
    var register_button = RaisedButton()
    let register_button_model = RegisterButton()
    var register_label = LTMorphingLabel()
    let register_label_model = RegisterLabel()
    var database = Database()
    var users_table = UsersTable()
    
    var back_button: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user_name_text_field_model.CreateUserNameTextField(user_name_text_field: user_name_text_field)
        email_text_field_model.CreateRegisterEmailTextField(email_text_field: email_text_field)
        password_text_field_model.CreateRegisterPasswordTextField(password_text_field: password_text_field)
        register_button_model.CreateRegisterButton(register_button: register_button)
        register_label_model.RegisterLabel(register_label: register_label)
        
        SetNavigationBar()
        //database.OpenDB()
        // 最初に1回だけ処理をよぶ
        //users_table.CreateUsersTable()
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        view.addSubview(register_label)
        view.addSubview(user_name_text_field)
        view.addSubview(email_text_field)
        view.addSubview(password_text_field)
        view.addSubview(register_button)
        register_button.addTarget(self, action: #selector(Register), for: .touchUpInside)
    }
    
    func SetNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(Back))
        navItem.leftBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    // ログイン画面に戻る
    @objc func Back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func Register(){
        users_table.insert(name: user_name_text_field.text!, email: email_text_field.text!, password: password_text_field.text!)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeViewController
        self.present(vc, animated: true, completion: nil)
    }
}
