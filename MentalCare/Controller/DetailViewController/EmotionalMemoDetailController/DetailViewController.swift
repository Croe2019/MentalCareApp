//
//  DetailViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/17.
//

import UIKit
import RKPieChart
import SnapKit

@available(iOS 15.0, *)
class DetailViewController: UIViewController {
    
    fileprivate var title_label = UILabel()
    fileprivate var detail_label = EmotionalMemoDetailLabel()
    fileprivate var detail_id_label = UILabel()
    fileprivate var memo_body_view = UITextView()
    fileprivate var detail_text_view = EmotionalMemoDetailTextView()
    fileprivate var edit_scene_move_button = UIButton()
    fileprivate var detail_button = EmotionalMemoDetailButton()
    fileprivate var delete_button = UIButton()
    fileprivate var emotional_memo_delete_button_setting = EmotionalMemoDeleteButton()
    fileprivate var delete_emotional_memo = DeleteEmotionalMemo()
    
    // 感情の数値を出力するグラフ 各設定はクラスに持たせる
    fileprivate var emotional_paramater_pie_chart = EmotionalPieChart()
    
    // 現段階ではfileprivateはつけない 後で値を渡すクラスを作成すること(リファクタリング)
    var id = Int()
    var delete_id = Int()
    var title_string = String()
    var memo_body_string = String()
    var emotional_factor = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title_label.text = title_string
        memo_body_view.text = memo_body_string
        
        view.addSubview(title_label)
        view.addSubview(memo_body_view)
        view.addSubview(edit_scene_move_button)
        view.addSubview(delete_button)
        detail_label.EmotionalMemoDetailLabel(detail_label: title_label, detail_text: title_label.text!)
        detail_text_view.CreateEmotionalMemoDetailView(memo_body_view: memo_body_view, detail_memo_body: memo_body_view.text)
        detail_button.CreateEmotionalMemoDetailButton(edit_button: edit_scene_move_button)
        emotional_memo_delete_button_setting.CreateDeleteButton(edit_save_button: delete_button)
        memo_body_view.isEditable = false
        memo_body_view.isSelectable = false
        SetNavigationBar()
        CreateModels()
        edit_scene_move_button.addTarget(self, action: #selector(Edit), for: .touchUpInside)
        delete_button.addTarget(self, action: #selector(Delete), for: .touchUpInside)
        
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
    
    
    fileprivate func CreateModels(){
        
        let no_problem: RKPieChartItem = RKPieChartItem(ratio: uint(emotional_factor), color: UIColor.blue, title: "安定しています")
        let no_problem_view = RKPieChartView(items: [no_problem], centerTitle: "")
        
        let warning: RKPieChartItem = RKPieChartItem(ratio: uint(emotional_factor), color: UIColor.yellow, title: "少し余裕がありません")
        let warning_view = RKPieChartView(items: [warning], centerTitle: "")
        
        let dangar: RKPieChartItem = RKPieChartItem(ratio: uint(emotional_factor), color: UIColor.red, title: "余裕がない状態です")
        let dangar_view = RKPieChartView(items: [dangar], centerTitle: "")
        
        let max1: RKPieChartItem = RKPieChartItem(ratio: 50, color: UIColor.red, title: "感情の容量がいっぱいです！")
        let max2: RKPieChartItem = RKPieChartItem(ratio: 50, color: UIColor.red, title: "問題を解決しましょう！")
        let max_view = RKPieChartView(items: [max1, max2], centerTitle: "")
        
        self.view.addSubview(no_problem_view)
        self.view.addSubview(warning_view)
        self.view.addSubview(dangar_view)
        self.view.addSubview(max_view)
        
        switch(emotional_factor){
        case 0...30:
            emotional_paramater_pie_chart.EmotionalPieChartSet(chart_view: no_problem_view)
            break
        case 31...69:
            emotional_paramater_pie_chart.EmotionalPieChartSet(chart_view: warning_view)
            break
        case 70...95:
            emotional_paramater_pie_chart.EmotionalPieChartSet(chart_view: dangar_view)
            break
        case 100:
            emotional_paramater_pie_chart.EmotionalPieChartSet(chart_view: max_view)
            break
        default:
            break
        }
        
    }
    
    // ログイン画面に戻る
    @objc fileprivate func Back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // 削除を実行
    @objc fileprivate func Delete(){
        
        let alert: UIAlertController = UIAlertController(title: "\(self.title_string)を削除", message: "削除してもよろしいでしょうか？", preferredStyle:  UIAlertController.Style.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
            self.delete_emotional_memo.DeleteEmotionalMemo(table: "EmotionalMemo", delete_id: self.delete_id)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuBarController
            self.present(vc, animated: true, completion: nil)
        })

        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // 編集画面へ遷移
    @objc fileprivate func Edit(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "emotionalmemoedit") as! EmotionalMemoEditViewController
        vc.edit_id = id
        vc.title_string = title_string
        vc.memo_body_string = memo_body_string
        self.present(vc, animated: true, completion: nil)
    }
}

private extension UIColor {
    var dark: UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        
        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: max(r - 0.4, 0.0), green: max(g - 0.4, 0.0), blue: max(b - 0.4, 0.0), alpha: a)
        }
        
        return UIColor()
    }
    var light: UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        
        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: min(r + 0.4, 1.0), green: min(g + 0.4, 1.0), blue: min(b + 0.4, 1.0), alpha: a)
        }
        
        return UIColor()
    }
    
}
