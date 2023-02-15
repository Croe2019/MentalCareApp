//
//  CounselingDetailViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/02.
//

import UIKit
import RKPieChart
import SnapKit

@available(iOS 15.0, *)
class CounselingDetailViewController: UIViewController {
    
    fileprivate var counseling_body_view = UITextView()
    fileprivate var counseling_view = CounselingDetailTextView()
    fileprivate var edit_scene_move_button = UIButton()
    fileprivate var edit_button = CounselingEditButton()
    fileprivate var delete_button = UIButton()
    fileprivate var counseling_delete_button = CounselingDeleteButton()
    fileprivate var delete_counseling = DeleteCounseling()
    fileprivate var counseling_pie_chart = CounselingPieChart()
    
    fileprivate var complete_or_incomplete_label = UILabel()
    
    // 受取用変数
    var id = Int()
    var delete_id = Int()
    var counseling_string = String()
    var counseling_factor = Int()
    var counseling_decision = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        counseling_body_view.text = counseling_string
        complete_or_incomplete_label.text = counseling_decision
        complete_or_incomplete_label.frame = CGRect(x: 50, y: 300, width: 300, height: 50)
        
        view.addSubview(counseling_body_view)
        view.addSubview(complete_or_incomplete_label)
        view.addSubview(edit_scene_move_button)
        view.addSubview(delete_button)
        
        counseling_body_view.isEditable = false
        counseling_body_view.isSelectable = false
        
        counseling_view.DetailCounselingTextView(counseling_body_view: counseling_body_view, counseling_text: counseling_body_view.text)
        edit_button.CounselingEditButton(edit_button: edit_scene_move_button)
        counseling_delete_button.CreateDeleteButton(delete_button: delete_button)
        
        SetNavigationBar()
        CreateModels()
        delete_button.addTarget(self, action: #selector(Delete), for: .touchUpInside)
        // 編集画面に遷移する処理を追加すること TODO ここから再開
        edit_scene_move_button.addTarget(self, action: #selector(Edit), for: .touchUpInside)
        
    }
    
    fileprivate func CreateModels(){
        
        let no_problem: RKPieChartItem = RKPieChartItem(ratio: uint(counseling_factor), color: UIColor.blue, title: "余裕があります")
        let no_problem_view = RKPieChartView(items: [no_problem], centerTitle: "")
        
        let warning: RKPieChartItem = RKPieChartItem(ratio: uint(counseling_factor), color: UIColor.yellow, title: "少し余裕がありません")
        let warning_view = RKPieChartView(items: [warning], centerTitle: "")
        
        let dangar: RKPieChartItem = RKPieChartItem(ratio: uint(counseling_factor), color: UIColor.red, title: "余裕がない状態です")
        let dangar_view = RKPieChartView(items: [dangar], centerTitle: "")
        
        let max1: RKPieChartItem = RKPieChartItem(ratio: 50, color: UIColor.red, title: "限界に達しています！")
        let max2: RKPieChartItem = RKPieChartItem(ratio: 50, color: UIColor.red, title: "誰かに話してみましょう！")
        let max_view = RKPieChartView(items: [max1, max2], centerTitle: "")
        
        self.view.addSubview(no_problem_view)
        self.view.addSubview(warning_view)
        self.view.addSubview(dangar_view)
        self.view.addSubview(max_view)
        
        switch(counseling_factor){
        case 0...30:
            counseling_pie_chart.CounselingPieChartSet(chart_view: no_problem_view)
            break
        case 31...69:
            counseling_pie_chart.CounselingPieChartSet(chart_view: warning_view)
            break
        case 70...95:
            counseling_pie_chart.CounselingPieChartSet(chart_view: dangar_view)
            break
        case 100:
            counseling_pie_chart.CounselingPieChartSet(chart_view: max_view)
            break
        default:
            break
        }
        
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
    
    // 削除を実行
    @objc fileprivate func Delete(){
        
        let alert: UIAlertController = UIAlertController(title: "\(self.counseling_body_view.text)を削除", message: "削除してもよろしいでしょうか？", preferredStyle:  UIAlertController.Style.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
            self.delete_counseling.DeleteCounseling(table: "Counseling", delete_id: self.delete_id)
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
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "counseling_edit") as! CounselingEditViewController
        vc.edit_id = id
        vc.counseling_body = counseling_body_view.text
        vc.counseling_factor = counseling_factor
        vc.counseling_decision = counseling_decision
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
