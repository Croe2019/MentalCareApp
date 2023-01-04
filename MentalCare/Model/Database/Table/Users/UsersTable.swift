//
//  UsersTable.swift
//  MentalCare
//
//  Created by 濱田広毅 on 2022/11/25.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore
import RealmSwift

class UsersTable{
    
    private var image_path = String()
    private let realm = try! Realm()
    
        
    func insert(name: String, email: String, uuid:String ,password: String){
            
            let default_image = UIImage(named: "default_image")
            let date = NSDate()
            let currentTimeStampInSecond = UInt64(floor(date.timeIntervalSince1970 * 1000))
            let storageRef = Storage.storage().reference().child("default_image").child("\(currentTimeStampInSecond).jpg")
            let metaData = StorageMetadata()
            var stmt: OpaquePointer?

            metaData.contentType = "default_image/jpg"
            if let uploadData = default_image?.jpegData(compressionQuality: 0.01){
                storageRef.putData(uploadData, metadata: metaData){(metaData, error) in
                    if error != nil{

                        print("error: \(error?.localizedDescription)")
                    }
                    storageRef.downloadURL{ url, error in
                        if error != nil{
                            print("error: \(error?.localizedDescription)")
                        }
                        self.image_path = url!.absoluteString
                        print("url: \(url!.absoluteString)")
                        let user = User.create(realm: self.realm)
                        user.individual_identification_number = uuid
                        user.user_name = name
                        user.email = email
                        user.password = password
                        user.default_image = self.image_path
                        
                        let user_data: User = User(value: ["id": user.id,
                                                           "individual_identification_number": user.individual_identification_number,
                                                           "user_name": user.user_name,
                                                           "email": user.email,
                                                           "password": user.password,
                                                           "default_image": user.default_image])
                        try! self.realm.write{
                            self.realm.add(user_data)
                        }

                        print("データが登録されました")

                    }
                }
            }
        }
    }
