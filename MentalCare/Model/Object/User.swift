//
//  User.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/12/23.
//

import Foundation
import RealmSwift

class User: Object{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var  individual_identification_number: String = "" // 各デバイスの個体識別番号
    @objc dynamic var user_name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var default_image: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // IDをincrementして返す
    static func NewID(realm: Realm) -> Int{
        if let user = realm.objects(User.self).sorted(byKeyPath: "id").last{
            return user.id + 1
        }else{
            return 1
        }
    }
    
    // incrementして返す
    static func create(realm: Realm) -> User{
        let user: User = User()
        user.id = NewID(realm: realm)
        return user
    }
}
