//
//  CreateEmotioinalMemoViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/10.
//

import UIKit

@available(iOS 15.0, *)
class CreateEmotioinalMemoViewController: UIViewController {
    
    
    // タイトルを入力するテキストフィールド
    fileprivate var title_text_field = UITextField()
    fileprivate var emotional_memo_title_text_field = EmotionalMemoTitleTextField()
    
    // 感情の詳細を入力するテキストビュー
    fileprivate var memo_body_text_area = UITextView()
    fileprivate var emotional_memo_body_view = EmotionalMemoBodyView()
    
    // DBに書き込みを行う保存ボタン
    fileprivate var save_button = UIButton()
    fileprivate var emotional_memo_save_button = EmotionalMemoSaveButton()
    
    fileprivate var emotional_memo_insert = InsertEmotionalMemo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(title_text_field)
        view.addSubview(memo_body_text_area)
        view.addSubview(save_button)
        
        emotional_memo_title_text_field.CreateEmotionalMemoTitleTextField(emotional_memo_title_text_field: title_text_field)
        emotional_memo_body_view.CreateEmotionalMemoBodyView(memo_body_view: memo_body_text_area)
        emotional_memo_save_button.CreateEmotionalMemoSaveButton(emotional_save_button: save_button)
        
        save_button.addTarget(self, action: #selector(Save), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func Save(){
        
        do{
            emotional_memo_insert.Insert(title: title_text_field.text!, memo_body: memo_body_text_area.text)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }catch{
            print("データの追加に失敗しました") 
        }
    }
    
}
