//
//  CounselingCreateViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/01.
//

import UIKit
import RKSlider

@available(iOS 15.0, *)
class CounselingCreateViewController: UIViewController {

    
    fileprivate var counseling_body_text_area = UITextView()
    fileprivate var create_counseling_text_view = CreateCounselingTextView()
    fileprivate var counseling_paramater = Slider()
    fileprivate var counseling_paramater_slider = CounselingParamaterSlider()
    fileprivate var counseling_factor = Int()
    fileprivate var pop_up_button = UIButton()
    fileprivate var pop_up_button_setting = CounselingPopUpButton()
    // DBに書き込みを行う保存ボタン
    fileprivate var save_button = UIButton()
    fileprivate var counseling_button_setting = CreateCounselingButton()
    fileprivate var insert = InsertCounseling()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(counseling_body_text_area)
        view.addSubview(counseling_paramater)
        view.addSubview(pop_up_button)
        view.addSubview(save_button)
        SetNavigationBar()
        save_button.addTarget(self, action: #selector(Save), for: .touchUpInside)
        counseling_paramater.addTarget(self, action: #selector(SliderDidChangeValue), for: .valueChanged)
        create_counseling_text_view.CreateCounselingView(counseling_body_view: counseling_body_text_area)
        counseling_paramater_slider.EmotionalParamaterSliderSet(slider: counseling_paramater)
        pop_up_button_setting.PopUpButtonSetting(button: pop_up_button)
        counseling_button_setting.CreateCounselingButtonSetting(counseling_save_button: save_button)
        
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
        self.counseling_factor = Int(sender.value)
        print(counseling_factor)
    }
    
    // 一覧に戻る
    @objc func Back(){
        self.dismiss(animated: true, completion: nil)
    }

    @objc func Save(){
        
        do{
            insert.Insert(counseling_body: counseling_body_text_area.text, counseling_paramater: counseling_factor, complete_or_incomplete: pop_up_button_setting.GetMenuType())
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }catch{
            print("データの追加に失敗しました")
        }
    }
}
