//
//  UpdateCounseling.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/02.
//

import Foundation
import SQLite3

class UpdateCounseling{
    
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

    // 後でクラス化する リファクタリング対象
    public func Update(edit_id: Int, counseling_body: String, complete_or_incomplete: String , counseling_paramater: Int) -> Bool{
        
        OpenDB()
        let update_sql = """
        UPDATE Counseling SET
        counseling_body = '\(counseling_body)',
        counseling_paramater = '\(counseling_paramater)',
        complete_or_incomplete = '\(complete_or_incomplete)'
        WHERE id = '\(edit_id)'
        """
    
        var update_stmt: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, (update_sql as NSString).utf8String, -1, &update_stmt, nil) != SQLITE_OK {
                print("db error1: \(db)")
                return false
            }
            
            sqlite3_bind_text(update_stmt, 1, (counseling_body as NSString).utf8String, -1, nil)
            sqlite3_bind_int(update_stmt, 2, -1)
            sqlite3_bind_text(update_stmt, 3, (complete_or_incomplete as NSString).utf8String, -1, nil)
            
            
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
