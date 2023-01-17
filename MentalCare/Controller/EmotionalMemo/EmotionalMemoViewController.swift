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
class EmotionalMemoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
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
    fileprivate var delete_id = Int()
    fileprivate var delete_id_data: [Int] = []
    fileprivate var memo_title_data = [String]()
    fileprivate var memo_body_data = [String]()
    fileprivate var title_string = String()
    fileprivate var memo_body_string = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetEmotionalMemoData()
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            
            let detail_vc = segue.destination as! DetailViewController
            detail_vc.title_string = title_string
            detail_vc.memo_body_string = memo_body_string
            print("タイトル: \(title_string)")
            print("本文: \(memo_body_string)")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // cellごとに格納されている値を代入
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.delegate = self
        cell.textLabel?.text = memo_title_data[indexPath.row]
        return cell
    }
    
    //swipecellkit swipetableviewdelegateのメソッド
    //スワイプした際に表示される文字や画像を設定。またタップした際の処理も設定
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        //右スワイプをした際の処理。今回は何も処理を行わない。
        guard orientation == .right else { return nil }

        //左スワイプした際の処理。
        let deleteAction = SwipeAction(style: .destructive, title: "削除") { action, indexPath in
            //cellの状態を解除する処理。必須の処理。
            action.fulfill(with: .reset)

            /*********************************/
            let alert: UIAlertController = UIAlertController(title: "\(indexPath.row)番目のCellを削除", message: "削除してもよろしいでしょうか？", preferredStyle:  UIAlertController.Style.alert)

            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in
                print("OK")
                // DBにあるデータを削除するに変更すること
                // 引数に削除するセルの番号を入れる
                self.delete_id = self.delete_id_data[indexPath.row]
                if self.DeleteEmotionalMemo(delete_id: self.delete_id){
                    print("Delete success")
                }else{
                    print("Delete Failed")
                }
                
                self.memo_title_data.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            })

            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
                (action: UIAlertAction!) -> Void in
                print("Cancel")
            })
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            self.present(alert, animated: true, completion: nil)
            /*********************************/

        }
        //スワイプした際に表示される画像の設定。
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
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


// ログインの処理はこのファイルだけで行う 後でクラス化する
@available(iOS 15.0, *)
extension EmotionalMemoViewController{
    private func OpenDB(){
        let file_url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.db_file)
        if sqlite3_open(file_url.path, &db) != SQLITE_OK{
            print("DBファイルが見つからず、生成もできません")
        }else{
            print("DBファイルが生成できました（対象のパスにDBファイルが存在しました）")
            print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        }
    }
    
    public func GetEmotionalMemoData(){
        // DBにのファイルを開く
        OpenDB()
        let sql = "select * from EmotionalMemo"
        var stmt:OpaquePointer?
        
        // クリエを準備
        if sqlite3_prepare(db, sql, -1, &stmt, nil) != SQLITE_OK{
            let error_message = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(error_message)")
            return
        }
        
        // クリエを実行し、取得したレコードをループする
        while(sqlite3_step(stmt) == SQLITE_ROW){
            
            let delete_id = Int(sqlite3_column_int(stmt, 0))
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let memo_body = String(cString: sqlite3_column_text(stmt, 2))
            
            delete_id_data.append(delete_id)
            memo_title_data.append(title)
            memo_body_data.append(memo_body)
        }
    }
    
    public func DeleteEmotionalMemo(delete_id: Int) -> Bool{
        
        OpenDB()
        // 削除を行うSQL
        let sql = "delete from EmotionalMemo where id = \(delete_id)"
        var stmt:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, (sql as NSString).utf8String, -1, &stmt, nil) != SQLITE_OK {
        
            return false
        }
        
        sqlite3_bind_int(stmt, 1,Int32(delete_id))
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            sqlite3_finalize(stmt)
            return false
        }

        sqlite3_finalize(stmt)
        return true
    }
}
