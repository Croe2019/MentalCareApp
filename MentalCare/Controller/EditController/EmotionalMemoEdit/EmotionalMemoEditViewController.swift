//
//  EmotionalMemoEditViewController.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/17.
//

import UIKit
import SQLite3

@available(iOS 15.0, *)
class EmotionalMemoEditViewController: UIViewController {
    
    fileprivate var title_field = UITextField()
    fileprivate var edit_text_field = EmotionalMemoEditTextField()
    fileprivate var memo_body_view = UITextView()
    fileprivate var edit_memo_body_view = EmotionalMemoEditTextView()
    fileprivate var save_button = UIButton()
    fileprivate var edit_save_button = EditSaveButton()
    
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
        view.addSubview(save_button)
        edit_text_field.CreateEmotionalMemoEditTextField(emotional_memo_edit_text_field: title_field, edit_text: title_field.text!)
        edit_save_button.CreateEdtiSaveButton(edit_save_button: save_button)
        edit_memo_body_view.CreateEmotionalMemoEditView(memo_body_view: memo_body_view, edit_memo_body: memo_body_view.text)
        
        SetNavigationBar()
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
    
    @objc func Save(){
        
        Update(edit_id: edit_id, title: title_field.text!, memo_body: memo_body_view.text)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuBarController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    // ログイン画面に戻る
    @objc func Back(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

@available(iOS 15.0, *)
extension EmotionalMemoEditViewController{
    
    private func OpenDB(){
        let file_url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.db_file)
        if sqlite3_open(file_url.path, &db) != SQLITE_OK{
            print("DBファイルが見つからず、生成もできません")
        }else{
            print("DBファイルが生成できました（対象のパスにDBファイルが存在しました）")
            print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        }
    }
    
    // 後でクラス化する リファクタリング対象
    public func Update(edit_id: Int, title: String, memo_body: String) -> Bool{
        
        OpenDB()
        let update_sql = """
        UPDATE EmotionalMemo SET
        title = '\(title)',
        memo_body = '\(memo_body)'
        WHERE id = '\(edit_id)'
        """
        
        var update_stmt: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, (update_sql as NSString).utf8String, -1, &update_stmt, nil) != SQLITE_OK {
                print("db error1: \(db)")
                return false
            }
            
            sqlite3_bind_text(update_stmt, 1, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(update_stmt, 2, (memo_body as NSString).utf8String, -1, nil)
            
            
            sqlite3_bind_int(update_stmt, 0, Int32(edit_id))
            
            if sqlite3_step(update_stmt) != SQLITE_DONE {
                
                print("error2: \(db)")
                sqlite3_finalize(update_stmt)
                return false
            }
            sqlite3_finalize(update_stmt)
        
        return true
    }
}
