//
//  EmotionalMemoViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/29.
//

import UIKit
import SwipeCellKit
import SQLite3

@available(iOS 15.0, *)
class EmotionalMemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 作成したメモのタイトルを入れて表示する
    //fileprivate var memo_data = [String]()
    
    //スクリーンの横幅、縦幅を定義
    fileprivate let screenWidth = Int(UIScreen.main.bounds.size.width)
    fileprivate let screenHeight = Int(UIScreen.main.bounds.size.height)
    fileprivate var create_memo_button = UIButton()
    fileprivate var add_button = AddButton()
    
    fileprivate let db_file: String = "MentalCare.db"
    fileprivate var db:OpaquePointer?
    fileprivate var stmt: OpaquePointer? = nil
    // 削除するメモのid
    fileprivate var delete_id:Int = 0
    fileprivate var delete_id_data: [Int] = []
    fileprivate var memo_title_data = [String]()
    fileprivate var memo_body_data = [String]()
    
    // 値を渡すための変数
    fileprivate var edit_id_data: [Int] = []
    fileprivate var edit_memo_id = Int()
    fileprivate var title_string = String()
    fileprivate var memo_body_string = String()
    fileprivate var after_processing_id = [Int]()
    fileprivate var get_emotional_memo = GetEmotionalMemo()
    
    override func viewDidLoad() {
        super.loadView()
        super.viewDidLoad()
        
        // データ一覧を取得
        get_emotional_memo.GetEmotionalMemoData(table: "EmotionalMemo", delete_id_data: &delete_id_data, edit_id_data: &edit_id_data, memo_title_data: &memo_title_data, memo_body_data: &memo_body_data)
        tableView.frame = CGRect(x:screenWidth * 0/100, y:screenHeight * 10/100, width:screenWidth * 100/100, height:screenHeight * 80/100)
        //cellの高さを指定
        self.tableView.rowHeight = 100
        //セパレーターの色を指定
        tableView.separatorColor = UIColor.blue
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(create_memo_button)
        add_button.setupFloatingButton(button: create_memo_button)
        create_memo_button.addTarget(self, action: #selector(MovEmotionalMemo), for: .touchUpInside)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            
            let detail_vc = segue.destination as! DetailViewController
            detail_vc.id = edit_memo_id
            detail_vc.delete_id = delete_id
            detail_vc.title_string = title_string
            detail_vc.memo_body_string = memo_body_string
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // cellごとに格納されている値を代入
        delete_id = delete_id_data[indexPath.row]
        edit_memo_id = edit_id_data[indexPath.row]
        title_string = memo_title_data[indexPath.row]
        memo_body_string = memo_body_data[indexPath.row]
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memo_title_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = memo_title_data[indexPath.row]
        return cell
    }

    //スワイプ時の表示形式の設定。SwipeCellKitの公式サイトを見ると一発でわかる。
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }

    @objc func MovEmotionalMemo(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "create") as! CreateEmotioinalMemoViewController
        self.present(vc, animated: true, completion: nil)
    }
    
}

