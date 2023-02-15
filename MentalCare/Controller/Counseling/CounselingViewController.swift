//
//  CounselingViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/29.
//

import UIKit
import SQLite3
import SwipeCellKit

@available(iOS 15.0, *)
class CounselingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var counseling_table_view: UITableView!
    fileprivate var create_counseling_button = UIButton()
    fileprivate var add_button = AddButton()
    
    //スクリーンの横幅、縦幅を定義
    fileprivate let screenWidth = Int(UIScreen.main.bounds.size.width)
    fileprivate let screenHeight = Int(UIScreen.main.bounds.size.height)
    fileprivate let db_file: String = "MentalCare.db"
    fileprivate var db:OpaquePointer?
    fileprivate var stmt: OpaquePointer? = nil
    
    fileprivate var delete_id:Int = 0
    fileprivate var delete_id_data: [Int] = []
    fileprivate var counseling_data = [String]()
    fileprivate var counseling_factor_data = [Int]()
    fileprivate var get_counseling_data = GetCounselingData()
    fileprivate var counseling_decision = [String]()
    
    fileprivate var edit_id_data: [Int] = []
    fileprivate var edit_counseling_id = Int()
    fileprivate var counseling_body_string = String()
    fileprivate var counseling_factor = Int()
    fileprivate var counseling_completed = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // データ一覧を取得
        get_counseling_data.GetCounselingData(table: "Counseling", delete_id_data: &delete_id_data, edit_id_data: &edit_id_data, counseling_body_data: &counseling_data, counseling_factor_data: &counseling_factor_data, complete_or_incomplete: &counseling_decision)
        counseling_table_view.frame = CGRect(x:screenWidth * 0/100, y:screenHeight * 10/100, width:screenWidth * 100/100, height:screenHeight * 80/100)
        //cellの高さを指定
        self.counseling_table_view.rowHeight = 100
        //セパレーターの色を指定
        counseling_table_view.separatorColor = UIColor.blue
        counseling_table_view.dataSource = self
        counseling_table_view.delegate = self
        
        view.addSubview(create_counseling_button)
        add_button.setupFloatingButton(button: create_counseling_button)
        create_counseling_button.addTarget(self, action: #selector(CreateCounseling), for: .touchUpInside)
        counseling_table_view.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "counseling_detail" {
            
            let detail_vc = segue.destination as! CounselingDetailViewController
            detail_vc.id = edit_counseling_id
            detail_vc.delete_id = delete_id
            detail_vc.counseling_string = counseling_body_string
            detail_vc.counseling_factor = counseling_factor
            detail_vc.counseling_decision = counseling_completed
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // cellごとに格納されている値を代入
        delete_id = delete_id_data[indexPath.row]
        edit_counseling_id = edit_id_data[indexPath.row]
        counseling_body_string = counseling_data[indexPath.row]
        counseling_factor = counseling_factor_data[indexPath.row]
        counseling_completed = counseling_decision[indexPath.row]
        performSegue(withIdentifier: "counseling_detail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return counseling_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "counselingcell", for: indexPath)
        cell.textLabel?.text = counseling_data[indexPath.row]
        return cell
    }
    
    //スワイプ時の表示形式の設定
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    @objc func CreateCounseling(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "counseling_create") as! CounselingCreateViewController
        self.present(vc, animated: true, completion: nil)
    }
}
