//
//  InsertEmotionalMemo.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/13.
//

import Foundation
import SQLite3

class InsertEmotionalMemo{
    
    private let db_file = "MentalCare.db"
    private var db: OpaquePointer?
    
    private func CreateEmotionalMemoTable(){
        
        let create_table = "CREATE TABLE EmotionalMemo (id integer primary key autoincrement, title string, memo_body string, emotional_factor integer)"
        
        if sqlite3_exec(db, create_table, nil, nil, nil) != SQLITE_OK{
            print("テーブルの作成に失敗しました")
        }else{
            print("テーブルが作成されました")
        }
    }
    
    private func OpenDB(){
        
        let file_url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.db_file)
        
        if sqlite3_open(file_url.path, &db) != SQLITE_OK{
            print("DBファイルが見つからず、生成もできません")
        }else{
            print("DBファイルが生成できました(対象のパスにDBファイルが存在しました。)")
        }
    }
    
    public func Insert(title: String, memo_body: String, emotional_factor: Int){
        
        OpenDB()
        CreateEmotionalMemoTable()
        var stmt: OpaquePointer?
        
        let query_string = "INSERT INTO EmotionalMemo (title, memo_body, emotional_factor) VALUES('\(title)', '\(memo_body)', '\(emotional_factor)')"
        // クリエの準備をする
        if sqlite3_prepare(self.db, query_string, -1, &stmt, nil) != SQLITE_OK{
            let error_message = String(cString: sqlite3_errmsg(self.db)!)
            print("error preparing insert: \(error_message)")
            return
        }
        
        // クリエを実行する
        if sqlite3_step(stmt) != SQLITE_DONE{
            let error_message = String(cString: sqlite3_errmsg(self.db)!)
            print("failure inserting hero: \(error_message)")
            return
        }
        
        print("データが登録されました")
        
    }
}
