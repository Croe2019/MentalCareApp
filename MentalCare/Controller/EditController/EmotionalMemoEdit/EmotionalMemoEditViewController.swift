//
//  EmotionalMemoEditViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/17.
//

import UIKit
import SQLite3
import RKSlider

@available(iOS 15.0, *)
class EmotionalMemoEditViewController: UIViewController {
    
    fileprivate var title_field = UITextField()
    fileprivate var edit_text_field = EmotionalMemoEditTextField()
    fileprivate var memo_body_view = UITextView()
    fileprivate var edit_memo_body_view = EmotionalMemoEditTextView()
    fileprivate var save_button = UIButton()
    fileprivate var edit_save_button = EditSaveButton()
    
    // 感情の数値を増減するスライダー
    fileprivate var emotional_paramater = Slider()
    fileprivate var emotional_paramater_slider = EmotionalParamaterSlider()
    fileprivate var emotional_factor = Int()
    
    fileprivate var update_emotional_memo = UpDateEmotionalMemo()
    // 現段階ではfileprivateはつけない 後で値を渡すクラスを作成すること(リファクタリング)
    fileprivate let db_file: String = "MentalCare.db"
    fileprivate var db:OpaquePointer?
    var edit_id = Int()
    var title_string = String()
    var memo_body_string = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        title_field.text = title_string
        memo_body_view.text = memo_body_string
        
        view.addSubview(title_field)
        view.addSubview(memo_body_view)
        view.addSubview(emotional_paramater)
        view.addSubview(save_button)
        edit_text_field.CreateEmotionalMemoEditTextField(emotional_memo_edit_text_field: title_field, edit_text: title_field.text!)
        edit_save_button.CreateEdtiSaveButton(edit_save_button: save_button)
        edit_memo_body_view.CreateEmotionalMemoEditView(memo_body_view: memo_body_view, edit_memo_body: memo_body_view.text)
        emotional_paramater_slider.EmotionalParamaterSliderSet(slider: emotional_paramater)
        
        SetNavigationBar()
        emotional_paramater.addTarget(self, action: #selector(SliderDidChangeValue), for: .valueChanged)
        save_button.addTarget(self, action: #selector(Save), for: .touchUpInside)
    }
    
    func SetNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(title: "戻る", style: .done, target: nil, action: #selector(Back))
        navItem.leftBarButtonItem = doneItem
        
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    @objc func SliderDidChangeValue(_ sender: Slider){
        self.emotional_factor = Int(sender.value)
        print(emotional_factor)
    }
    
    @objc func Save(){
        
        update_emotional_memo.Update(edit_id: edit_id, title: title_field.text!, memo_body: memo_body_view.text, emotional_factor: emotional_factor)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuBarController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    // ログイン画面に戻る
    @objc func Back(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
