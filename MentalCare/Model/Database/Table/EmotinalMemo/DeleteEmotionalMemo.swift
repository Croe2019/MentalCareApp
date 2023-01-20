//
//  DeleteEmotionalMemo.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/19.
//

import Foundation
import SQLite3

class DeleteEmotionalMemo{
    
    fileprivate let db_file: String = "MentalCare.db"
    fileprivate var db:OpaquePointer?

    
    private func OpenDB(){
        let file_url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.db_file)
        if sqlite3_open(file_url.path, &db) != SQLITE_OK{
            print("DBファイルが見つからず、生成もできません")
        }else{
            print("DBファイルが生成できました（対象のパスにDBファイルが存在しました）")
            print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        }
    }
    
    // 削除する前にデータ一覧を取得する
    private func SelectData(){
        
        let queryString = "SELECT * FROM EmotionalMemo"
            
        var stmt:OpaquePointer?
        
        // クエリを準備する
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        // クエリを実行し、取得したレコードをループする
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = String(cString: sqlite3_column_text(stmt, 0))
            
            print("id : \(id)")
        }
    }
    
    // 削除を実行するメソッド
    public func DeleteEmotionalMemo(table: String, delete_id: Int){
        
        OpenDB()
        // 削除する前にデータを取得する
        SelectData()
        // 削除を行うSQL
        let sql = "delete from '\(table)' where id = '\(delete_id)'"
        var stmt:OpaquePointer?
        
        // クリエを準備する
        if sqlite3_prepare(db, sql, -1, &stmt, nil) != SQLITE_OK{
            let error_message = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(error_message)")
            return
        }
        
        // クリエを実行する
        if sqlite3_step(stmt) != SQLITE_DONE{
            let error_message = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(error_message)")
            return
        }
        print("データが削除されました")
    }
}
