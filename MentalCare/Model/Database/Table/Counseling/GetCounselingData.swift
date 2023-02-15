//
//  GetCounselingData.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/02.
//

import Foundation
import SQLite3

class GetCounselingData{
    
    fileprivate let db_file: String = "MentalCare.db"
    fileprivate var db:OpaquePointer?
    fileprivate var stmt: OpaquePointer? = nil
    
    private func OpenDB(){
        let file_url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(self.db_file)
        if sqlite3_open(file_url.path, &db) != SQLITE_OK{
            print("DBファイルが見つからず、生成もできません")
        }else{
            print("DBファイルが生成できました（対象のパスにDBファイルが存在しました）")
            print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        }
    }
    
    // 後で呼び出す箇所で取得するテーブルを引数で渡せるようにする
    public func GetCounselingData(table: String, delete_id_data: inout [Int], edit_id_data: inout [Int], counseling_body_data: inout [String], counseling_factor_data: inout [Int], complete_or_incomplete: inout [String]){
        // DBにのファイルを開く
        OpenDB()
        let sql = "select * from '\(table)' order by id asc"
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
            let edit_id = Int(sqlite3_column_int(stmt, 0))
            let counseling_body = String(cString: sqlite3_column_text(stmt, 1))
            let counseling_factor = Int(sqlite3_column_int(stmt, 2))
            let counseling_decision = String(cString: sqlite3_column_text(stmt, 3))
        
            delete_id_data.append(delete_id)
            edit_id_data.append(edit_id)
            counseling_body_data.append(counseling_body)
            counseling_factor_data.append(counseling_factor)
            complete_or_incomplete.append(counseling_decision)
            
        }
    }
}
