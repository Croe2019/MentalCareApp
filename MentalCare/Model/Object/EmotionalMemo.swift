//
//  EmotionalMemo.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2023/01/10.
//

import Foundation
import RealmSwift

class EmotionalMemo: Object{
    
    // 感情メモのカラム
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var memo_body: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // IDをincrementして返す
    static func NewID(realm: Realm) -> Int{
        if let emotional_memo = realm.objects(EmotionalMemo.self).sorted(byKeyPath: "id").last{
            return emotional_memo.id + 1
        }else{
            return 1
        }
    }
    
    // incrementして返す
    static func create(realm: Realm, asDummy: Bool = false) -> EmotionalMemo {
        if asDummy {
            let new_dummy_Emotional_memo: EmotionalMemo = EmotionalMemo()
            new_dummy_Emotional_memo.id = EmotionalMemo.NewID(realm: realm)
            return new_dummy_Emotional_memo
        } else {
            let lastID: Int = (realm.objects(EmotionalMemo.self).sorted(byKeyPath: "id").last?.id)!
            let dummy_emotional_memo: EmotionalMemo = realm.object(ofType: EmotionalMemo.self, forPrimaryKey: lastID)!
            let new_dummy_emotinal_memo: EmotionalMemo = EmotionalMemo.create(realm: realm, asDummy: true)
//            try! realm.write {
//                realm.add(new_dummy_emotinal_memo)
//            }
            return dummy_emotional_memo
        }
    }
}
