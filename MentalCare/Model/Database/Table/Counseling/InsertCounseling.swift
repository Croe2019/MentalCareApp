//
//  InsertCounseling.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/02/01.
//

import Foundation
import SQLite3

class InsertCounseling{
    
    private let db_file = "MentalCare.db"
    private var db: OpaquePointer?
    
    private func CreateCounselingTable(){
        
        let create_table = "CREATE TABLE Counseling (id integer primary key autoincrement, counseling_body string, counseling_paramater integer, complete_or_incomplete string, created_at date)"
        
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
    
    public func Insert(counseling_body: String, counseling_paramater: Int, complete_or_incomplete: String){
        
        OpenDB()
        CreateCounselingTable()
        let created_at = Date()
        var stmt: OpaquePointer?
        
        let query_string = "INSERT INTO Counseling (counseling_body, counseling_paramater, complete_or_incomplete, created_at) VALUES('\(counseling_body)', '\(counseling_paramater)', '\(complete_or_incomplete)', '\(created_at.ToStringWithCurrentLocale())')"
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

extension Date {

    func ToStringWithCurrentLocale() -> String {

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return formatter.string(from: self)
    }

}
