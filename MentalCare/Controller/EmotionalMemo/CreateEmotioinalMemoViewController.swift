//
//  CreateEmotioinalMemoViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/10.
//

import UIKit
import RKSlider

@available(iOS 15.0, *)
class CreateEmotioinalMemoViewController: UIViewController {
    
    
    // タイトルを入力するテキストフィールド
    fileprivate var title_text_field = UITextField()
    fileprivate var emotional_memo_title_text_field = EmotionalMemoTitleTextField()
    
    // 感情の詳細を入力するテキストビュー
    fileprivate var memo_body_text_area = UITextView()
    fileprivate var emotional_memo_body_view = EmotionalMemoBodyView()
    // 感情の数値を増減するスライダー
    fileprivate var emotional_paramater = Slider()
    fileprivate var emotional_paramater_slider = EmotionalParamaterSlider()
    fileprivate var emotional_factor = Int()
    
    // DBに書き込みを行う保存ボタン
    fileprivate var save_button = UIButton()
    fileprivate var emotional_memo_save_button = EmotionalMemoSaveButton()
    
    fileprivate var emotional_memo_insert = InsertEmotionalMemo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(title_text_field)
        view.addSubview(memo_body_text_area)
        view.addSubview(emotional_paramater)
        view.addSubview(save_button)
        
        emotional_memo_title_text_field.CreateEmotionalMemoTitleTextField(emotional_memo_title_text_field: title_text_field)
        emotional_memo_body_view.CreateEmotionalMemoBodyView(memo_body_view: memo_body_text_area)
        emotional_memo_save_button.CreateEmotionalMemoSaveButton(emotional_save_button: save_button)
        emotional_paramater_slider.EmotionalParamaterSliderSet(slider: emotional_paramater)
        
        save_button.addTarget(self, action: #selector(Save), for: .touchUpInside)
        emotional_paramater.addTarget(self, action: #selector(SliderDidChangeValue), for: .valueChanged)
        SetNavigationBar()
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
    
    // 一覧に戻る
    @objc func Back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func SliderDidChangeValue(_ sender: Slider){
        self.emotional_factor = Int(sender.value)
        print(emotional_factor)
    }
    
    @objc func Save(){
        
        do{
            emotional_memo_insert.Insert(title: title_text_field.text!, memo_body: memo_body_text_area.text, emotional_factor: emotional_factor)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }catch{
            print("データの追加に失敗しました") 
        }
    }
    
}
